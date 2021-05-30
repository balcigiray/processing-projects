class Point {
  //final color fillColor = color(25, 70, 100);
  final color fillColor = color(230);

  PVector pos;
  PVector gridPos;

  float dia;
  float gridSize;
  float padding;

  PVector perlin;
  float noiseStep = 0.04; 
  private float circleSizeDeviation = 0.3;
  private float margin;

  Point(PVector _gridPos, float _gridSize, float _dia, float _padding) {
    dia = _dia + random(-1*_dia*circleSizeDeviation, _dia*circleSizeDeviation); //circle size
    gridSize = _gridSize;
    padding = _padding;
    gridPos = _gridPos;

    float rndX = random(-1*(gridSize-padding), gridSize-padding);
    float rndY = random(-1*(gridSize-padding), gridSize-padding);
    float posX = gridPos.x+rndX;
    float posY = gridPos.y+rndY;

    pos = new PVector(posX, posY);

    perlin = new PVector(random(0, 10), random(0, 10));
    noiseStep = random(0.002, 0.008);

    margin = gridSize/2-dia/2-padding;

    move();
  }

  void display() {
    fill(fillColor);
    noStroke();
    circle(pos.x, pos.y, dia);

    //drawRect();
  }

  void move() {
    perlin.x += noiseStep;
    perlin.y += noiseStep;

    pos.x = map(noise(perlin.x), 0, 1, gridPos.x-margin-padding, gridPos.x+margin+padding);
    pos.y = map(noise(perlin.y), 0, 1, gridPos.y-margin-padding, gridPos.y+margin+padding);
  }

  private void drawRect() {
    rectMode(CENTER);
    noFill();
    stroke(128);
    rect(gridPos.x, gridPos.y, margin*2+dia+padding, margin*2+dia+padding);
  }
}
