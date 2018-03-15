
/*
  Ombrocessing

  —
  Developped and tested on : 
    - Processing 3.2.1 on MacOSX (10.12.5)

  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com

  —
  Keyboard : 
    - 'i' draws the composition
    - 'c' draws the composition with mask
    - 'a' draws animation frames
    - 'e' exports composition (with timestamp) + mask to .pdf format

*/

// ------------------------------------------------------
import processing.pdf.*;
import geomerative.*;

// ------------------------------------------------------
Scanimation scanimation;
ControlFrame cf;
int mode = 0;
int drawFrameIndex = 0;
boolean drawFrameMasked = false;

// ------------------------------------------------------
AnimationLogo animLogo;

Animation anim;
// ------------------------------------------------------
// Parameters
// float periodChangeFrame = 0.25f;
PaperSize ps1 = new PaperSize(230, 175, new float[]{35.0,35.0,35.0,35.0});
PaperSize ps2 = new PaperSize(210, 297, new float[]{10.0,10.0,10.0,10.0});
//PaperSize ps3 = new PaperSize(180, 240, new float[]{10.0}); // Test Emeline
PaperSize ps3 = new PaperSize(240, 180, new float[]{0.0}); // Test Emeline
PaperSize ps = ps3;

// ------------------------------------------------------
void settings()
{
  ps.doSize();
/*
  println(displayDensity());
  println( Utils.toMM(1) );
*/
}

// ------------------------------------------------------
void setup()
{
  initLibraries();
  // Create the Scanimation instance, which will be made of 6 frames
  scanimation = new Scanimation(this, ps, 5);

    // Animation
  animLogo = new AnimationLogo(scanimation);
  animLogo.setup();
  anim = animLogo;

  
  
  // Compose the final frame (this is calling "drawScanimationFrame" for each frame)
  scanimation.composeFinalFrame();
  // Set the animation period in seconds (use 'a' on keyboard)
  scanimation.setTimerPeriod(0.5);
  // Set background for export
  scanimation.setExportBackground(false);
    
  
  // Interface
  cf = new ControlFrame(this, 400, 800, "Controls");
  surface.setLocation(400, 10);
}

// ------------------------------------------------------
void draw()
{
  background(255);
/*  image(scanimation.maskFrame,0,0);
  return;
*/
  // Draws the composition
  if (mode == 0)
  {
    scanimation.draw();
  }
  // Draws the composition with mask
  else if (mode == 1)
  {
    scanimation.drawWithMask();
  }
  // Draws the animation
  else if (mode == 2)
  {
    scanimation.animate();
  }
  // Draws the animation
  else if (mode == 3)
  {
    scanimation.drawFrame(drawFrameIndex,drawFrameMasked);
    fill(0);
    text("frame ["+drawFrameIndex+"]",5,12);
  }
}

// ------------------------------------------------------
// Automatically called by composeFinalFrame
void drawScanimationFrame(PGraphics pg, int frame, int nbFrames)
{
    if (anim != null)
    {
      anim.draw(pg, float(frame)/float(nbFrames));
    }
  
/*    pg.translate(pg.width/2, pg.height/2);
    pg.rotate( map(frame, 0, nbFrames, 0, radians(90)) );
    pg.noStroke();
    pg.rectMode(CENTER);
    pg.rect(0,0,400,100);
    pg.ellipse(30,60,100,100);

    pg.stroke(0);
    pg.strokeWeight(1);
    pg.line(pg.width/2,0,pg.width/2,pg.height);
*/
//    println( frame + " / " + nbFrames );
/*
    pg.translate(pg.width/2, pg.height/2);
    pg.noStroke();
    pg.rectMode(CENTER);
    pg.rotate(frame * PI / (nbFrames));
    pg.rect(0,0,pg.width*0.98,100);
*/
/*    float r = 0.5*pg.width*0.8;
    pg.beginShape();
      for (float angle=0; angle<TWO_PI; angle = angle+TWO_PI/3)
        pg.vertex( r*cos(angle), r*sin(angle) );
    pg.endShape();
*/
}


// ------------------------------------------------------
void keyPressed()
{
  if (key == CODED) 
  {
    if (mode == 3)
    {
      if (keyCode == RIGHT) drawFrameIndex = (drawFrameIndex+1)%scanimation.nbFrames;
    }
  }
  
  
  if (key == 'i')
  {
    mode = 0;
  }
  else if (key == 'c')
  {
    mode = 1;
  }
  else if (key == 'a')
  {
    mode = 2;
  }
  else if (key == 'e')
  {
    scanimation.exportPDF();
  }
  else if (key == 'g')
  {
    scanimation.exportGrid();
  }
  else if (key == ' ')
  {
    scanimation.export();
  }
  else if (key == 'f')
  {
    mode = 3;
  }
}