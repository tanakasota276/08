class Ball {
  float x, y;
  float targetX, targetY;
  float speed = 10;
  boolean moving = false;
  boolean shotFinished = true;
  boolean stoppedByKeeper = false;

  Ball() {
    reset();
  }

  void reset() {
    x = width / 2;
    y = height - 30;
    targetX = x;
    targetY = y;
    moving = false;
    shotFinished = true;
    stoppedByKeeper = false;
  }

  void shootTo(float tx, float ty) {
    if (!moving) {
      targetX = tx;
      targetY = ty;
      moving = true;
      shotFinished = false;
      stoppedByKeeper = false;
    }
  }

  void update() {
    if (moving && !stoppedByKeeper) {
      float dx = targetX - x;
      float dy = targetY - y;
      float dist = sqrt(dx*dx + dy*dy);

      if (dist < speed) {
        x = targetX;
        y = targetY;
        moving = false;
        shotFinished = true;
      } else {
        x += speed * dx / dist;
        y += speed * dy / dist;
      }
    }
  }

  void stopByKeeper() {
    moving = false;
    shotFinished = true;
    stoppedByKeeper = true;
  }

void display() {
  imageMode(CENTER);
  image(ballImage, x, y, 30, 30);  // サイズ調整可
}


  boolean isMoving() {
    return moving;
  }

  boolean isFinished() {
    return shotFinished;
  }

  boolean isStoppedByKeeper() {
    return stoppedByKeeper;
  }
}
