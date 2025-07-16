class Goal {
  int x = 200;
  int y = 100;
  int w = 400;
  int h = 50;
  PImage img;

  Goal(PImage img_) {
    img = img_;
  }

  void display() {
    if (img != null) {
      image(img, x, y - 50, w, 150);
    } else {
      fill(200);
      rect(x, y, w, h);
    }
  }

  boolean isInside(float px, float py) {
    return px > x && px < x + w && py > y && py < y + h;
  }
}
