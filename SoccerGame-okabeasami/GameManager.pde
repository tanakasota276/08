// GameManager.pde（改善版）
class GameManager {
  Goal goal;
  Goalkeeper keeper;
  Ball ball;
  int score = 0;
  int maxScore = 10;
  boolean cleared = false;
  boolean started = false;
  int startTime;
  int clearTime;

  boolean waitingForReset = false;
  int resetTimerStart = 0;
  int resetDelay = 800; // ms

  GameManager(Goal g, Goalkeeper k, Ball b) {
    goal = g;
    keeper = k;
    ball = b;
  }

  void handleClick(float mx, float my) {
    if (cleared || waitingForReset) return;
    if (!started) {
      started = true;
      startTime = millis();
    }
    if (goal.isInside(mx, my) && !ball.moving) {
      ball.shootTo(mx, my);
    }
  }

  void display() {
    fill(0);
    textSize(24);
    text("Score: " + score + "/10", 20, 30);

    if (started && !cleared && ball.isStopped() && ball.isInGoalArea() && !waitingForReset) {
      if (!keeper.isBlocking(ball.target.x)) {
        score++;
      }

      if (score >= maxScore) {
        cleared = true;
        clearTime = millis() - startTime;
      }

      waitingForReset = true;
      resetTimerStart = millis();
    }

    if (waitingForReset && millis() - resetTimerStart >= resetDelay) {
      ball.reset();
      waitingForReset = false;
    }

    if (cleared) {
      text("CLEAR! Time: " + nf(clearTime / 1000.0, 0, 2) + " sec", 250, 300);
    }
  }
}
