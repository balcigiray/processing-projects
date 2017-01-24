// core code is from The Nature of Code by Daniel Shiffman
// http://natureofcode.com
//
// exercised and edited by Giray Balcı

Mover zeppelin;

float counter = 0;
float step = 0.01;
float wind_range = 0.005;


void setup() {
  size(640, 480);
  zeppelin = new Mover(drawZeppelin());
}

void draw() {
  background(200);

  float wind_seed = noise(counter);
  counter += step;
  wind_seed = map(wind_seed, 0, 1, -1*wind_range, wind_range);

  PVector wind = new PVector(wind_seed, 0);
  
  if(mousePressed){
    wind = new PVector(0.1, 0);
  }
  
  PVector gravity = new PVector(0, 0.002);
  zeppelin.applyForce(gravity.mult(-1));


  zeppelin.applyForce(wind);

  zeppelin.update();
  zeppelin.display();
  zeppelin.checkEdges();
}

PShape drawZeppelin() {
  PShape zeppelin_shape;
  PShape body, bottom;

  zeppelin_shape = createShape(GROUP);

  //upper side of zeppelin
  body = createShape(ELLIPSE, 0, 0, 120, 50);
  body.setFill(color(255, 10, 10));

  //lower side of zeppelin
  bottom = createShape(RECT, -20, 25, 40, 20);
  bottom.setFill(color(50, 50, 50));

  zeppelin_shape.addChild(body);
  zeppelin_shape.addChild(bottom);

  return zeppelin_shape;
}