class Ball {
  PVector pos;
  PVector target;
  boolean moving = false;
  float speed = 10;
  PImage img;

  Ball(PImage img_) {
    img = img_;
    reset();
  }

  void reset() {
    pos = new PVector(width / 2, height - 30);
    target = pos.copy();
    moving = false;
  }

  void update() {
    if (moving) {
      PVector dir = PVector.sub(target, pos);
      if (dir.mag() < 5) {
        moving = false;
      } else {
        dir.setMag(speed);
        pos.add(dir);
      }
    }
  }

  void display() {
    if (img != null) {
      imageMode(CENTER);
      image(img, pos.x, pos.y, 30, 30);
    } else {
      fill(255);
      ellipse(pos.x, pos.y, 20, 20);
    }
  }

  void shootTo(float x, float y) {
    target = new PVector(x, y);
    moving = true;
  }

  boolean isInGoalArea() {
    return target.y < 150;
  }

  boolean isStopped() {
    return !moving;
  }
}
