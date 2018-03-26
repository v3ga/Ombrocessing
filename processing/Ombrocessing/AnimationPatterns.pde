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
      pushMatrix();
      translate(px, py);
      x = radius*cos(angle);
      y = radius*sin(angle);
      translate(x, y);
      this.draw(t, angle);      
      popMatrix();

      angle += TWO_PI / float(nb);
    }
  }

  public void draw(float t, float angle)
  {
  }
}