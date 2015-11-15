#ifndef _button_h_
#define _button_h_

class Button {
  
  private:
    int _pin;
    void (*_pressAction)();
    void (*_releaseAction)();
    
    int _buttonState;
    int _lastBounceState;
    unsigned long _lastBounceTime;
  
  public:
    Button(int pin, void (*pressAction)(), void (*releaseAction)() = NULL);
    void check();
    
};
  
#endif
