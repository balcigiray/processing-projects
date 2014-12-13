ArrayList<Candle> candles = new ArrayList<Candle>();

void setup()
{  
  size(800, 600);
  background(255);
  smooth();  
  noFill();
  stroke(0);
}

void draw() {
  background(20);

//draws all the candles
  for (int i = 0; i<candles.size(); i++) {
    Candle mum = candles.get(i);
    mum.animate();
  }
  println(frameRate);
  
//adds new candle on each seceond
  if(frameCount %60 == 0){
    candles.add(new Candle(random(50, width-50), random(200, height), random(0.5, 3)));
  }
}

//adds predefined positioned candles. not used now
void def() {
  for (int i = 0; i<10; i++) {
    candles.add(new Candle(i*100+50, 300, 3));
  }
}
