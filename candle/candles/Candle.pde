class Candle {
  //http://www.colourlovers.com/palette/2677104/Girl_on_fire
  final color[] colors = {
    color(171, 0, 11), color(222, 74, 0), 
    color(255, 136, 0)
  };
  color c = colors[0];
  final color baseColor = color(253, 252, 206);

  float posX;
  float posY;

  float lenX;
  float lenY;
  
  float size;
  float increase = 0.003;  

  Candle(float _posX, float _posY, float _size) {
    posX = _posX;
    posY = _posY;
    lenX = _size*10;  //10 to 37 ratio is perfect
    lenY = _size*37;
    size = 1;
  }

  void animate() {
    if(size < 0.9 || size> 1.05){
      increase = -increase;
    }
    size += increase;
    
    drawBase();
    drawFire(size);
  }

  private void drawBase() {
    fill(baseColor);
    noStroke();
    rect(posX, posY, lenX, -lenY);
  }

  private void drawFire(float _size) {
    if(frameCount % 5 == 0){
      c = colors[int(random(0, 3))];
    }  
    
    fill(c);
    noStroke();
    pushMatrix();
    translate(posX + lenX/2, posY-lenY*1.3);
    scale(_size);
    beginShape();
    curveVertex(0, -lenY/3); 
    curveVertex(0, -lenY/3);
    curveVertex(lenX/3.15, 0); 
    curveVertex(lenX/2, lenY/5);
    curveVertex(0, lenY/3.46); 
    curveVertex(-lenX/2, lenY/5);
    curveVertex(-lenX/3.15, 0); 
    curveVertex(0, -lenY/3); 
    curveVertex(0, -lenY/3);   
    endShape();
    popMatrix();
  }
}
