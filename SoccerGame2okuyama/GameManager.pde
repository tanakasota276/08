//GameManager.pde
class GameManager {
  int score;
  int targetScore = 10;
  
  long startTime;
  float clearTime;
  
  boolean isGameActive;
  boolean isTimerStarted;
  
  private boolean wasBallMoving = false;
  private boolean isWaitingForReset = false;
  private long arrivalTime = 0;
  private final int RESET_DELAY = 1500;

  GameManager() {
    reset(null, null);
  }
  
  // クリック時の処理
  void handleMouseClick(Goalkeeper gk, Ball b) {
    if (!isGameActive || b.isMoving || isWaitingForReset) return; 

    if (!isTimerStarted) {
      startTime = millis();
      isTimerStarted = true;
    }
    
    // ★★★ 変更点: moveメソッドにマウス座標を渡す ★★★
    gk.move(mouseX, mouseY);
    b.shoot(mouseX, mouseY);
  }
  
  void update(Goalkeeper gk, Ball b) {
    if (wasBallMoving && !b.isMoving) {
      if (!gk.isBlocking((int)b.position.x, (int)b.position.y)) {
        score++;
      }
      
      if (score >= targetScore) {
        isGameActive = false;
        clearTime = (millis() - startTime) / 1000.0;
      } else {
        isWaitingForReset = true;
        arrivalTime = millis();
      }
    }
    
    if (isWaitingForReset) {
      if (millis() - arrivalTime > RESET_DELAY) {
        b.reset();
        isWaitingForReset = false;
      }
    }
    
    wasBallMoving = b.isMoving;
  }
  
  void reset(Goalkeeper gk, Ball b) {
    score = 0;
    isGameActive = true;
    isTimerStarted = false;
    wasBallMoving = false;
    isWaitingForReset = false;
    if (b != null) b.reset();
    if (gk != null) gk.reset();
  }
  
  void displayInfo() {
    fill(255);
    textSize(24);
    textAlign(LEFT);
    text("SCORE: " + score, 20, 30);
    
    if (!isGameActive) {
      textAlign(CENTER, CENTER);
      textSize(80);
      fill(255, 255, 0);
      text("CLEAR!", width / 2, height / 2 - 30);
      
      textSize(40);
      text(String.format("TIME: %.2f sec", clearTime), width / 2, height / 2 + 40);
      
      textSize(18);
      fill(255);
      text("クリックしてもう一度プレイ", width / 2, height - 60);
      
    } else if (!isTimerStarted) {
      textAlign(CENTER, CENTER);
      textSize(24);
      text("ゴール内をクリックしてスタート", width / 2, height - 60);
    }
  }
}
