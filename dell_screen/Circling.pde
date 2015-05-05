/*
Author: Giray Balcı
Date: Nov.2014
İstanbul, TURKEY

This clas provides a spinning ball around a specified center. 

User must provide:
- Center point of the rotation by means of x and y coordinates
- X and Y length of the ellipse that the rotation will be made

optional:
- color
- speed
- ball radius
- angle of the system
can be specified.



*/

class Circling {
  private float posAngle; //used for calculating position of ball
    
  float centerX; //center points of the rotating system
  float centerY;

  float posX; //variables are left public in case of further need
  float posY;

  float radiusX; //these variables are used for the edges
  float radiusY; //of the elliptical rotation

  color ballColor;  //color of the rotating circle
  float ballRadius; //radius of the rotating circle
  float speed; //speed of the rotation
  float angle; //general angle of the system


//constructor
  Circling(float _centerX, float _centerY, float _radiusX, float _radiusY) {
    centerX = _centerX;
    centerY = _centerY;
    radiusX = _radiusX;
    radiusY = _radiusY;
    
    speed = 1; //initial speed
    posAngle = 0; //initial position of ball
    ballColor = color(150); //default color
    ballRadius = 20; //default radius of the ball
    angle = 0; //default angle of the system
  }

  void turn() {
    drawCircle();
    posAngle += speed; //in each turn ball position must be changed
  }

  void calculateDistance() {
    posX = radiusX*sin(radians(posAngle)); //using trigonometry distance of the point, that is the
    posY = radiusY*cos(radians(posAngle)); //ball position, is determined
  }
  
  void drawCircle(){
    calculateDistance();
    
    noStroke(); //this line can be changed if stroke is needed
    pushMatrix();
    translate(centerX, centerY); //center is put to the origin
    rotate(radians(angle)); //system is rotated if needed, default=0
    fill(ballColor); 
    ellipse(posX, posY, ballRadius, ballRadius);    
    popMatrix();  
  }
}
