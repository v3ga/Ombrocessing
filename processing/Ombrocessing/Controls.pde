import controlP5.*;

class ControlFrame extends PApplet 
{

  int w, h;
  PApplet parent;
  ControlP5 cp5;
  Scanimation scanimation;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) 
  {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    scanimation = ((Ombrocessing)parent).scanimation;
    
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() 
  {
    surface.setLocation(0, 10);
    cp5 = new ControlP5(this);
    
    cp5.addSlider("periodChangeFrame")
       .plugTo(scanimation, "periodChangeFrame")
       .setPosition(5, 15)
       .setSize(300, 30)
       .setRange(0.05, 0.5)
       .setValue(0.2);
       
/*    cp5.addKnob("blend")
       .plugTo(parent, "c3")
       .setPosition(100, 300)
       .setSize(200, 200)
       .setRange(0, 255)
       .setValue(200);
       
    cp5.addNumberbox("color-red")
       .plugTo(parent, "c0")
       .setRange(0, 255)
       .setValue(255)
       .setPosition(100, 10)
       .setSize(100, 20);
       
    cp5.addNumberbox("color-green")
       .plugTo(parent, "c1")
       .setRange(0, 255)
       .setValue(128)
       .setPosition(100, 70)
       .setSize(100, 20);
       
    cp5.addNumberbox("color-blue")
       .plugTo(parent, "c2")
       .setRange(0, 255)
       .setValue(0)
       .setPosition(100, 130)
       .setSize(100, 20);
       
    cp5.addSlider("speed")
       .plugTo(parent, "speed")
       .setRange(0, 0.1)
       .setValue(0.01)
       .setPosition(100, 240)
       .setSize(200, 30);
*/       
  }

  void draw() {
    background(190);
  }
}