#include <Encoder.h>

#define ENC_A 2
#define ENC_B 3
#define VOL_UP 8
#define VOL_DOWN 9
#define LED 13

#define BUTTON_PRESS_DELAY 100

Encoder encoder(ENC_A, ENC_B);
int lastValue = 0;

void setup() {         
  pinMode(VOL_UP, OUTPUT);
  digitalWrite(VOL_UP, HIGH);

  pinMode(VOL_DOWN, OUTPUT);
  digitalWrite(VOL_DOWN, HIGH);

  pinMode(LED, OUTPUT);
}

void loop() {
  int value = encoder.read();
  if (value < lastValue) {
    digitalWrite(VOL_UP, LOW);
    digitalWrite(LED, HIGH);
    delay(BUTTON_PRESS_DELAY);
    digitalWrite(VOL_UP, HIGH);
    digitalWrite(LED, LOW);
  } else if (value > lastValue) {
    digitalWrite(VOL_DOWN, LOW);
    digitalWrite(LED, HIGH);
    delay(BUTTON_PRESS_DELAY);
    digitalWrite(VOL_DOWN, HIGH);
    digitalWrite(LED, LOW);
  }
  lastValue = value;
}
