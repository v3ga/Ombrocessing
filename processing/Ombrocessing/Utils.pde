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