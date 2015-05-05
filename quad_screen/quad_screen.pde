import processing.serial.*;  //import serial library for incoming arduino data
PFont myfont;  //create font object

//serial port variables
String serialData; //incoming arduino data will be stored here
Serial port;  //create port object
char endChar = '!'; //end line character. 
//end line can be anything that send by arduino on the last line
//for indicating the end of the data package 

//color array used in sketch. see colorsInit()
color[] colors;

int[] motor;

//quad position
float posX;
float posY;
float posZ;

void setup() {
  size(1100, 800, P3D);

  initialPosition();
  colorsInit();

  myfont = loadFont("DejaVuSans-48.vlw");
  //serial port is initialized and choosen starting the program  
  try {
    port = new Serial(this, Serial.list()[0], 57600);
    port.clear();
    port.bufferUntil(endChar);
  }
  catch(Exception e) {
    println("Port hatası " + e);
  }
  //port data is cleared in case of openin the port
  //in the middle of the data income

    serialData = null;
  //end char is setted for serialEvent function 
  noStroke();
  motor = new int[7];
}

void draw() {
  background(230);
  sampleColors();
  textFont(myfont, 22);
  textAlign(CENTER);

  if (mousePressed) {
    initialPosition();
  }
  
  ortho(); //technical appearance
  
  //draw small (side) quads
  drawQuad(950, 400, 0, motor[0], motor[2], motor[1], 90, 0, 0, 1.7);
  drawQuad(950, 600, 0, motor[0], motor[2], motor[1], 0, 0, 0, 1.7);

  //calculate perspective view
  float fov = PI/3.0; 
  float cameraZ = (height/2.0) / tan(fov/2.0); 
  perspective(fov, float(width)/float(height), cameraZ/2.0, cameraZ*2.0); 

  fill(colors[0]);  

  //right side texts
  //  text("FRONT", 850, 130);
  calculatePosition();
  //draw main quad
  drawQuad(posX, posY, posZ, motor[0], motor[2], motor[1], -20, 0, 0, 5);



  drawMotors();
}

//calculates relative position of quad on the screen
void calculatePosition() {
  float increment = 0.0005;  //constant for limiting position change

  //pitch control
  if ((motor[3] + motor[4]) > (motor[5] + motor[6])) {
    posZ += increment * (motor[3] + motor[4] - motor[5] - motor[6]);
  } else {
    posZ += increment * (motor[3] + motor[4] - motor[5] - motor[6]);
  }

  //roll control
  if ((motor[3] + motor[5]) > (motor[4] + motor[6])) {
    posX += increment * (motor[3] + motor[5] - motor[4] - motor[6]);
  } else {
    posX += increment * (motor[3] + motor[5] - motor[4] - motor[6]);
  }

  //altitude control
  if ((motor[3] + motor[4] + motor[5] + motor[6]) > 6000) {
    posY -= increment * (motor[3] + motor[4] + motor[5] + motor[6])/15;
  } else {
    posY += increment * (motor[3] + motor[4] + motor[5] + motor[6])/15;
  }
}

void initialPosition() {
  posX = width/2;
  posY = height/2;
  posZ = 0;
}

//1 - 3 arguments: positioning the quad's center
//4 - 6 arguments: rotation for desired axis
//7 - 9 arguments: shift of rotation for better visualization
//10 argument: scaling factor of drawing. usually between 1-10
void drawQuad(float _posX, float _posY, float _posZ, int _rx, int _ry, int _rz, int _sx, int _sy, int _sz, float _scale) {
  pushMatrix();

  translate(_posX, _posY, _posZ);  //translate to the desired position (center)

  //rotate and shift
  rotateX(radians(_rx + _sx));
  rotateY(radians(_ry + _sy - 45));   
  rotateZ(radians(_rz + _sz));

  strokeWeight(0.2);  //use scalar to lower thickness
  stroke(50);  //grayish stroke color

  scale(_scale);  //scale quad

  //below draws actual quad.
  //order of the lines are extremely important because of translation
  rotateY(radians(45));
  fill(colors[1]);
  box(20, 10, 20);  //middle
  fill(colors[2]);
  translate(0, -6, 0);
  box(20, 2, 20);  //up indicator
  translate(0, 6, 0);
  rotateY(radians(-45));

  translate(0, 0, 25);
  fill(colors[1]);
  box(2, 2, 30);  //branch2
  translate(0, 0, 18);
  fill(colors[2]);
  box(6);  //motor2

  translate(0, 0, -68);
  fill(colors[1]);
  box(2, 2, 30);  //branch4
  translate(0, 0, -18);
  fill(colors[0]);
  box(6);  //motor4

  translate(25, 0, 43);
  fill(colors[1]);
  box(30, 2, 2);  //branch1
  translate(18, 0, 0);
  fill(colors[2]);
  box(6);  //motor1

  translate(-68, 0, 0);
  fill(colors[1]);
  box(30, 2, 2);  //branch3
  translate(-18, 0, 0);
  fill(colors[0]);
  box(6);  //motor3
  //end of quad drawing
  popMatrix();
}

void serialEvent(Serial port) {
  try {
    serialData = port.readStringUntil(endChar);
    serialData = serialData.substring(0, serialData.length()-1);

    divideString(serialData);
  }
  catch(Exception e) {
    println("Hata: " + e);
  }
}

void divideString(String incomingData) {
  if (incomingData != null) {
    println(incomingData); //debug
    String[] data = split(incomingData, ',');

    for (int i = 0; i < data.length; i++) {
      motor[i] = parseInt(data[i]);
    }
  }
}

void drawMotors() {
  int motorSize = 50;
  int _x = 250;
  int _y = 90;
  textSize(18);
  noStroke();

  text("Motor Speeds:", 80, _y);

  for (int i=3; i<7; i++) {
    if (i>4) {
      fill(colors[0]);
    } else {
      fill(colors[2]);
    }
    ellipse(_x+(i-3)*150, _y, motorSize, motorSize);
    text(motor[i], _x+(i-3)*150, _y+50);
    text("Motor " + (i-2), _x+(i-3)*150, _y-40 );
    if (motor[i] > 1000) {
      rect(_x+(i-3)*150-70, _y+150, 140, -map(motor[i], 1000, 2000, 0, 90) );
    }
  }
}

//creates color array for easy usage in the program
void colorsInit() {
  //source: http://www.colourlovers.com/palette/1473/Ocean_Five
  color blue = color(0, 160, 176);
  color brown = color(106, 74, 60);
  color red = color(204, 51, 63);
  color orange = color(235, 104, 65);
  color yellow = color(237, 201, 81);

  colors = new color[5];  //create and add colors to the array

  colors[0] = blue;
  colors[1] = brown;
  colors[2] = red;
  colors[3] = orange;
  colors[4] = yellow;
}

//shows the possible colors on the screen
void sampleColors() {
  int lenY = 20;  //height of the bars
  noStroke();  //dont want stroke
  for (int i=0; i<colors.length; i++) {
    fill(colors[i]);
    rect(i*(width/5), 0, width/5, lenY);
  }
}

