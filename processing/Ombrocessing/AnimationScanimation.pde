// --------------------------------------------------
class AnimationScanimation extends Animation
{
  // Paramètre
  float amplitude = 50.0;  

  AnimationScanimation(Scanimation scan)
  {
    super(scan, "___NOM___", "___TITRE___");
  }

  // Initialisation de l'animation
  void setup()
  {
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);

    // Bien noter que l'on utilise pg
    pg.rectMode(CENTER);
    pg.rect(pg.width/2, pg.height/2, 200 + t*amplitude, 200);
  }

  // Crée les controles
  void createControls(ControlP5 cp5, float y)
  {
    // cp5.addSlider("amplitude").setPosition(5,y).setSize(200,20).plugTo(this, "setAmplitude");
  }

  void setAmplitude(float v)
  {
    this.amplitude = v;
    scanimation.composeFinalFrame();
  }
}