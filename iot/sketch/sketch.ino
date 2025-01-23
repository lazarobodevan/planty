int moistureSensors[] = {A0, A3, A4, A5}; // Array com as portas
int sensorValues[sizeof(moistureSensors) / sizeof(moistureSensors[0])];
int lightSensor = A1;
int tempSensor = A2;
int valorLeitura = 0;
int lightValue = 0;
int tempValue = 0;
int umidadePercentual = 0;

const double beta = 3600.0;
const double r0 = 10000.0;
const double t0 = 273.0 + 25.0;
const double rx = r0 * exp(-beta/t0);
 
// Parâmetros do circuito
const double vcc = 5.0;
const double R = 5000.0;
 
// Numero de amostras na leitura
const int nAmostras = 5;

void setup() {
  Serial.begin(9600);
}

void loop() {

  
  tempValue = analogRead(tempSensor);
  getLightPercentage();
  getTemperatureInCelsius(tempValue);
  getSoilMoisture();

  Serial.println("---------------------------");

  delay(3000);  // Aguarda 500 ms entre as leituras
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
    umidadePercentual = map(sensorValues[i], 673, 0, 0, 100);
     Serial.print("A");
    Serial.print(moistureSensors[i] - A0); // Converte para o formato A0, A1, etc.
    Serial.print(": ");
    Serial.println(umidadePercentual);
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
