//Date: 31 May 2021

final color backColor = color(33);
//final color strokeColor = color(25, 70, 100);
final color strokeColor = color(100);

Point p1, p2;
ArrayList<Point> points = new ArrayList<Point>();

//configuration
int gridSize = 90;
int padding = 5;
int circleDia = 8;

float numX, numY;

boolean lines = true;
boolean triangularLines = true;
int state = 3;
float kscale = 1;

void setup() {
  fullScreen();
  //size(1200, 720);
  //noLoop();
  frameRate(30);

  numX = width/gridSize;
  numY = height/gridSize;

  //initialize points
  for (int j=0; j<numY; j++) {
    for (int i=0; i<numX; i++) {
      float gridPosX = i*gridSize+gridSize/2;
      float gridPosY = j*gridSize+gridSize/2;

      points.add(new Point(new PVector(gridPosX, gridPosY), gridSize, circleDia, padding));
    }
  }

  kscale = 1+4*(float(gridSize)/width);

  state--;
  mousePressed();
}

void draw() {
  background(backColor);
  
  scale(kscale);
  translate(-1*gridSize, -1*gridSize);

  for (int j=0; j<numY; j++) {
    for (int i=0; i<numX; i++) {
      p1 = points.get(int(numX*j + i));

      if (true == lines) {
        //line. connects concequtive dots
        if (j!=(numY) & i!=(numX-1)) {
          p2 = points.get(int(numX*j + i+1));
          stroke(strokeColor);
          strokeWeight(1);
          line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);
        }

        //line. connects rows
        if (j!=(numY-1)) {
          p2 = points.get(int(numX*(j+1) + i));
          stroke(strokeColor);
          line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);
        }
      }

      if (true == triangularLines) {
        //line. triangulars
        if ((j%2 == 1) & (i%2 == 1)) {
          stroke(strokeColor);
          p2 = points.get(int(numX*(j-1) + (i-1)));
          line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);

          if (i<numX-1) {
            p2 = points.get(int(numX*(j-1) + (i+1)));
            line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);
          }

          if (j<numY-1) {
            p2 = points.get(int(numX*(j+1) + (i-1)));
            line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);
          }
          if ((j<numY-1) & (i<numX-1)) {
            p2 = points.get(int(numX*(j+1) + (i+1)));
            line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);
          }
        }
      }
      //p1.display();
      //p1.move();
    }
  }
  for (int j=0; j<numY; j++) {
    for (int i=0; i<numX; i++) {
      p1 = points.get(int(numX*j + i));
      p1.display();
      p1.move();
    }
  }

  boolean saveImage = false;

  if (true == saveImage) {
    frameRate(5);
    println(frameCount);

    int seconds = 1;
    int requiredFrames = seconds * 30; //assuming 30 fps

    if (frameCount > requiredFrames) {
      noLoop();
      exit();
    }
    saveFrame("frames/shot-######.png");
  }
}

void mousePressed() {
  state++;
  if (state > 3) {
    state = 0;
  }

  switch(state) {
  case 0:
    lines = false;
    triangularLines = false;
    break;
  case 1: 
    lines = true;
    triangularLines = false;
    break;
  case 2:
    lines = false;
    triangularLines = true;
    break;
  case 3:
    lines = true;
    triangularLines = true;
    break;
  }

  if ((mouseX > width*0.9) & (mouseY < height*0.1)) {
    exit();
  }
}
