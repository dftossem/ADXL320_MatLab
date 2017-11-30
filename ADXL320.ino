/*
  ADXL3xx

  Reads an Analog Devices ADXL3xx accelerometer and communicates the
  acceleration to the computer. The pins used are designed to be easily
  compatible with the breakout boards from SparkFun, available from:
  http://www.sparkfun.com/commerce/categories.php?c=80

  The circuit:
  - analog 0: accelerometer self test
  - analog 2: y-axis
  - analog 3: x-axis3

  created 2 Jul 2008
  by David A. Mellis
  modified 30 Aug 2011
  by Tom Igoe
  modified 17 Nov 2017
  by David Tosse

  This example code is in the public domain.

  http://www.arduino.cc/en/Tutorial/ADXL3xx
*/

// these constants describe the pins. They won't change:

const int xpin = A3;                  // x-axis
const int ypin = A2;                  // y-axis

int rollHztl, pitchHztl, rollNew, pitchNew;
float changeR, changeP;

void setup() {
  // initialize the serial communications:
  Serial.begin(9600);
  // 336 because is the value on inputs
  // when sensor is horizontal
  rollHztl = 336;
  pitchHztl = 336;
}

void loop() {
  // print the sensor values:
  pitchNew = analogRead(xpin);                  // get x-axis reading
  rollNew = analogRead(ypin);                   // get y-axis reading
  // 36.5 is almost 178 mV
  changeR = (rollNew-rollHztl)/36.5;             // working on g [m/s^2]
  changeP = (pitchNew-pitchHztl)/36.5;           // working on g [m/s^2]
  // send values by serial
  Serial.print(changeP);
  Serial.print(",");
  Serial.println(changeR);
  //Serial.println(";");
  // UNCOMMENT FOR 2D PLOT FROM HERE
  rollHztl = rollNew;
  pitchHztl = pitchNew;
  // TO HERE
  delay(100);                                   // Ten times greater than matlab pause
}
