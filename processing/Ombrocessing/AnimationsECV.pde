// --------------------------------------------------
class AnimationCeline extends Animation
{
  int nbBranches = 50;

  AnimationCeline(Scanimation scan, int mode)
  {
    super(scan, "Céline", mode == 1 ? "Eye" : "Hypnose", mode);
  }

  // Initialisation de l'animation
  void setup()
  {
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);

    // Bien noter que l'on utilise pg
    pg.rectMode(CENTER);
    pg.translate(pg.width/2, pg.height/2);

    if (mode == 0)
    {
      pg.pushMatrix();

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320));
      pg.strokeWeight(5);
      pg.ellipse(2, 2, 130, 170);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+20));
      pg.strokeWeight(5);
      pg.ellipse(4, 4, 140, 180);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+40));
      pg.strokeWeight(5);
      pg.ellipse(6, 6, 150, 190);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+60));
      pg.strokeWeight(5);
      pg.ellipse(8, 8, 160, 200);


      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+10));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 170, 210);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+50));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 180, 220);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+80));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 190, 230);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+90));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 210, 250);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+120));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 230, 270);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+100));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 250, 280);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(-t*320+110));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 260, 290);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+130));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 280, 320);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(-t*320+140));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 300, 340);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+150));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 320, 360);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(-t*320+160));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 340, 380);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(-t*320+160));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 440, 400);

      pg.noFill();
      pg.stroke(0);
      pg.rotate(radians(t*320+160));
      pg.strokeWeight(5);
      pg.ellipse(10, 10, 480, 450);

      pg.popMatrix();

      pg.pushMatrix();
      pg.fill(0);
      pg.stroke(0);
      pg.strokeWeight(3);

      pg.rotate(t * radians(360.0/nbBranches));
      star(pg, 0, 0, 5, 10, nbBranches);
      pg.popMatrix();
    } else 
    if (mode == 1)
    {
      //grande étoile
      pg.fill(255, 255, 255);
      pg.stroke(0);
      pg.strokeWeight(7);

      pg.pushMatrix();
      pg.rotate( -t * radians(360.0/nbBranches) );
      star(pg, 0, 0, 160, 200, nbBranches);
      pg.popMatrix();

      //moyenne étoile
      pg.fill(255, 255, 255);
      pg.stroke(0);
      pg.strokeWeight(7);

      pg.pushMatrix();
      pg.rotate( t * radians(360.0/nbBranches) );
      star(pg, 0, 0, 120, 160, nbBranches);
      pg.popMatrix();

      // étoile
      pg.fill(255, 255, 255);
      pg.stroke(0);
      pg.strokeWeight(7);

      pg.pushMatrix();
      pg.rotate( -t * radians(360.0/nbBranches) );
      star(pg, 0, 0, 80, 120, nbBranches);
      pg.popMatrix();

      //petite étoile
      pg.fill(0);
      pg.stroke(255, 255, 255);
      pg.strokeWeight(1);

      pg.pushMatrix();
      pg.rotate( t * radians(360.0/nbBranches) );
      star(pg, 0, 0, 40, 80, nbBranches);
      pg.popMatrix();
    }
  }

  void star(PGraphics pg, float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    pg.beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      pg.vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      pg.vertex(sx, sy);
    }
    pg.endShape(CLOSE);
  }
}

float distribution = 200;

class AnimationPyramids extends Animation
{
  PShape pyramid;
  Object3D[] obj = new Object3D[30];
  float R = 100;
  float TT = 30;

  // --------------------------------------------------------------------------
  AnimationPyramids(Scanimation scan)
  {
    super(scan, "Clément", "TRIANGLES-IN2-SKY");
  }

  PVector getVector(float r, float angle)
  {
    return new PVector( r*cos( radians(angle-90) ), 0, r*sin( radians(angle-90) ) );
  }

