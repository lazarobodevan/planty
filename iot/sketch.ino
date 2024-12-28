int sensorPin = A0;  // Pino onde o sensor de temperatura está conectado
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



  valorLeitura = analogRead(sensorPin);  // Lê o valor do sensor de umidade
  lightValue = analogRead(lightSensor);  // Lê o valor do sensor de luz
  

  // Mapeia a leitura de umidade de 0-600 para 0-100%
  umidadePercentual = map(valorLeitura, 673, 0, 0, 100);

  

  Serial.print("Valor do sensor de umidade: ");
  Serial.print(valorLeitura);
  Serial.print(" -> Umidade: ");
  Serial.print(umidadePercentual);
  Serial.println("%");
  Serial.print("Valor do sensor de luz: ");
  Serial.println(lightValue);

  // Le o sensor algumas vezes
  int soma = 0;
  for (int i = 0; i < nAmostras; i++) {
    soma += analogRead(tempSensor);
    delay (10);
  }
 
  // Determina a resistência do termistor
  double v = (vcc*soma)/(nAmostras*1024.0);
  double rt = (vcc*R)/v - R;
 
  // Calcula a temperatura
  double t = beta / log(rt/rx);
  t -= 273;
  //Imprime no monitor serial o texto e a temperatura lida pelo sensor
  Serial.print("Temperatura: ");
  Serial.print(t);
  Serial.println(" °C");
  delay(500);  // Aguarda 500 ms entre as leituras
}
