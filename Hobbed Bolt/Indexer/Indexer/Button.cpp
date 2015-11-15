#include <Arduino.h>
#include "button.h"

#define BOUNCE_TIME_MILLIS 5

Button::Button(int pin, void pressAction(), void releaseAction()) {
  _pin = pin;
  _pressAction = pressAction;
  _releaseAction = releaseAction;
  _buttonState = HIGH;
  _lastBounceState = HIGH;
  _lastBounceTime = millis();
}

void Button::check() {
  int value = digitalRead(_pin);
  
  if( value != _lastBounceState ) {
    _lastBounceTime = millis();
  }
  
  if( (millis() - _lastBounceTime) > BOUNCE_TIME_MILLIS ) {
    if( value != _buttonState ) {
      _buttonState = value;
      
      if( _buttonState == LOW && _pressAction != NULL ) {
        _pressAction();
      }
      if( _buttonState == HIGH && _releaseAction != NULL ) {
        _releaseAction();
      }
    }
  }
  
  _lastBounceState = value;
}

