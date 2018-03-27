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