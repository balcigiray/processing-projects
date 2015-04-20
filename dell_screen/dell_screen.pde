/*
Author: Giray Balcı
 Date: April 2015
 İstanbul, TURKEY
 
 This is modified from atomic example on my repository. 
 to be used in the 2nd (expansion) screen of mine as a background
*/

final int SIZE = 3; //number of the balls

PFont myFont;

color blue = color(105, 210, 231); //used colors
color orange = color(250, 105, 0);

//new array list for holding Circling onjects
ArrayList<Circling> electrons = new ArrayList<Circling>(); 

float coreSize= 100;
float coreIncrement = 0.2;

void setup() {
  size(displayWidth, displayHeight);

  frame.removeNotify(); 
  frame.setUndecorated(true); 
  frame.addNotify(); 

  myFont = loadFont("HelveticaNeue-UltraLight-120.vlw");

  for (int i = 0; i<SIZE; i++) {
    electrons.add(new Circling(width/2, height/2, 100, 250)); //each ball is added
    Circling c = electrons.get(i); //balls are pulled to change their parameters further
    c.angle = i*(360/SIZE); //rotation for atomic structure
    c.speed = random(2, 4); //speed is randomized
    c.ballRadius = 15; //radius of the ball
    c.ballColor = color(blue); //color of the ball
  }
  frameRate(30);

  textAlign(CENTER);
  textFont(myFont, 100);
}

void draw() {

  if (frameCount==5) {
    frame.setLocation(1920, 0);  //to place screen on 2nd screen
  }

  background(0);
  noFill();

  //gray ellipses for electron paths. (visual delight)
  for (int i = 0; i<electrons.size (); i++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(i*(360/SIZE)));
    stroke(50);
    strokeWeight(2);
    ellipse(0, 0, 200, 500);
    popMatrix();
  }

  //core of the atom
  noStroke();
  fill(orange);

  if (coreSize < 90 || coreSize > 110) {
    coreIncrement *= -1;
  }

  coreSize += coreIncrement;
  ellipse(width/2, height/2, coreSize, coreSize);

  //spinning electrons are drawn
  for (int i = 0; i<electrons.size (); i++) {    
    electrons.get(i).turn(); //i'th element is drawn
  }

  drawText();
}

void drawText() {

  fill(255);
  text("T  H  I  N  K", width*0.5, height * 0.85);
}

//to easily exit at presenation mode
void mouseClicked() {
  if (mouseX > 1870 && mouseY < 50) {
    exit();
  }
}
