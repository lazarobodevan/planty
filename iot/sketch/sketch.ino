int moistureSensors[] = {A0, A3, A4, A5}; // Array com as portas
int sensorValues[sizeof(moistureSensors) / sizeof(moistureSensors[0])];
int moisturePercent[sizeof(moistureSensors) / sizeof(moistureSensors[0])];
int lightSensor = A1;
int tempSensor = A2;
int valorLeitura = 0;
int lightValue = 0;
int tempValue = 0;
int umidadePercentual = 0;

int LED_G[] = {6, 6, 9, 2};  // LEDs verdes
int LED_Y[] = {7, 7, 10, 3}; // LEDs amarelos
int LED_R[] = {8, 8, 11, 4}; // LEDs vermelhos

int idealMoisture[] = {-1, -1, -1 , -1};

const double beta = 3600.0;
const double r0 = 10000.0;
const double t0 = 273.0 + 25.0;
const double rx = r0 * exp(-beta/t0);
 
// Parâmetros do circuito
const double vcc = 5.0;
const double R = 5000.0;
 
// Numero de amostras na leitura
const int nAmostras = 5;

bool ledsOn = true;
unsigned long lastLedBlinkTime = 0;      // Tempo da última execução dos LEDs
unsigned long lastOtherFunctionsTime = 0; // Tempo da última execução das outras funções

const unsigned long ledBlinkInterval = 500;       // Intervalo para os LEDs piscarem
const unsigned long otherFunctionsInterval = 3000; // Intervalo para as outras funções

bool isBlinking = false;
int blinkCount = 0;

void setup() {
  Serial.begin(9600);
  Serial.println("");
  delay(1000);
  while (Serial.available() > 0) {
    Serial.read(); // Limpa todos os dados no buffer serial
  }
  
   for (int i = 0; i < sizeof(LED_G) / sizeof(LED_G[0]); i++) {
    pinMode(LED_G[i], OUTPUT);
    pinMode(LED_Y[i], OUTPUT);
    pinMode(LED_R[i], OUTPUT);
  }

  requestServerData();
  delay(5000);

  if(Serial.available() > 0){
      String data = Serial.readStringUntil('\n');
      Serial.println(data);
      parseData(data);
  }
}
void loop() {

  if(Serial.available() > 0){
      String data = Serial.readStringUntil('\n');
      parseData(data);
  }
  
  executeReadings();
  blinkLedsWhenReceiveData();
  

}

void executeReadings(){
  static unsigned long lastReadingsTime = 0;
  unsigned long currentTime = millis();

  // Controle do tempo para as leituras
  if (currentTime - lastReadingsTime >= otherFunctionsInterval) {
    lastReadingsTime = currentTime;

    tempValue = analogRead(tempSensor);
    getLightPercentage();
    getTemperatureInCelsius(tempValue);
    getSoilMoisture();
    displayLeds();
    Serial.println("---------------------------");
  
  }
}
void requestServerData(){
  Serial.println("GET: config");
}

void parseData(String data){

  /*
  * It will always come like A0 - moisture: value
  */
  if (data.startsWith("A")) {
    int sensorId = data.substring(1, data.indexOf(" ")).toInt(); // Extrai o número do sensor (0, 1, etc.)
    int moistureStart = data.indexOf("moisture: ") + 10;
    int moisture = data.substring(moistureStart).toInt();

    for (int i = 0; i < sizeof(moistureSensors) / sizeof(moistureSensors[0]); i++) {
      if (moistureSensors[i]-A0 == sensorId) {
        idealMoisture[i] = moisture;
        Serial.print("Valores atualizados para o Sensor ");
        Serial.print("A");
        Serial.print(i);  // Mostrar o índice do sensor no array
        Serial.print(": Ideal ");
        Serial.println(moisture);
        
        isBlinking = true;
        blinkCount = 0;

        break;
      }
    }

  }else if(data.startsWith("LED")){
    if(data == "LED: On"){
      ledsOn = true;
    }else{
      ledsOn = false;
    }
  }else {
    Serial.println("Formato inválido!");
  }
}

void blinkLedsWhenReceiveData() {
  unsigned long currentMillis = millis();

  // Só faz qualquer coisa se o piscar estiver ativado
  if (isBlinking) {
    // Verifica se o intervalo de 500ms passou
    if (currentMillis - lastLedBlinkTime >= ledBlinkInterval) {
      lastLedBlinkTime = currentMillis;

      // Realiza a piscada até 8 vezes (4 piscadas completas, considerando que cada LED pisca 2 vezes)
      if (blinkCount < 8) {
        // Inverte o estado de todos os LEDs
        for (int i = 0; i < 4; i++) {
          bool isOn = digitalRead(LED_G[i]) == HIGH;
          digitalWrite(LED_G[i], isOn ? LOW : HIGH);
          digitalWrite(LED_Y[i], isOn ? LOW : HIGH);
          digitalWrite(LED_R[i], isOn ? LOW : HIGH);
        }
        blinkCount++;
      } else {
        // Depois de 8 piscadas, desativa o piscar
        isBlinking = false;
      }
    }
  }
}




