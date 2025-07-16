class GameController {
  int score = 0;
  int startTime = 0;
  int clearTime = 0;
  boolean started = false;
  boolean cleared = false;
  Ball ball;
  GoalKeeper keeper;
  Goal goal;
  String message = "";
  int messageTime = 0;

  GameController(Ball b, GoalKeeper k, Goal g) {
    ball = b;
    keeper = k;
    goal = g;
  }

  void shoot(int x, int y) {
    if (!started) {
      started = true;
      startTime = millis();
    }

    if (!cleared && goal.isInside(x, y) && !ball.isMoving()) {
      ball.shootTo(x, y);
    }
  }

void checkResult() {
  // キーパーに当たったらボールを止めてMISS
  if (ball.isMoving() && keeper.isSaved(ball.x, ball.y)) {
    ball.stopByKeeper();
    message = "MISS!";
    messageTime = millis();
  }

  // ゴールに入っていてキーパーに止められていない、かつ1回のみ加点
  if (ball.isFinished() && !ball.isStoppedByKeeper() && message == "") {
    if (goal.isInside(ball.x, ball.y)) {
      score++;
      message = "GOAL!";
      messageTime = millis();
      if (score >= 10) {
        cleared = true;
        clearTime = millis() - startTime;
      }
    }
  }

  // ボールが止まってから1秒経過したらリセット（GOAL/MISSに関わらず）
  if (ball.isFinished() && millis() - messageTime > 1000 && message != "") {
    ball.reset();
    message = "";
  }
}


  void displayScore() {
    fill(0);
    textSize(20);
    textAlign(LEFT, TOP);  
    text("Score: " + score, 40, 30);
  }

  void displayClearTime() {
    fill(0);
    textSize(24);
    text("CLEAR! Time: " + nf(clearTime / 1000.0, 1, 2) + "s", width/2 - 100, height/2);
  }

  void displayMessage() {
    if (millis() - messageTime < 1000 && message != "") {
      fill(message.equals("GOAL!") ? color(0, 200, 0) : color(200, 0, 0));
      textSize(40);
      textAlign(CENTER);
      text(message, width / 2, height / 2 - 100);
    }
  }

  boolean isGameClear() {
    return cleared;
  }
  
  boolean canShoot() {
  return !cleared && ball.isFinished() && message.equals("");
}
 void resetGame() {
  score = 0;
  startTime = 0;
  clearTime = 0;
  started = false;
  cleared = false;
  message = "";
  messageTime = 0;
  ball.reset();
}

}
