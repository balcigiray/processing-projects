Mover[] movers = new Mover[100];



void setup(){
  size(1000, 800);
  
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover(random(0.1, 5), 0, 0);
  }

}

void draw(){
  background(255);

  PVector wind = new PVector(0.01, 0);
  PVector gravity = new PVector(0, 0.1);

  for(int i = 0; i < movers.length; i++){
    movers[i].applyForce(wind);  
    //movers[i].applyForce(gravity);

    PVector loc = movers[i].location; 
    loc = loc.mult(0.99999);
    PVector distance = new PVector(width/2, height/2).sub(loc);
    distance.x *= abs(distance.x);
    distance.y *= abs(distance.y);
    
    //if(distance.x < 0){
    //  distance.x *= -1;
    //}
    
    //if(distance.y < 0){
    //  distance.y *= -1;
    //}
    
        
    if(i == 0){
      println(distance.x);
    }
    
    PVector pushingForce = distance.mult(0.0000005);

    
    movers[i].applyForce(pushingForce);
    
    movers[i].update();
    movers[i].display();
    
    
    //movers[i].checkEdges();
}
  
  
}