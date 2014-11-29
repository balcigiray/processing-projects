/*
Author: Giray Balcı
 Date: Nov.2014
 İstanbul, TURKEY
 
 This is an example of the use of the "Circling" class.
 Atomic structure is represented by 3 objects
 */

final int SIZE = 3; //number of the balls

color blue = color(105, 210, 231); //used colors
color orange = color(250, 105, 0);

//new array list for holding Circling onjects
ArrayList<Circling> electrons = new ArrayList<Circling>(); 

void setup() {
  size(800,600);

  for (int i = 0; i<SIZE; i++) {
    electrons.add(new Circling(width/2, height/2, 100, 250)); //each ball is added
    Circling c = electrons.get(i); //balls are pulled to change their parameters further
    c.angle = i*(360/SIZE); //rotation for atomic structure
    c.speed = random(1, 3); //speed is randomized
    c.ballRadius = 15; //radius of the ball
    c.ballColor = color(blue); //color of the ball
  }
  frameRate(60);
}

void draw() {
  background(0);
  noFill();
  
  //gray ellipses for electron paths. (visual delight)
  for (int i = 0; i<electrons.size (); i++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(i*(360/SIZE)));
    stroke(50);
    strokeWeight(5);
    ellipse(0, 0, 200, 500);
    popMatrix();
  }

  //core of the atom
  noStroke();
  fill(orange);
  ellipse(width/2, height/2, 100, 100);
  
  //spinning electrons are drawn
  for (int i = 0; i<electrons.size (); i++) {    
   electrons.get(i).turn(); //i'th element is drawn
  }
}
