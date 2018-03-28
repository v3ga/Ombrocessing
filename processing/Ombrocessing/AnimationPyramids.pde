
class AnimationPyramids extends Animation
{
  PShape pyramid;
  Object3D[] obj = new Object3D[350];

  // --------------------------------------------------------------------------
  AnimationPyramids(Scanimation scan)
  {
    super(scan, "___NOM___", "___TITRE___");
  }
  
  PVector getVector(float r, float angle)
  {
    return new PVector( r*cos( radians(angle-90) ), 0, r*sin( radians(angle-90) ) );
  }

  void setup()
  {
    float R = 40;
    float TT = 100;
    float distribution = 200;

    PVector A = getVector(R/2, 0);
    PVector B = getVector(R/2, 120);
    PVector C = getVector(R/2, 240);
    PVector T = new PVector(0, -TT, 0);

    pyramid = createShape();
    pyramid.beginShape(TRIANGLES);

    pyramid.fill(255);
    pyramid.stroke(0);
    pyramid.strokeWeight(5);

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
    for (int i=0;i<obj.length;i++)
      obj[i].draw(pg,t);
  }
}


class Object3D
{
  PVector position = new PVector();
  float rotationY = random(120);
  float rotationYStart = rotationY;
  PShape p;
//  float f = random(1) > 0.5 ? 2 : 1;
  float f = 1;

  Object3D(PShape p, float x, float y, float z)
  {
    this.p = p;
    this.position.set(x, y, z);
  }

  void draw(PGraphics g, float t)
  {
    g.pushMatrix();
    g.translate(position.x, position.y, position.z);
    g.rotateY(radians(rotationY + map(t, 0, 1, 0, f*120)));
    g.shape(p);
    g.popMatrix();
  }
}