  void setup()
  {

    PVector A = getVector(R/2, 0);
    PVector B = getVector(R/2, 120);
    PVector C = getVector(R/2, 240);
    PVector T = new PVector(0, -TT, 0);

    pyramid = createShape();
    pyramid.beginShape(TRIANGLES);

    pyramid.fill(255);
    pyramid.stroke(0);
    pyramid.strokeWeight(3);

    pyramid.vertex(A.x, A.y, A.z);
    pyramid.vertex(B.x, B.y, B.z);
    pyramid.vertex(C.x, C.y, C.z);

    pyramid.vertex(A.x, A.y, A.z);
    pyramid.vertex(B.x, B.y, B.z);
    pyramid.vertex(T.x, T.y, T.z);

    pyramid.vertex(B.x, B.y, B.z);
    pyramid.vertex(C.x, C.y, C.z);
    pyramid.vertex(T.x, T.y, T.z);


    pyramid.vertex(C.x, C.y, C.z);
    pyramid.vertex(A.x, A.y, A.z);
    pyramid.vertex(T.x, T.y, T.z);

    pyramid.endShape();
    for (int i=0; i<obj.length; i++) {
      obj[i] = new Object3D(pyramid, random(-distribution, distribution), random(-distribution, distribution), random(-distribution, distribution));
    }
  }  

  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);
    pg.translate(pg.width/2, pg.height/2);
    //  rotateY(radians(mouseX));
    for (int i=0; i<obj.length; i++)
      obj[i].draw(pg, frame, nbFrames);
  }
}


class Object3D
{
  PVector position = new PVector();
  float rotationY = random(120);
  float rotationX = random(120);
  float rotationYStart = rotationY;
  float dir = random(1) > 0.5 ? -1 : 1;
  PShape p;
  //  float f = random(1) > 0.5 ? 2 : 1;
  float f = 1;
  float size = 1;
  float pulseOffset = random(PI*2);
  float rotation = random(1) > 0.5 ? 1 : 0;

  Object3D(PShape p, float x, float y, float z)
  {
    this.p = p;
    this.position.set(x, y, z);

    //pulseOffset = dist(x,y,z, 0,0,0) / distribution * TWO_PI;
  }

  void draw(PGraphics g, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);
    size = rotation >0 ?  map(sin(pulseOffset + t*TWO_PI), -1, 1, 0.5, 1.0) : 1.0;

    g.pushMatrix();
    g.translate(position.x, position.y, position.z);
    g.rotateY(radians(rotationY + rotation*map(t, 0, 1, 0, f*120)));
    if (dir == -1)
      g.rotateX(PI);
    g.scale( size  );
    g.shape(p);
    g.popMatrix();
  }
}

// --------------------------------------------------
class AnimationCubes extends Animation
{

  AnimationCubes(Scanimation scan)
  {
    super(scan, "Clément", "CUBE-IN2-CUBE");
  }

  // Initialisation de l'animation
  void setup()
  {
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);



    pg.noFill();
    pg.stroke(0);
    pg.strokeWeight(10);
    pg.translate(pg.width/2, pg.height/2);
    pg.rotateY( t*PI/2 );
    pg.box(220);


    // millieu
    pg.noFill();
    pg.stroke(0);
    pg.fill(255);
    pg.strokeWeight(8);
    pg.translate(0, 0, 0);
    pg.rotateX( t*PI/-2 );
    pg.box(145);
  }
}

class AnimationSpheres extends Animation
{
  PShape halfSphere;
  int nbSpheres = 12;



  AnimationSpheres(Scanimation scan)
  {
    super(scan, "Johan Trigeard", "Circling Around ");
  }

  // Initialisation de l'animation
  void setup()
  {
    float radius = 120.0;
    float rho = radius;
    float factor = TWO_PI / 20.0;
    float x, y, z;  

    halfSphere = createShape();
    for (float phi = 0.0; phi < HALF_PI; phi += factor) {
      halfSphere.beginShape(QUAD_STRIP);
      halfSphere.fill(0);
      for (float theta = 0.0; theta < TWO_PI + factor; theta += factor) {
        x = rho * sin(phi) * cos(theta);
        z = rho * sin(phi) * sin(theta);
        y = -rho * cos(phi);

        halfSphere.vertex(x, y, z);

        x = rho * sin(phi + factor) * cos(theta);
        z = rho * sin(phi + factor) * sin(theta);
        y = -rho * cos(phi + factor);

        halfSphere.vertex(x, y, z);
      }
      halfSphere.endShape(CLOSE);
    }
  }

