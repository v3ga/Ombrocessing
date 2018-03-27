/*
  Ombrocessing
 www.ombrocessing.org
 
 —
 Developped and tested on : 
 - Processing 3.2.1 on MacOSX (10.12.5)
 
 —
 Julien @v3ga Gachadoat
 www.v3ga.net
 www.2roqs.com
 
 */

// ------------------------------------------------------
// Parameters
// float periodChangeFrame = 0.25f;
PaperSize psNormal = new PaperSize(240, 175, new float[]{10.0});
PaperSize psBordsPerdus = new PaperSize(250, 190, new float[]{0.0});
PaperSize ps = psNormal;

// ------------------------------------------------------
Scanimation scanimation;
ControlFrame cf;
int mode = 0;
int drawFrameIndex = 0;
boolean drawFrameMasked = false;

// ------------------------------------------------------
AnimationScanimation animScanimation;
AnimationGrid animGrid;
AnimationRing animRing;
AnimationRingMultiple animRingMultiple;
AnimationLogo animLogo;
AnimationTypo animTypo;
Animation anim;

// ------------------------------------------------------
// Colors
String[] ombroColors = {"1B495B", "8C959C", "B5C8C6", "696A6E", "57565B", "925C4F", "A5806A", "FCD79E", "F9B17B", "F6BFC7", "F077A0", "8061AF", "858AC7", "C89FCC", "3EA96B", "0A6A4B", "63A870", "7DCAB5"};
PImage logo;
PFont font15, font30;

// ------------------------------------------------------
void settings()
{
  ps.doSize();
}

// ------------------------------------------------------
void setup()
{
  initLibraries();
  initMedias();

  // Create the Scanimation instance, which will be made of 6 frames
  scanimation = new Scanimation(this, ps, 5);

  // Animation
  animScanimation = new AnimationScanimation(scanimation);
  animScanimation.setup();

  animGrid = new AnimationGrid(scanimation);
  animGrid.setup();

  animRing = new AnimationRing(scanimation);
  animRing.setup();

  animRingMultiple = new AnimationRingMultiple(scanimation);
  animRingMultiple.setup();
  
  animTypo = new AnimationTypo(scanimation);
  animTypo.setup();

  animLogo = new AnimationLogo(scanimation);
  animLogo.setup();

  anim = animTypo;

  // Compose the final frame (this is calling "drawScanimationFrame" for each frame)
  scanimation.composeFinalFrame();
  // Set the animation period in seconds (use 'a' on keyboard)
  scanimation.setTimerPeriod(0.5);
  // Set background for export
  scanimation.setExportBackground(false);

  // Interface
  cf = new ControlFrame(this, 500, height, "Controls");
  surface.setLocation(500, 10);
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
    scanimation.drawFrame(drawFrameIndex, drawFrameMasked);
    fill(0);
    text("frame ["+drawFrameIndex+"]", 5, 12);
  }
}

// ------------------------------------------------------
// Automatically called by composeFinalFrame
void drawScanimationFrame(PGraphics pg, int frame, int nbFrames)
{
  if (anim != null)
  {
    anim.draw(pg, frame, nbFrames);
  }
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
  } else if (key == 'c')
  {
    mode = 1;
  } else if (key == 'a')
  {
    mode = 2;
  } else if (key == 'e')
  {
    scanimation.exportPDF();
  } else if (key == 'g')
  {
    scanimation.exportGrid();
  } else if (key == ' ')
  {
    scanimation.exportTransparent();
  } else if (key == 'f')
  {
    mode = 3;
  }
}