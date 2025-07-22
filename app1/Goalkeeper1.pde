// === Goalkeeper1.pde ===

class Goalkeeper1 {
  PVector position;
  float w = 120;
  float h = 180;
  float boundsX, boundsY, boundsW, boundsH;

  PImage keeperStandImage;
  PImage keeperDiveLeftImage;
  PImage keeperDiveRightImage;

  PVector targetPosition;
  float speed = 20;
  boolean isMoving;

  final float reactionChanceDefault = 0.65;
  float reactionChance = reactionChanceDefault;

  boolean facingLeft = true;

  // 防いだ時だけジャンプ画像に切り替え
  boolean blockedLast = false;
  String blockedDirection = "stand"; // "dive_left", "dive_right", "stand"

  Goalkeeper1(float x, float y, float gw, float gh) {
    boundsX = x;
    boundsY = y;
    boundsW = gw;
    boundsH = gh;

    keeperStandImage = loadImage("keeper_stand.png");
    keeperDiveLeftImage = loadImage("keeper_dive_left.png");
    keeperDiveRightImage = loadImage("keeper_dive_right.png");

    position = new PVector();
    targetPosition = new PVector();

    reset();
  }

  void reset() {
    float centerX = boundsX + (boundsW - w) / 2;
    float centerY = boundsY + (boundsH - h) / 2;

    position.set(centerX, centerY);
    targetPosition.set(centerX, centerY);
    isMoving = false;
    facingLeft = true;
    blockedLast = false;
    blockedDirection = "stand";
  }

  void move(float bx, float by) {
    float newTargetX, newTargetY;

    if (random(1.0) < reactionChance) {
      float reactionAreaSize = 150;
      newTargetX = random(bx - reactionAreaSize / 2, bx + reactionAreaSize / 2);
      newTargetY = random(by - reactionAreaSize / 2, by + reactionAreaSize / 2);
    } else {
      newTargetX = random(boundsX, boundsX + boundsW - w);
      newTargetY = random(boundsY, boundsY + boundsH - h);
    }

    newTargetX = constrain(newTargetX, boundsX, boundsX + boundsW - w);
    newTargetY = constrain(newTargetY, boundsY, boundsY + boundsH - h);

    targetPosition.set(newTargetX, newTargetY);
    isMoving = true;

    facingLeft = bx < position.x;
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

  boolean isBlocking(int ballX, int ballY, float ballSize) {
    float ballLeft = ballX - ballSize / 2;
    float ballRight = ballX + ballSize / 2;
    float ballTop = ballY - ballSize / 2;
    float ballBottom = ballY + ballSize / 2;

    float keeperLeft = position.x;
    float keeperRight = position.x + w;
    float keeperTop = position.y;
    float keeperBottom = position.y + h;

    return !(ballRight < keeperLeft || ballLeft > keeperRight || ballBottom < keeperTop || ballTop > keeperBottom);
  }

  void display() {
    update();

    PImage imgToDraw;

    if (blockedLast) {
      if (blockedDirection.equals("dive_left")) {
        imgToDraw = keeperDiveLeftImage;
      } else if (blockedDirection.equals("dive_right")) {
        imgToDraw = keeperDiveRightImage;
      } else {
        imgToDraw = keeperStandImage;
      }
    } else {
      imgToDraw = keeperStandImage; // 通常時は正面姿勢
    }

    imageMode(CORNER);
    image(imgToDraw, position.x, position.y, w, h);
  }

  void setDifficulty(Difficulty diff) {
    if (diff == Difficulty.EASY) {
      reactionChance = 0.5;
      speed = 12;
      w = 100;
    } else if (diff == Difficulty.NORMAL) {
      reactionChance = 0.7;
      speed = 18;
      w = 120;
    } else if (diff == Difficulty.HARD) {
      reactionChance = 0.9;
      speed = 25;
      w = 160;
    }
  }
}
