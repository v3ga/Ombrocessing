// --------------------------------------------------------------------------
// Animation avec une structure de grille
// --------------------------------------------------------------------------
class AnimationGrid extends Animation
{

  // --------------------------------------------------------------------------
  Grid grid;
  float f = 0.6;

  // --------------------------------------------------------------------------
  AnimationGrid(Scanimation scan)
  {
    super(scan, "___NOM___", "___TITRE___");
  }

  // --------------------------------------------------------------------------
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
        float size =   f * min(stepx, stepy); 
        pg.fill(0, 0, 0, 255);
        pg.noStroke();
        pg.rect(0, 0, size, size);
        pg.popMatrix();
      }
    };
  }

  // --------------------------------------------------------------------------
  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);
    grid.draw(pg, t);
  }
}


// --------------------------------------------------------------------------
// Animation avec une structure de « ring »
// --------------------------------------------------------------------------
class AnimationRing extends Animation
{

  // --------------------------------------------------------------------------
  Ring ring;

  // --------------------------------------------------------------------------
  AnimationRing(Scanimation scan)
  {
    super(scan, "___NOM___", "___TITRE___");
  }

  // --------------------------------------------------------------------------
  // Initialisation de l'animation
  void setup()
  {
    ring = new Ring(scan.frameWidth/2, scan.frameHeight/2, 0.8*scan.frameHeight/2, 7)
    {
      @Override
        public void draw(PGraphics pg, float t)
      {
        pg.translate(px, py);
        pg.rotate( radians(360.0*t) );
        super.draw(pg, t);
      }

      @Override
        public void drawElement(PGraphics pg, float t, float angle)
      {
        pg.rotate( radians(180.0*t) );
        pg.rectMode(CENTER);
        pg.rect(0, 0, 50, 50);
      }
    };
  }

  // --------------------------------------------------------------------------
  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);
    ring.draw(pg, t);
  }
}

// --------------------------------------------------------------------------
// Animation avec une structure de « ring »
// --------------------------------------------------------------------------
class AnimationRingMultiple extends Animation
{

  // --------------------------------------------------------------------------
  Ring[] ring = new Ring[2];

  // --------------------------------------------------------------------------
  AnimationRingMultiple(Scanimation scan)
  {
    super(scan, "___NOM___", "___TITRE___");
  }

  // --------------------------------------------------------------------------
  // Initialisation de l'animation
  void setup()
  {
    for (int i=0; i<ring.length; i++)
    {
      ring[i] = new Ring(scan.frameWidth/2, scan.frameHeight/2, map(i,0,2,0.8,0.3)*scan.frameHeight/2, 21+2*i)
      {
        @Override
          public void draw(PGraphics pg, float t)
        {
          pg.pushMatrix();
          pg.translate(px, py);
          pg.rotate( radians(360.0*t) );
          super.draw(pg, t);
          pg.popMatrix();
        }

        @Override
          public void drawElement(PGraphics pg, float t, float angle)
        {
          pg.rotate( radians(180.0*t) );
          pg.rectMode(CENTER);
          pg.rect(0, 0, 30, 30);
        }
      };
    }
  }

  // --------------------------------------------------------------------------
  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);
    for (int i=0; i<ring.length; i++)
      ring[i].draw(pg, t);
  }
}


// --------------------------------------------------------------------------
// Animation
// --------------------------------------------------------------------------
class AnimationTypo extends Animation
{
  RFont font;
  RShape form;

  // --------------------------------------------------------------------------
  AnimationTypo(Scanimation scan)
  {
    super(scan, "___NOM___", "___TITRE___");
  }

  void setup()
  {
    font = new RFont("data/fonts/Asap Bold.TTF", 200, RFont.CENTER);
    RCommand.setSegmentLength(20);
    RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

    form = font.toShape("M");
  }
  
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);

    // On centre la forme typo par rapport au calque / PGraphics pg
    form = RG.centerIn(form, pg, 60); // marge
    // Déplacement au centre de l'écran
    pg.translate(pg.width/2, pg.height/2);
    // Rotation
    pg.rotate( radians(t*360) );
    // Dessin de la forme
    form.draw(pg);    
}


};
  