  void drawBurger(PGraphics pg, float t, float x, float y, float z, float ouverture)
  {
    pg.pushMatrix();
    pg.translate(x, y, z);

    pg.pushMatrix();
    pg.rotateY( map(t, 0, 1, 0, TWO_PI) );
    pg.shape(halfSphere, 0, map(t, 0, 1, 0, -ouverture));

    pg.rotateX(radians(180));
    pg.shape(halfSphere, 0, map(t, 0, 1, 0, -ouverture));
    pg.popMatrix();

    pg.rotateY( map(t, 0, 1, 0, TWO_PI/nbSpheres) );
    for (int i=0; i<nbSpheres; i++)
    {
      pg.pushMatrix();
      pg.rotateY( i*TWO_PI/nbSpheres );
      pg.translate(0, 0, map(t, 0, 1, 0, 200));
      pg.fill(0);
      pg.sphere(20);
      pg.popMatrix();
    }

    pg.popMatrix();
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);

    pg.translate(width/2, height/2);
    drawBurger(pg, sin(t)*2, 0, 0, -200, 50);
    pg.rect(-400, 200, 1000*sin(t), 1000);
    pg.rect(-1270, -500, 1000, 1000*sin(t));
    pg.rect(270, -400, 1000, 1000*sin(t));
    pg.rect(-400, -1200, 1000*sin(t), 1000);
    // drawBurger(pg,sin(t)*2.5,-200,-50,0,100);
    //drawBurger(pg,sin(t)*8,600,-300,-800,100);
    //drawBurger(pg,sin(t)/0.5,100,-700,-1000,10);
    //drawBurger(pg,sin(t)*2,300,200,-20,100);
  }
}


class AnimationBurgers extends Animation
{
  PShape halfSphere;
  int nbSpheres = 24;



  AnimationBurgers(Scanimation scan)
  {
    super(scan, "Johan", "Angry Face");
  }

  // Initialisation de l'animation
  void setup()
  {
    float radius = 120.0;
    float rho = radius;
    float factor = TWO_PI / 20.0;
    float x, y, z;  

    halfSphere = createShape();
    for (float phi = 0.0; phi < HALF_PI; phi += factor) {
      halfSphere.beginShape(QUAD_STRIP);
      halfSphere.fill(0);
      for (float theta = 0.0; theta < TWO_PI + factor; theta += factor) {
        x = rho * sin(phi) * cos(theta);
        z = rho * sin(phi) * sin(theta);
        y = -rho * cos(phi);

        halfSphere.vertex(x, y, z);

        x = rho * sin(phi + factor) * cos(theta);
        z = rho * sin(phi + factor) * sin(theta);
        y = -rho * cos(phi + factor);

        halfSphere.vertex(x, y, z);
      }
      halfSphere.endShape(CLOSE);
    }
  }

  void drawBurger(PGraphics pg, float t, float x, float y, float z, float ouverture)
  {
    pg.pushMatrix();
    pg.translate(x, y, z);

    pg.pushMatrix();
    pg.rotateY( map(t, 0, 1, 0, TWO_PI) );
    pg.shape(halfSphere, 0, map(t, 0, 1, 0, -ouverture));

    pg.rotateX(radians(180));
    pg.shape(halfSphere, 0, map(t, 0, 1, 0, -ouverture));
    pg.popMatrix();

    pg.rotateY( map(t, 0, 1, 0, TWO_PI/nbSpheres) );
    for (int i=0; i<nbSpheres; i++)
    {
      pg.pushMatrix();
      pg.rotateY( i*TWO_PI/nbSpheres );
      pg.translate(0, 0, map(t, 0, 1, 0, 200));
      pg.fill(0);
      pg.sphere(20);
      pg.popMatrix();
    }

    pg.popMatrix();
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);

    pg.translate(width/2+t*20, height/2+t*20);
    drawBurger(pg, sin(t)*2, 0, 0, -200, 100);
    pg.rect(350, 0, 1000*sin(t), 100);

