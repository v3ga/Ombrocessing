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
PaperSize ps = psBordsPerdus;

// ------------------------------------------------------
Scanimation scanimation;
ControlFrame cf;
int mode = 0;
int drawFrameIndex = 0;
boolean drawFrameMasked = false;

// ------------------------------------------------------
ArrayList<Animation> anims = new ArrayList<Animation>();
Animation anim;

/*
AnimationScanimation animScanimation;
AnimationGrid animGrid;
AnimationRing animRing;
AnimationRingMultiple animRingMultiple;
AnimationLogo animLogo;
AnimationTypo animTypo;
*/

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

  // Animations
  anims.add( new AnimationLogo(scanimation) );
  anims.add( new AnimationCeline(scanimation,0) );
  anims.add( new AnimationCeline(scanimation,1) );
  anims.add( new AnimationPyramids(scanimation) );
  anims.add( new AnimationCubes(scanimation) );
  anims.add( new AnimationSpheres(scanimation) );
  anims.add( new AnimationBurgers(scanimation) );
  anims.add( new AnimationMistral(scanimation) );
  anims.add( new AnimationCypraeaMappa(scanimation) );
  anims.add( new AnimationTournesol(scanimation) );
  anims.add( new AnimationMelanie(scanimation) );
  anims.add( new buddha(scanimation) );
  anims.add( new AnimationRebecca(scanimation,0) );
  anims.add( new AnimationRebecca(scanimation,1) );
  anims.add( new AnimationTourbillon(scanimation) );
  anims.add( new AnimationWave(scanimation) );
  anims.add( new AnimationSauron(scanimation) );

  for (Animation anim : anims) anim.setup();
  
  anim = anims.get(0);
 
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
  
  // Draws infos
  if (anim != null)
  {
    float wCredits = 180, hCredits = 50;
    float margin = 5;
    
    pushStyle();
    noStroke();
    fill(0,180);
    pushMatrix();
    translate(5,height-hCredits-5);
    rect(0,0,wCredits,hCredits);
    fill(255);
    textFont(font15);
    text(anim.author + "\n" + anim.name,margin,margin,wCredits-2*margin,hCredits-2*margin);
    popMatrix();
    popStyle();
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
/*    if (mode == 3)
    {
      if (keyCode == RIGHT) drawFrameIndex = (drawFrameIndex+1)%scanimation.nbFrames;
    }
*/
    if (keyCode == RIGHT)
    {
      int index = (anims.indexOf(anim)+1)%anims.size();
      anim = anims.get(index);
      scanimation.composeFinalFrame();
    }
    else if (keyCode == LEFT) 
    {
      int index = anims.indexOf(anim)-1;
      if (index < 0) index = anims.size()-1;
      anim = anims.get(index);
      scanimation.composeFinalFrame();
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