class Goalkeeper {
  float x, y;
  int w = 60, h = 50;
  float speed = 3;
  Goal goal;

  Goalkeeper(Goal g) {
    goal = g;
    x = goal.x + goal.w / 2 - w / 2;
    y = goal.y;
  }

  void update() {
    x += random(-speed, speed);
    x = constrain(x, goal.x, goal.x + goal.w - w);
  }

  void display() {
    fill(255, 0, 0);
    rect(x, y, w, h);
  }

  boolean isBlocking(float px) {
    return px > x && px < x + w;
  }
}
