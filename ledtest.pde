import com.heroicrobot.dropbit.registry.*; 
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel; 
import com.heroicrobot.dropbit.devices.pixelpusher.Strip; 
import java.util.*;

class TestObserver implements Observer {
   public boolean hasStrips = false; 
   public void update(Observable registry, Object updatedDevice) { 
     println("Registry changed!"); 
     if (updatedDevice != null) { 
       println("Device change: " + updatedDevice); 
     } 
     this.hasStrips = true; 
   }
};

DeviceRegistry registry;
TestObserver testObserver;
List<Strip> strips;
ArrayList<Signal> signals = new ArrayList<Signal>();
boolean registryInitialized = false;

void setupLED() {
  registry = new DeviceRegistry(); 
  testObserver = new TestObserver(); 
  registry.addObserver(testObserver);
}

void flushPixels() {
  for(int i = 0; i < strips.size(); i++) {
    Strip thisStrip = strips.get(i);
    for (int j = 0; j < thisStrip.getLength(); j++) {
       thisStrip.setPixel(color(0, 0, 0), j);
    }
  } 
}

void drawLED() {
  if (!testObserver.hasStrips) {
    return;
  }
  
  registry.startPushing();
  strips = registry.getStrips(0);
  flushPixels();
  
  for(int i = 0; i < signals.size(); i++) {
    signals.get(i).update();
    if (signals.get(i).isFinished) {
      signals.remove(i);
    }
  }
  //print("size of strips is " + strips.size());
 
  
  //print("Recognized stirp!!");
}

void sendSignalOne() {
  if (strips == null) return;
  if (strips.size() < 1) return;
  Strip thisStrip = strips.get(0);
  signals.add(new Signal(thisStrip, "111", 80, color(255, 0, 255), random(0.003, 0.02)));
}

void sendSignalTwo() {
  if (strips == null) return;
  if (strips.size() < 2) return;
  Strip thisStrip = strips.get(1);
  signals.add(new Signal(thisStrip, "1", 73, color(255, 0, 0), random(0.003, 0.02)));
}

void sendSignalThree() {
  if (strips == null) return;
  if (strips.size() < 3) return;
  Strip thisStrip = strips.get(2);
  signals.add(new Signal(thisStrip, "11", 50, color(255, 255, 255), random(0.003, 0.02)));
}