    drawBurger(pg, sin(t*2), -400, 100, -500, 200);
    drawBurger(pg, sin(t*2), 400, 100, -500, 200);
    drawBurger(pg, sin(t*2), 370, -550, -1000, 80);
    drawBurger(pg, sin(t*2), -370, -550, -1000, 80);
    //drawBurger(pg,sin(t)*8,600,-300,-800,100);
    //drawBurger(pg,sin(t)/0.5,100,-700,-1000,10);
    //drawBurger(pg,sin(t)*2,300,200,-20,100);
  }
}


// --------------------------------------------------
class AnimationMistral extends Animation
{
  // Paramètre
  boolean drawMotif1 = true;
  boolean drawMotif2 = true;
  boolean drawMotif3 = true;
  boolean drawMotif4 = true;

  AnimationMistral(Scanimation scan)
  {
    super(scan, "Lila", "Mistral");
  }

  // Initialisation de l'animation
  void setup()
  {
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);

    // Bien noter que l'on utilise pg
    //pg.rectMode(CENTER);
    // pg.rect(pg.width/2, pg.height/2, 200 + t*amplitude, 200);
    pg.rectMode(CENTER);
    // pg.rect(pg.width/2, pg.height/2, 200 + t*amplitude, 200);
    pg.translate(pg.width/2, pg.height/2);
    pg.scale(0.9);

    //    pg.rect(t * 30,0,100 + t * 100,50 + t * 300);
    //pg.rotate( radians(t*360) );
    //pg.ellipse(0,0,200 + t*300,50 + t * 50);
    //pg.rect(-60,-50,300,50);  
    int nb = 10;


    //motif 2 traits/chemins :
    if (drawMotif1)
    {
      pg.strokeWeight(5);
      pg.stroke(0);

      pg.pushMatrix();
      pg.rotate( t * radians(360/nb) );
      pg.pushMatrix();
      for (int i=0; i<nb; i++)
      {
        pg.line(0, 0, 80, 0);
        pg.line(80, 0, 80, 80);
        pg.line(80, 80, 30, 80);
        pg.line(30, 80, 30, 30);
        //pg.line(0,30,55,30);
        pg.rotate(radians(360/nb));
      }
      pg.popMatrix();
      pg.popMatrix();
    }

    if (drawMotif2)
    {

      pg.strokeWeight(3);
      pg.stroke(0);
      nb = 20;


      pg.pushMatrix();
      pg.rotate( t * radians(-360/nb) );
      pg.pushMatrix();
      for (int i=0; i<nb; i++)
      {
        pg.line(0, 0, 120, 0);
        pg.line(120, 0, 120, 120);
        pg.line(120, 120, 60, 120);
        pg.line(60, 120, 60, 50);
        pg.line(40, 50, 75, 50);
        pg.rotate(radians(360/nb));
      }
      pg.popMatrix();
      pg.popMatrix();
    }

    if (drawMotif3)
    {

      pg.strokeWeight(1);
      pg.stroke(0);
      nb = 40;

      pg.pushMatrix();
      pg.rotate( t * radians(360/nb) );
      pg.pushMatrix();
      for (int i=0; i<nb; i++)
      {
        pg.line(0, 0, 160, 0);
        pg.line(160, 0, 160, 160);
        pg.line(160, 160, 0, 160);
        pg.line(60, 120, 60, 50);
        pg.line(40, 50, 75, 50);
        pg.rotate(radians(360/nb));
      }
      pg.popMatrix();
      pg.popMatrix();
    }

    if (drawMotif4)
    {

      pg.strokeWeight(2);
      pg.stroke(0);
      nb = 10;
      pg.pushMatrix();
      pg.rotate( t * radians(360/nb) );
      pg.pushMatrix();

      for (int i=0; i<nb; i++)
      {
        pg.ellipse(0, 0, 30 + t*180, 10 + t * 20);
        pg.rotate(radians(360/nb));
      }

      pg.noFill();
      pg.strokeWeight(2);
      pg.ellipse(0, 0, 200, 200);
    }
    pg.popMatrix();
    pg.popMatrix();
  }
}

