#include <Arduino.h>
#include <AccelStepper.h>
#include "button.h"

#define PIN_DIR    2
#define PIN_STEP   3
#define PIN_SLEEP  4
#define PIN_RESET  5
#define PIN_MS3    6
#define PIN_MS2    7
#define PIN_MS1    8
#define PIN_ENABLE 9
#define PIN_LEDGND 12
#define PIN_LED    13

#define PIN_BUTTON_OUT   A0
#define PIN_STEP_BUTTON  A1
#define PIN_RUN_BUTTON   A3
#define PIN_HOME_BUTTON  A2


#define FULL_ROTATION_STEPS ((200L/20L)*36L*16L) // 200 steps, 20/36 belt ratio, 16 microsteps
#define NUM_INDEX 20
#define INDEX_STEPS (FULL_ROTATION_STEPS/NUM_INDEX)
#define RUN_SPEED (FULL_ROTATION_STEPS / 5L)
#define MOVE_SPEED (FULL_ROTATION_STEPS * 2L)

#define MODE_STEP 0
#define MODE_RUN 1

void doStep();
void doRun();
void doHome();

Button buttons[] = {
  Button(PIN_STEP_BUTTON, doStep),
  Button(PIN_RUN_BUTTON, doRun),
  Button(PIN_HOME_BUTTON, doHome)
};
int num_buttons = sizeof(buttons)/sizeof(Button);

int mode = MODE_STEP;
long targetPosition = 0;
  
AccelStepper stepper(AccelStepper::DRIVER, PIN_STEP, PIN_DIR);

void setup() {
  pinMode(PIN_MS1, OUTPUT);
  pinMode(PIN_MS2, OUTPUT);
  pinMode(PIN_MS3, OUTPUT);
  pinMode(PIN_SLEEP, OUTPUT);
  pinMode(PIN_RESET, OUTPUT);
  
  
  pinMode(PIN_BUTTON_OUT, OUTPUT);
  digitalWrite(PIN_BUTTON_OUT, 0);
  pinMode(PIN_STEP_BUTTON, INPUT_PULLUP);
  pinMode(PIN_RUN_BUTTON, INPUT_PULLUP);
  pinMode(PIN_HOME_BUTTON, INPUT_PULLUP);
  
  pinMode(PIN_LED, OUTPUT);
  pinMode(PIN_LEDGND, OUTPUT);
  digitalWrite(PIN_LEDGND, LOW);
  
  digitalWrite(PIN_SLEEP, 1);  
  digitalWrite(PIN_RESET, 1);
  digitalWrite(PIN_MS1, 1);
  digitalWrite(PIN_MS2, 1);
  digitalWrite(PIN_MS3, 1);
  
  stepper.setEnablePin(PIN_ENABLE);
  stepper.setPinsInverted(0,0,1);
  
  stepper.enableOutputs();

  stepper.setMaxSpeed(MOVE_SPEED * 2);
  stepper.setSpeed(RUN_SPEED);
  stepper.setAcceleration(20000);
  stepper.moveTo(0);
}

void checkButtons() {
  for( int i=0; i < num_buttons; i++ ) {
    buttons[i].check();
  }
}

void loop() {
  if( MODE_STEP == mode ) {
    stepper.run();
    digitalWrite(PIN_LED, stepper.distanceToGo() > 0);
  }
  if( MODE_RUN == mode ) {
    stepper.runSpeed();
    digitalWrite(PIN_LED, HIGH);
  }

  checkButtons();
}

void doStep() {
  if( mode == MODE_RUN ) {
    targetPosition = nextRotation();
  } else {
    targetPosition += INDEX_STEPS;
  }
  
  mode = MODE_STEP;
  stepper.moveTo(targetPosition);
}

void doRun() {
  mode = MODE_RUN;
  stepper.setSpeed(RUN_SPEED);
}

void doHome() {
  mode = MODE_STEP;
  targetPosition = nextRotation();
  stepper.moveTo(targetPosition);
}

long nextRotation() {
  return (stepper.currentPosition() / FULL_ROTATION_STEPS) * FULL_ROTATION_STEPS + FULL_ROTATION_STEPS;
}
