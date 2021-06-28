ArrayList<Daisy> daisies;

void setup() {
  frameRate(30);
  //fullScreen();
  size(800, 600);
  daisies = new ArrayList<Daisy>();
  daisies.add(new Daisy(new PVector(random(width), random(height))));
}

void draw() {
  background(#0A2402);

  if (frameCount % 2 == 0) {
    daisies.add(new Daisy(new PVector(random(width), random(height))));
  }

  //println("Flowers: " + daisies.size());

  for (int i = 0; i<daisies.size(); i++) {
    Daisy p = daisies.get(i);
    p.update();
    p.display();

    if (p.isDead()) {
      daisies.remove(i);
    }
  }

  if (mousePressed) {
    daisies.add(new Daisy(new PVector(random(width), random(height))));
  }
}


void mousePressed() {
  int count = 100;
  for (int i =0; i<count; i++) {
    // daisies.add(new Daisy(new PVector(random(width), random(height))));
  }
}