// --------------------------------------------------
class AnimationCypraeaMappa extends Animation
{
  // Paramètre
  boolean drawMotif1 = true;
  boolean drawMotif2 = true;
  boolean drawMotif3 = true;
  boolean drawMotif4 = true;

  AnimationCypraeaMappa(Scanimation scan)
  {
    super(scan, "Lila", "Cypraea Mappa");
  }

  // Initialisation de l'animation
  void setup()
  {
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);

    // Bien noter que l'on utilise pg
    //pg.rectMode(CENTER);
    // pg.rect(pg.width/2, pg.height/2, 200 + t*amplitude, 200);
    pg.rectMode(CENTER);
    // pg.rect(pg.width/2, pg.height/2, 200 + t*amplitude, 200);
    pg.translate(pg.width/2, pg.height/2);
    pg.scale(0.9);

    //    pg.rect(t * 30,0,100 + t * 100,50 + t * 300);
    //pg.rotate( radians(t*360) );
    //pg.ellipse(0,0,200 + t*300,50 + t * 50);
    //pg.rect(-60,-50,300,50);  
    int nb = 5;


    //motif 2 traits/chemins :
    if (drawMotif1)
    {
      pg.strokeWeight(5);
      pg.stroke(0);

      pg.pushMatrix();
      pg.rotate( t * radians(360/nb) );
      pg.pushMatrix();
      for (int i=0; i<nb; i++)
      {
        pg.line(0, 0, 60, 0);
        pg.line(60, 0, 60, 60);
        pg.line(60, 60, 10, 60);
        pg.line(10, 60, 10, 10);
        //pg.line(0,30,55,30);
        pg.rotate(radians(360/nb));
      }
      pg.popMatrix();
      pg.popMatrix();
    }

    if (drawMotif2)
    {

      pg.strokeWeight(3);
      pg.stroke(0);
      nb = 20;


      pg.pushMatrix();
      pg.rotate( t * radians(-360/nb) );
      pg.pushMatrix();
      for (int i=0; i<nb; i++)
      {
        pg.line(0, 0, 140, 20);
        pg.line(140, 20, 140, 140);
        pg.line(140, 140, 80, 140);
        pg.line(80, 140, 80, 70);
        pg.line(60, 70, 95, 70);
        pg.rotate(radians(360/nb));
      }
      pg.popMatrix();
      pg.popMatrix();
    }

    if (drawMotif3)
    {

      pg.strokeWeight(1);
      pg.stroke(0);
      nb = 40;

      pg.pushMatrix();
      pg.rotate( t * radians(360/nb) );
      pg.pushMatrix();
      for (int i=0; i<nb; i++)
      {
        //pg.line(0, 0, 160, 0);
        //pg.line(160, 0, 160, 160);
        //pg.line(160, 160, 0, 160);
        //pg.line(60, 120, 60, 50);
        //pg.line(40, 50, 75, 50);
        //pg.rotate(radians(360/nb));
        pg.line(0, 0, 200, 40);
        pg.line(200, 40, 200, 200);
        pg.line(200, 200, 40, 200);
        pg.line(100, 160, 100, 90);
        pg.line(80, 90, 115, 90);
        pg.rotate(radians(360/nb));
      }
      pg.popMatrix();
      pg.popMatrix();
    }

    if (drawMotif4)
    {

      pg.strokeWeight(3);
      pg.stroke(0);
      nb = 40;

      pg.pushMatrix();
      pg.rotate( t * radians(360/nb) );
      pg.pushMatrix();
      for (int i=0; i<nb; i++)
      {
        pg.line(0, 0, 400, 0);
        pg.rotate(radians(360/nb));
      }
      pg.popMatrix();
      pg.popMatrix();
    }
  }
}

// --------------------------------------------------
class AnimationTournesol extends Animation
{
  // Paramètre
  float amplitude = 250.0;  
  float golden=radians(180*(3-sqrt(5)));

  AnimationTournesol(Scanimation scan)
  {
    super(scan, "Margaux", "Hypnot eyes");
  }