void displayLeds(){

  if(ledsOn == false || isBlinking) return;

  for(int i = 0; i < sizeof(LED_G) / sizeof(LED_G[0]); i++) {
    int moisture = moisturePercent[i];
    int currentIdealMoisture = idealMoisture[i];
    float green_offset_up = 1.1;
    float green_offset_down = 0.9;
    float yellow_offset_up = 1.2;
    float yellow_offset_down = 0.8;

    // Verifique se a umidade está dentro do intervalo esperado (não negativa)
    if (currentIdealMoisture >= 0) {
      Serial.println(moisture);

      // Verifique se o valor da umidade está dentro da faixa verde
      if (moisture >= currentIdealMoisture * green_offset_down && moisture <= currentIdealMoisture * green_offset_up) {
        digitalWrite(LED_G[i], HIGH);
        digitalWrite(LED_Y[i], LOW);
        digitalWrite(LED_R[i], LOW);
      }
      // Verifique se o valor da umidade está fora da faixa verde, mas dentro da faixa amarela
      else if (moisture >= currentIdealMoisture * yellow_offset_down && moisture <= currentIdealMoisture * yellow_offset_up) {
        digitalWrite(LED_G[i], LOW);
        digitalWrite(LED_Y[i], HIGH);
        digitalWrite(LED_R[i], LOW);
      }
      // Caso contrário, a umidade está muito fora da faixa, acende o LED vermelho
      else {
        digitalWrite(LED_G[i], LOW);
        digitalWrite(LED_Y[i], LOW);
        digitalWrite(LED_R[i], HIGH);
      }
    } else {
      // Se o valor da umidade for inválido (negativo), apaga todos os LEDs
      digitalWrite(LED_G[i], LOW);
      digitalWrite(LED_Y[i], LOW);
      digitalWrite(LED_R[i], LOW);
    }
  }

}

double getTemperatureInCelsius(int thermistorOutput){
  int thermistor_adc_val;
  double output_voltage, thermistor_resistance, therm_res_ln, temperature; 
  thermistor_adc_val = thermistorOutput;
  output_voltage = ( (thermistor_adc_val * 5.0) / 650.0 );
  thermistor_resistance = ( ( 5 * ( 10.0 / output_voltage ) ) - 10 ); /* Resistance in kilo ohms */
  thermistor_resistance = thermistor_resistance * 1000 ; /* Resistance in ohms   */
  therm_res_ln = log(thermistor_resistance);
  /*  Steinhart-Hart Thermistor Equation: */
  /*  Temperature in Kelvin = 1 / (A + B[ln(R)] + C[ln(R)]^3)   */
  /*  where A = 0.001129148, B = 0.000234125 and C = 8.76741*10^-8  */
  temperature = ( 1 / ( 0.001129148 + ( 0.000234125 * therm_res_ln ) + ( 0.0000000876741 * therm_res_ln * therm_res_ln * therm_res_ln ) ) ); /* Temperature in Kelvin */
  temperature = temperature - 273.15; /* Temperature in degree Celsius */
  Serial.print("Temp: ");
  Serial.print(temperature);
  Serial.print("\n");
  return temperature;
}

void getSoilMoisture(){

  for (int i = 0; i < sizeof(moistureSensors) / sizeof(moistureSensors[0]); i++) {
    sensorValues[i] = analogRead(moistureSensors[i]);
  }
  for (int i = 0; i < sizeof(sensorValues) / sizeof(sensorValues[0]); i++) {
    // Mapeia a leitura de umidade de 0-600 para 0-100%
    umidadePercentual = map(sensorValues[i], 673, 330, 0, 100);
    moisturePercent[i] = umidadePercentual;
     Serial.print("A");
    Serial.print(moistureSensors[i] - A0); // Converte para o formato A0, A1, etc.
    Serial.print(": ");
    Serial.print(umidadePercentual);
    Serial.print(" - Ideal: ");
    Serial.println(idealMoisture[i]);
  }
}

void getLightPercentage(){
  const int fixedResistor = 1000;
  int adcValue = analogRead(lightSensor);
  double voltage = (adcValue * vcc) / 1023.0;
  double photoResistor = fixedResistor * ((vcc / voltage) - 1);

  // Conversão simples (substitua pela sua tabela de calibração)
  double lux = convertResistanceToLux(photoResistor);

  Serial.print("Lux: ");
  Serial.println(lux);
}

double convertResistanceToLux(double resistance) {
  if (resistance > 80000) return 0; 
  if (resistance > 10000) return 500;   // Baixa luz (~500 lux)
  if (resistance > 5000) return 2000;  // Média luz (~2000 lux)
  if (resistance > 1000) return 10000; // Alta luz (~10.000 lux)
  return 50000;                        // Pleno sol (~50.000 lux)
}


