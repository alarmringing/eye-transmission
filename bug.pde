class Bug {
  
  int lifeTime = 30;
  int birthTime;
  boolean isDead = false;
  
  PVector homingCenter = new PVector();
  color bugColor;
  float finalDistanceFromCenter = 10;
  int size = 20;
  float rotationRate;
  float closingRate;
  float distanceFromCenter = 0;
  float rotation = 0;
  
  Bug(PVector destination, color bugColor) {
    birthTime = millis();
    homingCenter = destination;
    this.bugColor = bugColor;
    finalDistanceFromCenter = random(10, 100);
    size = (int) random(10, 40);
    rotationRate = random(0.013, 0.04);
    closingRate = random(0.98, 0.992);
    distanceFromCenter = PVector.dist(homingCenter, generationPoint);
    rotation = 0;
  }

  void render() {
    
    PVector newPoint = PVector.sub(generationPoint, homingCenter).setMag(distanceFromCenter);

    pushMatrix();
    
    translate(homingCenter.x, homingCenter.y);
    rotate(rotation);
    fill(bugColor);
    ellipse(newPoint.x + random(-9, 9), newPoint.y + random(-9, 9), size, size);
    popMatrix();
    
    distanceFromCenter = max(finalDistanceFromCenter, distanceFromCenter*closingRate);
    rotation += rotationRate;
    
    if (millis() > birthTime + lifeTime * 1000) {
      isDead = true;
    }
  }
}

class Fly {
  
  int lifeTime = 30;
  int birthTime;
  boolean isDead = false;
  
  float size;
  float timeUntilAnchorChange = 1;
  float timeLastAnchorChange;
  PVector anchor = new PVector();
  PVector currentLocation = new PVector();
  
  Fly() {
    birthTime = millis();
    timeUntilAnchorChange = random(0.3, 1);
    timeLastAnchorChange = millis();
    size = random(7, 15);
    currentLocation = generationPoint;
  }
  
  void setNewAnchor() {
    anchor.x = random(0,  windowWidth);
    anchor.y = random(0,  windowHeight);
  }
  
  void updateLocation() {
    if (millis() > timeLastAnchorChange + timeUntilAnchorChange * 1000) {
      setNewAnchor();
      timeLastAnchorChange = millis();
    }
    
    float dist = PVector.dist(anchor, currentLocation);
    PVector headToAnchor = PVector.sub(anchor, currentLocation);
    currentLocation = PVector.sub(anchor, headToAnchor.setMag(dist * 0.98));

  }
  
  void render() {
    updateLocation();
    fill(0, 255, 0);
    ellipse(currentLocation.x+ random(-3, 3), currentLocation.y + random(-3, 3), size, size);
    
    if (millis() > birthTime + lifeTime * 1000) {
      isDead = true;
    }
  }
}

class Mosaic {
  
  PVector destination = new PVector();
  int sizeX = 20; 
  int sizeY = 20;
  float distanceFromDestination;
  float closeInSpeed;
  float blinkProb = 0.2;
  
  Mosaic() {
    sizeX = (int) random(40, 120);
    sizeY = (int) random(40, 120);
    destination.x = random(0 + sizeX,  windowWidth - sizeX);
    destination.y = random(0 + sizeY,  windowHeight - sizeY);
    closeInSpeed = random(0.98, 0.994);
    distanceFromDestination = PVector.dist(destination, generationPoint);
    blinkProb = random(0, 0.8);
  }
  
  void render() {
    if (random(1) < blinkProb) return;
    PVector direction = PVector.sub(destination, generationPoint);
    PVector currentPos = PVector.sub(destination, direction.setMag(distanceFromDestination));
    
    fill(0, 0, 255);
    rect(currentPos.x, currentPos.y, sizeX, sizeY);
    distanceFromDestination *= closeInSpeed;
  
  }
}