  // Initialisation de l'animation
  void setup()
  {
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);

    // Bien noter que l'on utilise pg
    //pg.rectMode(CENTER);
    //pg.rect(pg.width/2, pg.height/2, 200 + t*amplitude, 200);
    pg.translate(pg.width/2, pg.height/2);
    //pg.rect(0,0,100 + t*100 ,50 + t * 300);
    //pg.rotate( radians(t*45) );
    //pg.ellipse(0,0,200 + t *100,50+ t*50);
    //    pg.ellipse(0, 0, amplitude, amplitude);    
    //tournesol(pg,350,0,0,1,t);

    tournesol(pg, 200, -160, 0, 1, t);
    tournesol(pg, 200, 160, 0, -1, t);
  }

  void tournesol(PGraphics pg, int nmax, float x, float y, float dir, float t)
  {
    for (int n=1; n<=nmax; n++) 
    {
      float r = 5.5*sqrt(n);
      float x1 = 2*r*cos(golden*n);
      float y1 = 2*r*sin(golden*n);
      amplitude =  map( sin( dir*radians(t * 360 + n*5) ), -1, 1, 6, 12);
      pg.ellipse(x1+x, y1+y, amplitude, amplitude);
    }
  }
}


// --------------------------------------------------
class AnimationMelanie extends Animation
{
  int cols = 8;
  int rows = 8;
  float w, h;
  Square[] squares = new Square[rows*cols];
  float theta;
  PVector v = new PVector();

  // --------------------------------------------------------------------------
  AnimationMelanie(Scanimation scan)
  {
    super(scan, "Mélanie", "Troubles");
  }

  void setup() 
  {
    w = float(scan.frameWidth)/cols;
    h = float(scan.frameHeight)/rows;
    int i=0;
    for (int x=0; x<rows; x++) {
      for (int y=0; y<cols; y++) {
        squares[i] = new Square(x*w, y*h, w, h);
        i++;
      }
    }
  }

  void draw(PGraphics pg, int frame, int nbFrames)
  {
    //    randomSeed(1234);
    //    background(255);
    float t  = float(frame) / float(nbFrames);
    theta = TWO_PI * t;
    v.set(pg.width/2+sin(theta)*100, pg.height/2+cos(theta)*100);
    for (int i=0; i<cols*rows; i++) {
      squares[i].update(pg, v);
      squares[i].display(pg);
    }
  }
}

class Square {

  PGraphics square;
  float x, y;
  float w, h;

  Square(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;

    square = createGraphics((int)w, (int)h);
  }

  void update(PGraphics pg, PVector v) {
    float distance = dist(v.x, v.y, x+w/2, y+h/2);
    float r = map(distance, 0, sqrt(sq(pg.width/2)+sq(pg.height/2)), 0, PI/2);
    square.beginDraw();
    square.rectMode(CENTER);
    square.background(255);
    square.pushMatrix();
    square.translate(w/2, h/2);
    square.rotate(r);
    square.fill(0);
    square.rect(0, 0, 100, h/5);
    square.popMatrix();
    square.endDraw();
  }

  void display(PGraphics pg) {
    pg.image(square, x, y);
  }
}

// --------------------------------------------------
class buddha extends Animation
{
  buddha(Scanimation scan)
  {
    super(scan, "Pierre", "Buddha2");
  }

  // Initialisation de l'animation
  void setup()
  {
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);
    float pas = 11.25;
    //rayon
    float contour = 5;
    float taille = 240;
    //masque
    float mskIn = 2;
    float mskOut = 10;

    // damier 
    float pasDam = 30;
    // Bien noter que l'on utilise pg
    //pg.rectMode(CENTER);

    /////////////////////////////////////////////////////////////////////////////

    /// buddha
    pg.translate(width/2-25, height/2-10);
    pg.rotate(radians(-t*11.25));

    for (float i = 0; i<=32; i++) {
      pg.rect(10, 0, contour, taille);
      //pg.quad(-mskIn,-4,mskIn,0,mskOut,500,-mskOut,500);
      pg.rotate(radians(pas));
    }

