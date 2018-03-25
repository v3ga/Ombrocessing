// ------------------------------------------------------
class Scanimation
{
  int nbFrames;
  PApplet applet;
  Method methodFrame;

  ArrayList<PGraphics> listFrames;
  ArrayList<PGraphics> listMaskedFrames;
  PGraphics compositionFrame;
  PGraphics maskFrame, maskFrameScreen, currentFrame;

  Timer timer;
  float periodChangeFrame = 0.25f; // seconds
  float timeChangeFrame=0.0f;  
  int framePlaying = 0;

  boolean exportCompo = false;
  boolean bExportCompoBackground = false;

  int frameWidth, frameHeight; 
  int frameX, frameY; 
  
  int scale = 1;

  // ------------------------------------------------------
  Scanimation(PApplet applet, int nbFrames)
  {
    this.applet = applet;
    this.nbFrames = nbFrames;
    this.frameWidth = applet.width;
    this.frameHeight = applet.height;
    this.frameX = this.frameY = 0;

    createFrames();
    findMethodFrame();
    createTimer();
  }

  // ------------------------------------------------------
  Scanimation(PApplet applet)
  {
    this.applet = applet;
    this.nbFrames = 5;
    this.frameWidth = applet.width;
    this.frameHeight = applet.height;
    this.frameX = this.frameY = 0;
    
    createFrames();
    findMethodFrame();
    createTimer();
  }

  // ------------------------------------------------------
  Scanimation(PApplet applet, PaperSize ps, int nbFrames)
  {
    this.applet = applet;
    this.nbFrames = nbFrames;
    this.frameWidth = ps.wpx / scale;
    this.frameHeight = ps.hpx / scale;
    this.frameX = ps.xpx;
    this.frameY = ps.ypx;

    createFrames();
    findMethodFrame();
    createTimer();
}  

  // ------------------------------------------------------
  void setExportBackground(boolean is)
  {
    this.bExportCompoBackground = is;
  }
  
  // ------------------------------------------------------
  void createFrames()
  {
    listFrames = new ArrayList<PGraphics>();
    listMaskedFrames = new ArrayList<PGraphics>(); 
    for (int i=0;i<nbFrames;i++) {
      listFrames.add( createGraphics(this.frameWidth, this.frameHeight) );
      listMaskedFrames.add( createGraphics(this.frameWidth, this.frameHeight) );
    }

    compositionFrame = createGraphics(this.frameWidth, this.frameHeight);
    maskFrame = createGraphics(this.frameWidth, this.frameHeight);
    maskFrameScreen = createGraphics(this.frameWidth, this.frameHeight);


    maskFrameScreen.beginDraw();
    drawMaskStripes(maskFrameScreen,0);
    maskFrameScreen.endDraw();
  }


  // ------------------------------------------------------
  void makeMaskFrame(int index)
  {
    maskFrame.beginDraw();
    maskFrame.background(255);
    drawMaskStripes(maskFrame,index);
    maskFrame.endDraw();
  }


  // ------------------------------------------------------
  void drawMaskStripes(PGraphics maskFrame, int xoffset)
  {
    maskFrame.rectMode(CORNER);
    maskFrame.noStroke();
    maskFrame.fill(0);

    int x = -(nbFrames-1)+xoffset;
    while (x<this.frameWidth) {
      maskFrame.rect(x, 0, nbFrames-1, this.frameHeight);
      x+=nbFrames;
    }
  }

  // ------------------------------------------------------
  void createTimer()
  {
    timer = new Timer();
  }

  // ------------------------------------------------------
  void resetTimer()
  {
    timeChangeFrame = 0.0f;
  }
  
  // ------------------------------------------------------
  void setTimerPeriod(float period)
  {
    periodChangeFrame = period;
  }

  // ------------------------------------------------------
  void animate()
  {
    float dt = timer.update();
    timeChangeFrame+=dt;
    if (timeChangeFrame>=periodChangeFrame)
    {
      framePlaying = (framePlaying+1)%getNumberFrames();
      resetTimer();
    }
    PGraphics frame = getFrame(framePlaying); 

    background(200);
    image(frame, this.frameX, this.frameY, this.frameWidth, this.frameHeight);
  }

  // ------------------------------------------------------
  int getNumberFrames()
  {
    return nbFrames;
  }

  // ------------------------------------------------------
  PGraphics getFrame(int i)
  {
    return listFrames.get(i);
  }

  // ------------------------------------------------------
  PGraphics getFrameMasked(int i)
  {
    return listMaskedFrames.get(i);
  }

  // ------------------------------------------------------
  PGraphics getCompositionFrame()
  {
    return compositionFrame;
  }

  // ------------------------------------------------------
  PGraphics getMaskFrame()
  {
    return maskFrame;
  }

  // ------------------------------------------------------
  PGraphics getMaskFrameScreen()
  {
    return maskFrameScreen;
  }

  // ------------------------------------------------------
  void findMethodFrame()
  {
    try 
    {
      this.methodFrame = applet.getClass().getMethod("drawScanimationFrame", new Class[] {
        PGraphics.class, Integer.TYPE, Integer.TYPE
      }
      );
      System.out.println("- \"findMethodFrame\" found.");
    } 
    catch (Exception e) 
    {
      System.out.println("- no \"findMethodFrame\" found.");
    }
  }

