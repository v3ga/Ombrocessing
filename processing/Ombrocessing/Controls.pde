
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
  ScrollableList listAnimations;

  float hAfterLastControls = 45;

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
  }

  public void setup() 
  {
    surface.setLocation(0, 10);

    wLogo = this.width;
    hLogo = wLogo / (float)logo.width * logo.height;
    yControls = yLogo+hLogo+50;

    fontLabel = new ControlFont(font30, 20);

    cp5 = new ControlP5(this, new ControlFont(font15, 13));
    cp5.setColorCaptionLabel( color(#4c5575) );
//    cp5.setColorLabel( color(255) );
    cp5.setColorActive(color(#98aab9));
    cp5.setColorForeground(color(#4c5575));
//    cp5.setColorBackground(color(#e1a48c));
    

    lblDessin = cp5.addTextlabel("Dessin")
      .setText("DESSIN")
      .setFont( fontLabel ).setColorValue(color(#4c5575))
      .setPosition(0, yControls);
    yControls += 45;

    radioRender =  cp5.addRadioButton("radioRender")
      .setPosition(5, yControls)
      .setItemsPerRow(1)
      .setSpacingColumn(100)
      .setSize(20, 20)
      .addItem("composition", 0)
      .addItem("composition avec masque", 1)
      .addItem("animation", 2);

    yControls += 3*20 + 35;

    lblExport = cp5.addTextlabel("Export")
      .setText("EXPORTATION")
      .setFont( fontLabel ).setColorValue(color(#4c5575))
      .setPosition(0, yControls);
    yControls += 45;

    cp5.addButton("btnExport")
      .setLabel("Exporter en PDF")
      .setPosition(5, yControls)
      .setColorLabel(color(255))
      .setSize(200, 20);

    cp5.addButton("btnExportImg")
      .setLabel("Exporter en image")
      .setPosition(5+200+5, yControls)
      .setColorLabel(color(255))
      .setSize(200, 20);
    yControls += 45 ;

    lblParams = cp5.addTextlabel("Params")
      .setText("PARAMÈTRES")
      .setFont( fontLabel ).setColorValue(color(#4c5575))
      .setPosition(0, yControls);
    yControls += 45;

    radioRender.activate(mode);


    cp5.addSlider("periodChangeFrame")
      .plugTo(scanimation, "periodChangeFrame")
      .setLabel("Vitesse animation")
      .setPosition(5, yControls)
      .setSize(200, 20)
      .setRange(0.05, 0.5)
      .setValue(0.2);

    yControls += 25;

    anim.createControls(cp5,yControls);


    }

  void draw() 
  {
    background( /*unhex(ombroColors[0])*/color(#dbe9f4) );
    image(logo, 0, yLogo, wLogo, hLogo);

    stroke(#4c5575,100);
    drawLabelFilet(lblDessin);
    drawLabelFilet(lblExport);
    drawLabelFilet(lblParams);
  }

  void drawLabelFilet(Textlabel lbl)
  {
    line( 5, lbl.getPosition()[1]+30, this.width-5, lbl.getPosition()[1]+30);
  }


  void controlEvent(ControlEvent theEvent) 
  {
    if (theEvent.isFrom(radioRender)) 
    {
      mode = int(theEvent.getValue());
    }
  }
  
  void btnExport()
  {
    // println("Export");
    scanimation.exportPDF();
  }

  void btnExportImg()
  {
    // println("Export");
    scanimation.export();
  }


}