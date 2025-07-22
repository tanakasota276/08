// === Ball1.pde ===

class Ball1 {
  PVector position;
  PVector initialPosition;
  PVector targetPosition;

  PImage ballImage;
  float ballSize = 50;
  float speed = 40; // デフォルト速度（後で変更可能）

  boolean isMoving;

  Ball1() {
    ballImage = loadImage("soccerball.png");
    initialPosition = new PVector(width / 2, height - 40);
    position = initialPosition.copy();
    targetPosition = new PVector();
    isMoving = false;
  }

  void shoot(int x, int y) {
    if (!isMoving) {
      targetPosition.set(x, y);
      isMoving = true;
    }
  }

  void reset() {
    position.set(initialPosition);
    isMoving = false;
  }

  void update() {
    if (isMoving) {
      PVector direction = PVector.sub(targetPosition, position);
      if (direction.mag() < speed) {
        position.set(targetPosition);
        isMoving = false;
      } else {
        direction.normalize();
        direction.mult(speed);
        position.add(direction);
      }
    }
  }

  void display() {
    update();
    imageMode(CENTER);
    image(ballImage, position.x, position.y, ballSize, ballSize);
    imageMode(CORNER);
  }

  void setSpeed(float s) {
    speed = s;
  }
}