    pg.rotate(radians(t*11.25));
    pg.fill(255);
    for (float masque = 0; masque <= 30; masque++) {
      pg.rotate(radians(12));
      pg.quad(-mskIn, -2, mskIn, -2, mskOut, taille, -mskOut, taille+10);
    }

    //damier qui tourne

    pushStyle();
    fill(0);
    ellipse(0, 5, 100, 100);
    popStyle();

    pg.pushStyle();
    pg.noFill();
    pg.stroke(255);
    pg.strokeWeight(30);
    pg.ellipse(0, 0, 216, 216);
    pg.strokeWeight(35);
    pg.ellipse(0, 0, 420, 420);
    pg.popStyle();



    pg.fill(0);
    //stylé mais useless     pg.rotate(radians(30*sin(t*t*3)+50)); 
    pg.rotate(radians(t*30));
    for (float damier = 0; damier <= 11; damier++) {
      pg.rotate(radians(pasDam));
      pg.rect(-14, 91, 28, 10);
    }
    pg.rotate(radians(15));
    for (float damier = 0; damier <= 11; damier++) {
      pg.rotate(radians(pasDam));
      pg.rect(-14, 113, 28, 10);
    }

    pg.fill(0);
    pg.rotate(radians(-15));
    pg.rotate(radians(-t*60));
    for (float damier = 0; damier <= 11; damier++) {
      pg.rotate(radians(pasDam));
      pg.rect(-14, 102, 28, 10);
    }
    pg.strokeWeight(5);
    pg.noFill();
    pg.stroke(0);
    pg.ellipse(0, 0, t*t*60, t*t*60);


    //////////////////////////////TEST//////////////////////////////////////////////


    //////////////////////////////ONDE//////////////////////////////////////////////
    /*
      
     
     pg.translate(width/2-25, height/2-10);
     
     for (float g = 0; g < 8; g++){
     pg.rotate(radians(45));
     pg.ellipse (15+15*sin(t*3.+1),0,10,10);   }
     
     for (float g = 0; g < 16; g++){
     pg.rotate(radians(22.5));
     pg.ellipse (30+30*sin(t*3.2+0.8),0,9.5,9.5);  }
     
     for (float g = 0; g < 24; g++){
     pg.rotate(radians(22.5));
     pg.ellipse (40+50*sin(t*3.2+0.6),0,9,9); }
     
     for (float g = 0; g < 32; g++){
     pg.rotate(radians(11.25));
     pg.ellipse (60+60*sin(t*3.2+0.4),0,8.5,8.5);  }
     
     for (float g = 0; g < 40; g++){
     pg.rotate(radians(10));
     pg.ellipse (70+80*sin(t*3.2+0.2),0,8,8);  }
     
     for (float g = 0; g < 48; g++){
     pg.rotate(radians(7.5));
     pg.ellipse (90+100*sin(t*3.2+0),0,7.5,7.5);  }
     
     for (float g = 0; g < 56; g++){
     pg.rotate(radians(6.39));
     pg.ellipse (125+125*sin(t*3.2-0.2),0,7,7);  }
     
     */

    ////////////////////////////////////////////////////////////////
  }
}


// --------------------------------------------------
class AnimationRebecca extends Animation
{
  // Paramètre
  float s = 60;
  int area = 100;
  AnimationRebecca(Scanimation scan, int mode)
  {
    super(scan, "Rebecca", mode == 0 ? "Bouée" : "Roul-eau", mode);
  }

  // Initialisation de l'animation
  void setup()
  {
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);


