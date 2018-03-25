import java.util.Calendar;

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

class Animation
{
  Scanimation scan;
  String name="";
  String author="";
  
  Animation(Scanimation scan, String name, String author)
  {
    this.scan = scan;
    this.name = name;
    this.author = author;
  }

  void setup()
  {
  }

  void draw(PGraphics pg, float t)
  {
  }
  
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    anim.draw(pg, float(frame)/float(nbFrames));
  }  

  void createControls(float y)
  {
  }
};

class AnimationLogo extends Animation
{
  RFont font;
  RShape form,formOmbrocessing,formOmbro,formCessing;
  String fontName = "Asap Bold.TTF";

  float sOmbro = 1.0, sCessing = 1.0;
  float s = 1.0;
  
  int mode = 2;
  
  AnimationLogo(Scanimation scan)
  {
    super(scan, "Julien", "logo");
  }

  void setup()
  {
    font = new RFont("data/fonts/"+fontName, 200, RFont.CENTER);
    RCommand.setSegmentLength(20);
    RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
    
    form = font.toShape("OMBROCESSING");
    formOmbro = font.toShape("OMBRO");
    formCessing = font.toShape("CESSING");

    sOmbro = formOmbro.getWidth() / form.getWidth();
    sCessing = formCessing.getWidth() / form.getWidth();
    
    
    
  }
    
  void draw(PGraphics pg, float t)
  {
    formOmbrocessing = RG.centerIn(form, pg, 10);
    s = formOmbrocessing.getWidth() / form.getWidth();
    
    pg.pushMatrix();
    pg.translate(pg.width/2, pg.height/2);

    if (mode == 1)
    {
      pg.translate(0, map(t,0,1,0,-5));
      formOmbrocessing.draw(pg);
    }
    else if (mode == 2)
    {
      pg.rotate( t*PI/100 );
      formOmbrocessing.draw(pg);
    }
    else if (mode == 3)
    {
      pg.scale(s);      
      pg.pushMatrix();
      float rotAmp = PI/50;
      pg.rotate(map(t,0,1,-rotAmp,rotAmp));
      pg.translate(-formOmbro.getWidth()/2-15/s,formOmbro.getHeight()/2);
      formOmbro.draw(pg);
      pg.popMatrix();

      pg.pushMatrix();
      pg.translate(+formCessing.getWidth()/2-10/s,formOmbro.getHeight()/2);
      formCessing.draw(pg);
      pg.popMatrix();
    }

//    pg.ellipse(0,0,10,10);
    pg.popMatrix();
        
    pg.noFill();
    pg.stroke(0);
//    pg.rect(formOmbrocessing.getX()+pg.width/2,formOmbrocessing.getY()+pg.height/2,formOmbrocessing.getWidth(),formOmbrocessing.getHeight());

  }
    

}