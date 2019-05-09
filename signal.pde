
class Signal {
  Strip strip;
  float signalSpeed = 1.0;
  int signalEnd = 70;
  int lastMillis = 0;
  String signalPattern = "1";
  color signalColor = color(255, 255, 255);
  int signalStartPos = 0;
  public boolean isFinished = false;
  
  Signal(Strip strip, String signalPattern, int signalEnd, color signalColor, float signalSpeed) {
    lastMillis = millis();
    this.signalEnd = signalEnd;
    this.strip = strip;
    this.signalPattern = signalPattern;
    this.signalColor = signalColor;
    this.signalSpeed = signalSpeed;
  }
  
  public void update() {
    for (int i = 0; i < signalEnd; i++) {
       if (i < signalStartPos || i >= signalStartPos + signalPattern.length()) {
         continue;
       }
       else if (signalPattern.charAt(i - signalStartPos) != '0') {
         strip.setPixel(signalColor, signalEnd - 1 - i);
       }
    }
    
    if (millis() > lastMillis + signalSpeed * 1000) {
      signalStartPos++;
      lastMillis = millis();
    }
    
    if (signalStartPos >= strip.getLength()) {
      isFinished = true;
    }
  }
}
