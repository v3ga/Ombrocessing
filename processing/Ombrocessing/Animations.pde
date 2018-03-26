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
    this.draw(pg, float(frame)/float(nbFrames));
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
  
  int mode = 3;
  
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

class AnimationGrid extends Animation
{
  Grid grid;

  AnimationGrid(Scanimation scan)
  {
    super(scan, "Julien", "Grid"); // à changer
  }

  // Initialisation de l'animation
  void setup()
  {
    grid = new Grid(scan.frameWidth, scan.frameHeight, 8, 8)
    {
      @Override
        public void draw(PGraphics pg, float t, int i, int j, float stepx, float stepy)
      {
        pg.rectMode(CENTER);
        pg.pushMatrix();
        pg.translate(0.5*stepx, 0.5*stepy);
        pg.rotate( t*PI/2 );
//        pg.rotate(  map( t,0,1,0,PI ) );
        //float size = map(cos( (float(i)/7+0*(float)j/15)*TWO_PI + t * TWO_PI), -1, 1, stepx/2, 2*stepx) ;
        float f = 0.8;
        float size =   f * min(stepx, stepy); 
        pg.fill(0,0,0, 255);
        pg.noStroke();
        pg.rect(0, 0, size, size);
        pg.popMatrix();
      }
    };

  }

  // Dessins de l'animation
  void draw(PGraphics pg, float t)
  {
    grid.draw(pg,t);
  }
}