import codeanticode.syphon.*;
//import oscP5.*;

SyphonServer server;

//OscP5 oscP5;

int windowWidth = 1200;
int windowHeight = 800;
PVector center = new PVector(windowWidth / 2, windowHeight / 2);

PVector generationPoint = new PVector(30, 800);
PVector eyeEdgePoint = new PVector(230, 470);

ArrayList<Bug> signalOnes = new ArrayList<Bug>();
ArrayList<Fly> signalTwos = new ArrayList<Fly>();
ArrayList<Bug> signalThrees = new ArrayList<Bug>();

int lastDamaged = millis();
int damageFadeTime = 600;

//NetAddress myRemoteLocation;

void setup() {
  size(1200, 800, P3D);
  noStroke();
  
  setupLED();

  server = new SyphonServer(this, "ProcessingSyphon");
  //oscP5 = new OscP5(this, 8000);
  //myRemoteLocation = new NetAddress("", 12345);
  
}

void draw() {
  drawLED();
  color bkgColor = color(0, 0, 0);
  if (millis() < lastDamaged + damageFadeTime) {
    float gradation = 1 - (float) (millis() - lastDamaged) / damageFadeTime;
    bkgColor = color(255*gradation, 255*gradation, 0);
  }
  background(bkgColor);
  //ellipse(generationPoint.x, generationPoint.y, 20, 20);
  ellipse(mouseX, mouseY, 20, 20);
  renderSignalOnes();
  renderSignalTwos();
  renderSignalThrees();
  server.sendScreen();
}

void keyPressed() {
  
  lastDamaged = millis();
  
  if (key == 'a') {
    signalOnes.add(new Bug(center, color(255, 0, 0)));
    sendSignalOne();
  }
    if (key == 's') {
    signalTwos.add(new Fly());
    sendSignalTwo();
  }
    if (key == 'd') {
    signalThrees.add(new Bug(eyeEdgePoint, color(0, 0, 255)));
    sendSignalThree();
  }
}

void renderSignalOnes() {
  for(int i = 0; i < signalOnes.size(); i++) {
    signalOnes.get(i).render();
    if (signalOnes.get(i).isDead) {
      signalOnes.remove(i);
    }
  }
}

void renderSignalTwos() {
  for(int i = 0; i < signalTwos.size(); i++) {
    signalTwos.get(i).render();
     if (signalTwos.get(i).isDead) {
      signalTwos.remove(i);
    }
  }
}

void renderSignalThrees() {
  for(int i = 0; i < signalThrees.size(); i++) {
    signalThrees.get(i).render();
    if (signalThrees.get(i).isDead) {
      signalThrees.remove(i);
    }
  }
}

/*
void oscEvent(OscMessage theOscMessage) {  
  print ("addrpattern: " + theOscMessage.addrPattern());
  println("typetag: "+theOscMessage.typetag());
  switch(theOscMessage.addrPattern()) {
    case "/transmission/signal1":
      signalOnes.add(new Bug(center, color(255, 0, 0)));
      sendSignalOne();
      break;
    case "/transmission/signal2":
      signalTwos.add(new Fly());
      sendSignalTwo();
      break;
    case "/transmission/signal3":
      signalThrees.add(new Bug(eyeEdgePoint, color(0, 0, 255)));
      sendSignalThree();
      break;
  }
}
*/
