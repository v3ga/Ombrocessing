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