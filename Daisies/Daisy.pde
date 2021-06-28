class Daisy {
  PVector location;
  int numberOfPetals = 30;
  float size;
  float scale;
  float shrinkRate;

  float lifeSpan = 255;
  float zeroOffset;

  color centerColor;
  color petalColor;

  Daisy(PVector _loc) {
    location = _loc;
    numberOfPetals = int(random(20, 50));
    size = random(80, 240);
    zeroOffset = random(0, 360);

    scale = random(0.2, 0.5);
    shrinkRate = random(0.001, 0.003);

    petalColor = color(240+random(-15, 15));
    centerColor = color(255+random(-15, 0), 230+random(-15, 15), 75+random(-15, 15));
  }


  void update() {
    //lifeSpan -= 1;
    scale -= shrinkRate;

    boolean fadeColor = true;
    if (true == fadeColor) {
      float c = brightness(petalColor);
      petalColor = color(c-1);

      float r = red(centerColor);
      float g = green(centerColor);
      float b = blue(centerColor);
      
      float fadeRate = 1;
      centerColor = color(constrain(r-fadeRate, 0, 255), constrain(g-fadeRate, 0, 255), constrain(b-fadeRate, 0, 255));
    }
  }


  void display() {
    push();
    translate(location.x, location.y);
    scale(scale);

    float inc = 360.0/numberOfPetals;

    for (int i=0; i<numberOfPetals; i++) {
      push();
      rotate(radians(inc*i+zeroOffset));
      fill(petalColor, lifeSpan);
      ellipse(size, 0, size, size*0.2);
      pop();
    }

    //fill(#FFEA4B, lifeSpan);
    fill(centerColor, lifeSpan);
    circle(0, 0, size);

    pop();
  }

  boolean isDead() {
    if (lifeSpan < 0.0 || scale < 0.01) {
      return true;
    } else {
      return false;
    }
  }
}
