Mover[] movers = new Mover[12];
Liquid liquid;


void setup(){
  size(1000, 800);
  
  reset();
  
  liquid = new Liquid(0, height/2, width, height/4, 0.1);
}

void draw(){
  background(255);
  
  liquid.display();
  
  float c_fric = 0.03;  //friction constant
  
  for(int i = 0; i < movers.length; i++){
    
    if(movers[i].isInside(liquid)){
      movers[i].drag(liquid);
    }
    
    float m = 0.1 * movers[i].mass;
    PVector gravity = new PVector(0, m);
    
    PVector friction = movers[i].velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(c_fric);
     
    movers[i].applyForce(gravity);
    movers[i].applyForce(friction);

    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}


void mousePressed() {
  reset();
}


// Restart all the Mover objects randomly
void reset() {
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.5, 3), 40+i*70, i*15);
  }
}