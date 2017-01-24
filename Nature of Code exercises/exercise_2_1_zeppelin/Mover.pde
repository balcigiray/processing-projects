// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {
  
  PShape shape;

  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;

  Mover(PShape _shape) {
    shape = _shape;
    position = new PVector(random(width), random(height/2, height));
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = 1;
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    //stroke(0);
    //strokeWeight(2);
    //fill(127);
    //ellipse(position.x,position.y,48,48);
    shape(shape, position.x, position.y);
  }

  void checkEdges() {

    if (position.x > width) {
      position.x = width;
      velocity.x *= -1;
    } else if (position.x < 0) {
      velocity.x *= -1;
      position.x = 0;
    }

    if (position.y < 0) {
      velocity.y *= -1;
      position.y = 0;
    }

  }

}