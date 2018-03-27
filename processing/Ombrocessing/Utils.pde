import java.util.Calendar;
import java.util.*;
import java.lang.reflect.*;
import processing.pdf.*;
import geomerative.*;
import controlP5.*;

// ------------------------------------------------------
static class Utils
{
  static String timestamp()
  {
    Calendar now = Calendar.getInstance();
    return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
  }

  static float toMM(float px)
  {
    float dpi = 72; // pixels per inch 
    return px / dpi * 25.4;
  }
  
  static int toPixels(float mm)
  {
    float dpi = 72; // pixels per inch 
    return int(dpi * toInches(mm));      
  }

  static float toInches(float mm)
  {
    return mm / 25.4;
  }


}

// ------------------------------------------------------
String timestamp() 
{
  return Utils.timestamp();
}

// ------------------------------------------------------
void initMedias()
{
  logo = loadImage("images/logo.png");
  font15 = loadFont("fonts/OpenSans-Regular-15.vlw");
  font30 = loadFont("fonts/OpenSans-Regular-30.vlw");
}

// ------------------------------------------------------
void initLibraries()
{
  RG.init(this);
}


// ------------------------------------------------------
class PaperSize
{
  float wdocmm,hdocmm; // without margin
  float wmm,hmm; // without margin
  float[] marginmm = new float[4]; // top right bottom left
  
  int xpx, ypx; 
  int wpx, hpx; 

  PaperSize(float wmm, float hmm, float[] marginmm)
  {
    this.wdocmm = wmm;
    this.hdocmm = hmm;
    
    if (marginmm.length == 1)
    {
      for (int i=0;i<4;i++)
        this.marginmm[i] = marginmm[0];  
    }
    else if (marginmm.length == 4)
    {
      for (int i=0;i<4;i++)
        this.marginmm[i] = marginmm[i];  
    }
    else
    {
      for (int i=0;i<4;i++)
        this.marginmm[i] = 0;  
    }
    
    

    // Surface utile 
    this.wmm = this.wdocmm - (this.marginmm[1]+this.marginmm[3]);  
    this.hmm = this.hdocmm - (this.marginmm[0]+this.marginmm[2]);  
    
    this.xpx = Utils.toPixels(this.marginmm[1]);
    this.ypx = Utils.toPixels(this.marginmm[0]);

    this.wpx =  Utils.toPixels( this.wmm );
    this.hpx =  Utils.toPixels( this.hmm );
  }

  void doSize()
  {
    size( Utils.toPixels(this.wdocmm), Utils.toPixels(this.hdocmm)  );  
  }

}

// ------------------------------------------------------
class Timer
{
  float now, before;
  Timer()
  {
    now = before = millis();
  }

  float update()
  {
    now = millis();
    float dt = now-before;
    before = now;
    
    return dt/1000.0f;
  }
}

interface Drawable
{
  public void draw(PGraphics pg, float t);
};

class Grid implements Drawable
{
  PGraphics pg;
  int w,h;
  int resx,resy;

  Grid(int w, int h, int resx, int resy)
  {
    this.w = w;
    this.h = h;
    this.resx = resx;
    this.resy = resy;
  }

  public void draw(PGraphics pg, float t)
  {
    float stepx = float(w) / float(resx);    
    float stepy = float(h) / float(resy);  

    float x=0,y=0;
    int i,j;
    for (j=0;j<resy;j++)
    {
      x = 0;
      for (i=0;i<resx;i++)
      {
        pg.pushMatrix();
        pg.translate(x,y);
        this.draw(pg, t,i,j,stepx,stepy);      
        pg.popMatrix();
        x+=stepx;
      }
      y+=stepy;
    }
  }

  public void draw(PGraphics pg, float t, int i, int j, float stepx, float stepy)
  {
  }

}

class Ring implements Drawable
{
  float px = 0, py = 0;
  float radius = 0;
  int nb = 0;

  Ring(float px, float py, float radius, int nb)
  {
    this.px = px;
    this.py = py;
    this.radius = radius;
    this.nb = nb;
  }


  public void draw(PGraphics pg, float t)
  {
    float x=0, y=0, angle=0;
    for (int i=0; i<nb; i++)
    {
      pg.pushMatrix();
      x = radius*cos(angle);
      y = radius*sin(angle);
      pg.translate(x, y);
      this.drawElement(pg, t, angle);      
      pg.popMatrix();

      angle += TWO_PI / float(nb);
    }
  }

  public void drawElement(PGraphics pg, float t, float angle)
  {
  }
}