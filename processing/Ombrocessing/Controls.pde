
class ControlFrame extends PApplet 
{

  int w, h;
  PApplet parent;
  ControlP5 cp5;
  RadioButton radioRender;
  Scanimation scanimation;
  Textlabel lblDessin, lblExport, lblParams;
  float yLogo = 20;
  float wLogo = 0, hLogo = 0;
  float yControls=0;
  ControlFont fontLabel;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) 
  {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    scanimation = ((Ombrocessing)parent).scanimation;

    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() 
  {
    size(w, h);
    pixelDensity(2);
  }

  public void setup() 
  {
    surface.setLocation(0, 10);

    wLogo = this.width;
    hLogo = wLogo / (float)logo.width * logo.height;
    yControls = yLogo+hLogo+10;

    fontLabel = new ControlFont(font30, 20);

    cp5 = new ControlP5(this, new ControlFont(font15, 13));
    cp5.setColorCaptionLabel( color(0) );

    lblDessin = cp5.addTextlabel("Dessin")
      .setText("DESSIN")
      .setFont( fontLabel ).setColorValue(color(0))
      .setPosition(0, yControls);
    yControls += 25;

    radioRender =  cp5.addRadioButton("radioRender")
      .setPosition(5, yControls)
      .setItemsPerRow(1)
      .setSpacingColumn(100)
      .setSize(20, 20)
      .addItem("composition", 0)
      .addItem("composition avec masque", 1)
      .addItem("animation", 2);

    yControls += 3*20 + 10;

    lblExport = cp5.addTextlabel("Export")
      .setText("EXPORTATION")
      .setFont( fontLabel ).setColorValue(color(0))
      .setPosition(0, yControls);
    yControls += 25;

    cp5.addButton("btnExport")
      .setLabel("Exporter en PDF")
      .setPosition(5, yControls)
      .setSize(200, 20);

    cp5.addButton("btnExportImg")
      .setLabel("Exporter en image")
      .setPosition(5+200+5, yControls)
      .setSize(200, 20);

    
    yControls += 25;

    lblParams = cp5.addTextlabel("Params")
      .setText("PARAMÈTRES")
      .setFont( fontLabel ).setColorValue(color(0))
      .setPosition(0, yControls);
    yControls += 25;

    radioRender.activate(mode);


    cp5.addSlider("periodChangeFrame")
      .plugTo(scanimation, "periodChangeFrame")
      .setLabel("Vitesse animation")
      .setPosition(5, yControls)
      .setSize(200, 20)
      .setRange(0.05, 0.5)
      .setValue(0.2);
  }

  void draw() 
  {
    background( unhex(ombroColors[10]) );
    image(logo, 0, yLogo, wLogo, hLogo);
    stroke(0);
    drawLabelFilet(lblDessin);
    drawLabelFilet(lblExport);
    drawLabelFilet(lblParams);
  }

  void drawLabelFilet(Textlabel lbl)
  {
    line( 5, lbl.getPosition()[1]+20, this.width-5, lbl.getPosition()[1]+20);
  }


  void controlEvent(ControlEvent theEvent) 
  {
    if (theEvent.isFrom(radioRender)) 
    {
      mode = int(theEvent.getValue());

      /*      print("got an event from "+theEvent.getName()+"\t");
       for (int i=0; i<theEvent.getGroup().getArrayValue().length; i++) {
       print(int(theEvent.getGroup().getArrayValue()[i]));
       
       }
       */
    }
  }
}