  // ------------------------------------------------------
  void composeFinalFrame()
  {
    if (methodFrame != null)
    {

      // Draw Each Frame
      PGraphics frame, frameMasked;

      for (int i=0;i<nbFrames;i++) 
      {
        makeMaskFrame(i);
        
        beginFrame(i);
        try {
          frame = listFrames.get(i);
          frameMasked = listMaskedFrames.get(i);

          // Draw the frame
          frame.pushMatrix();
          frame.background(255);
          frame.noStroke();
          frame.fill(0);  
          methodFrame.invoke( applet, new Object[] { 
            frame, i, nbFrames
          } 
          );
          frame.popMatrix();

          // Mask
          PImage frameImg = frame.get();
          frameImg.mask(maskFrame);

          frameMasked.beginDraw();
          frameMasked.image(frameImg, 0, 0, frame.width, frame.height);
          frameMasked.endDraw();

          //frameMasked.get().mask(maskFrame);
        }
        catch (Exception e) {
        }
        endFrame();
      }

      // Compose
      compositionFrame.beginDraw();
      compositionFrame.background(255);
      for (int i=0;i<nbFrames;i++) 
      {
        frameMasked = listMaskedFrames.get(i);
        compositionFrame.blend(frameMasked, 0, 0, frameMasked.width, frameMasked.height, 0, 0, frameMasked.width, frameMasked.height, BLEND);
      }
      compositionFrame.endDraw();
    }
  }

  // ------------------------------------------------------
  void beginFrame(int i)
  {
    if (i>=nbFrames) return;
    currentFrame = listFrames.get(i);
    currentFrame.beginDraw();
  }

  // ------------------------------------------------------
  void endFrame()
  {
    if (currentFrame!=null)
      currentFrame.endDraw();
  }

  // ------------------------------------------------------
  void drawFrame(int i, boolean masked)
  {
    PGraphics frame;
    if (masked)
      frame = getFrameMasked(i%nbFrames);
    else
      frame = getFrame(i%nbFrames); 

    background(200);
    image(frame, this.frameX, this.frameY, this.frameWidth*scale, this.frameHeight*scale);
    //blend(frame, this.frameX, this.frameY, this.frameWidth, this.frameHeight, this.frameX, this.frameY, this.frameWidth, this.frameHeight, ADD);
  }

  // ------------------------------------------------------
  void draw()
  {
    if (exportCompo)
    {
      exportCompo = false;

      String time = timestamp();
      beginRecord(PDF, "exports/"+time+"_export_"+nbFrames+"_frames.pdf");

      if (bExportCompoBackground)
      {
        background(200);
        fill(255);
        noStroke();
        rect(this.frameX,this.frameY,this.frameWidth, this.frameHeight);
      }
      
      strokeCap(SQUARE);
      stroke(0, 255);
      strokeWeight(2.0);
      
      pushMatrix();

      translate(this.frameX,this.frameY);

      compositionFrame.loadPixels();
      boolean isBeginLine = false;
      int r = 0, i=0, j=0, jbegin=0;
      float offseti = 0.0;

      for (i=0;i<compositionFrame.width;i++)
      {
        isBeginLine = false;
        for (j=0;j<compositionFrame.height;j++)
        {
          r = (int)red( compositionFrame.get(i, j) );
          if (isBeginLine)
          {
            if (r>=254) {
              isBeginLine = false;
              line(scale*(i+offseti), scale*jbegin, scale*(i+offseti), scale*(j-1));
              println("colonne end "+i+";j="+j);
            }
          }
          else
          {
            if (r<=5) {
              isBeginLine = true;
              jbegin = j;
              println("colonne begin "+i+";j="+j);
            }
          }
        }

        if (isBeginLine)
        {
          line(scale*(i+offseti), scale*jbegin, scale*(i+offseti), scale*compositionFrame.height);
        }
      }

      popMatrix();
      
      endRecord();
    }
    
    background(200);
    image(compositionFrame, this.frameX, this.frameY, this.frameWidth*scale, this.frameHeight*scale);
  }

  // ------------------------------------------------------
  void drawWithMask()
  {
    background(200);
    image(getCompositionFrame(),this.frameX, this.frameY,this.frameWidth*scale, this.frameHeight*scale);
//    rotate(0.01);
    blend(getMaskFrameScreen(), 0, 0, this.frameWidth, this.frameHeight, mouseX-width/2, this.frameY, this.frameWidth*scale, this.frameHeight*scale, BLEND);
  }
  
  // ------------------------------------------------------
  void exportPDF()
  {
    exportCompo = true;
  }

  // ------------------------------------------------------
  void export()
  {
    String time = timestamp();    
    compositionFrame.save("exports/"+time+"_export_"+nbFrames+"_frames.png");
  }

  // ------------------------------------------------------
  void exportTransparent()
  {
    String time = timestamp();    
    compositionFrame.loadPixels();
    PImage img = createImage(compositionFrame.width, compositionFrame.height, ARGB);
    img.loadPixels();
    color cf;
    for (int i=0;i<img.width*img.height;i++)
    {
      cf = compositionFrame.pixels[i];
      img.pixels[i] = color( red(cf), green(cf), blue(cf), red(cf) == 0 ? 255 : 0 );
    }
    img.save("exports/"+time+"_export_"+nbFrames+"_frames.png");
    //compositionFrame.save("exports/"+time+"_export_"+nbFrames+"_frames.png");
  }


  // ------------------------------------------------------
  void exportGrid()
  {
    String time = timestamp();    
    getMaskFrameScreen().save("exports/"+time+"_export_"+nbFrames+"_frames_grid.png");
  }



};