    // animation00
    if (mode == 0)
    {
      int nb = 10; // touch
      float size = 0;
      float stepy = float(pg.height) / (nb-1); // pas touch
      float offset = t*stepy; // pas touch 

      for (float x=0; x<=pg.width; x = x+50)
      {

        float y = 0;
        for (int i=0; i<nb; i++)
        {
          size = map( sin( radians(x/4)+t*TWO_PI+map(y, 0, pg.height, 0, PI) ), -1, 1, 5, 40); // min max
          pg.ellipse(x, y+offset, size, 10);
          y += stepy; // pas touch
        }
      }
    } else
      if (mode == 1)
      {
        //animation 01

        pg.noFill();
        pg.translate(width/2, height/2);
        float i = 0;
        for (int x = -pg.width/2-area; x <= pg.width/2-area; x+=s) {
          for (int y = -pg.height/2-area; y <= pg.height/2-area; y+=s) {
            float a = cos(radians(i+t*2))*PI;
            if (dist(x, y, 0, 0) < pg.width/4) 
            {
              pg.pushMatrix();
              pg.translate(x, y);
              pg.rotate(  radians(  i+t*360 ) );
              pg.stroke(0);
              pg.strokeWeight(8);
              pg.arc(0, 0, s, s, 0, PI);
              pg.arc(0, 0, s/2, s/2, PI, TWO_PI);
              pg.popMatrix();
            }

            i+=60;
          }
        }
      }
  }
}


// --------------------------------------------------
class AnimationTourbillon extends Animation
{
  AnimationTourbillon(Scanimation scan)
  {
    super(scan, "Biggs", "Tourbillon");
  }

  // Initialisation de l'animation
  void setup()
  {
  }


  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);
    int pas=0; 

    // Bien noter que l'on utilise pg
    pg.rectMode(CENTER);
    pg.translate(pg.width/2, pg.height/2);

    pg.fill(255);
    pg.stroke(0);
    pg.strokeWeight(5);
    pg.rotate(radians(72)*t);
    for (float i=0; i<36; i++) {
      pg.rotate(radians(10));
      pg.rect(0, 0, width+pas, width+pas);
      pas-=20;
    }
  }
}


// --------------------------------------------------
class AnimationWave extends Animation
{

  AnimationWave(Scanimation scan)
  {
    super(scan, "Biggs", "Waves");
  }

  // Initialisation de l'animation
  void setup()
  {
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);

    // Bien noter que l'on utilise pg
    pg.rectMode(CENTER);

    for (float j=34/2; j<800; j+=34) {
      for (float i=34/2; i<800; i+=34) {
        pg.ellipse(i, j, 50*sin(t*22+i/10+j/10), 50*sin(t*22+i/10+j/10));
      }
    }
  }
}

// --------------------------------------------------
class AnimationSauron extends Animation
{
  // Paramètre
  float amplitude = 50.0;  

  AnimationSauron(Scanimation scan)
  {
    super(scan, "Biggs", "Sauron");
  }

  // Initialisation de l'animation
  void setup()
  {
  }

  // Dessins de l'animation
  void draw(PGraphics pg, int frame, int nbFrames)
  {
    float t = float(frame) / float(nbFrames);

    // Bien noter que l'on utilise pg
    pg.rectMode(CENTER);
    pg.translate(pg.width/2, pg.height/2);
    pg.ellipse(0, 0, 40, 40);
    pg.rotate(radians(90)*t);
    for (int pas1 = 0; pas1<=3; pas1++) {
      pg.rotate(radians(90));
      pg.ellipse(50, 0, 60, 60);
    }
    for (int pas2 = 0; pas2<=3; pas2++) {
      pg.rotate(radians(90));
      pg.ellipse(40, 40, 22, 22);
    }
    for (int pas3=0; pas3<=13; pas3++) {
      pg.rotate(radians(25.7));
      pg.ellipse(100, 0, 45, 45);
    }
    for (int littleCircleX=0; littleCircleX<=100; littleCircleX+=10) {
      for (int pas4=0; pas4<=51; pas4++) {
        pg.rotate(radians(6.9));
        pg.ellipse(135+littleCircleX, 0, 10, 10);
      }
    }
    for (int pas5=0; pas5<=34; pas5++) {
      pg.noFill();
      pg.stroke(0);
      pg.strokeWeight(3);
      pg.rotate(radians(15));
      pg.ellipse(175, 0, 110, 110);
    }


    pg.noFill();
    pg.stroke(0);
    pg.strokeWeight(10);
    pg.ellipse(0, 0, 250, 250);
    pg.ellipse(0, 0, 470, 470);
  }
}