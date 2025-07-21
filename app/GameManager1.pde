// GameManager.pde

class GameManager1 {
  int score;
  int targetScore = 10;
  
  long startTime;
  float clearTime;
  
  boolean isGameActive;
  boolean isTimerStarted;
  
  boolean missed = false;  // ★ ゴールを防がれたかどうかのフラグ
  boolean justScored = false; // ★ ゴール直後かどうかのフラグを追加
  
  private boolean wasBallMoving = false;
  private boolean isWaitingForReset = false;
  private long arrivalTime = 0;
  private final int RESET_DELAY = 1500;

  PFont japaneseFont;

  GameManager1() {
    japaneseFont = loadFont("MeiryoUI-24.vlw"); 
    reset(null, null);
  }
  
  void handleMouseClick(Goalkeeper1 gk, Ball1 b) {
    if (!isGameActive || b.isMoving || isWaitingForReset) return; 

    if (!isTimerStarted) {
      startTime = millis();
      isTimerStarted = true;
    }
    
    gk.move(mouseX, mouseY);
    b.shoot(mouseX, mouseY);
  }
  
  void update(Goalkeeper1 gk, Ball1 b) {
    if (wasBallMoving && !b.isMoving) {
      if (!gk.isBlocking((int)b.position.x, (int)b.position.y)) {
        score++;
        justScored = true; // ★ ゴールしたのでフラグをtrueに
        missed = false; // ゴール成功時はMISSではない
      } else {
      missed = true;  // ★ キーパーが防いだ！
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
        justScored = false; // ★ ボールリセットでフラグをfalseに
        missed = false;  // ★ 表示をリセット
      }
    }
    
    wasBallMoving = b.isMoving;
  }
  
  void reset(Goalkeeper1 gk, Ball1 b) {
    score = 0;
    isGameActive = true;
    isTimerStarted = false;
    wasBallMoving = false;
    isWaitingForReset = false;
    justScored = false; // ★ ゲームリセットでフラグをfalseに
    missed = false;  // ★ リセット時も初期化
    if (b != null) b.reset();
    if (gk != null) gk.reset();
  }

  void displayInfo() {
    textFont(japaneseFont);

    // スコア表示
    textSize(32);      
    strokeWeight(3);   
    stroke(0);         
    fill(0);           
    textAlign(LEFT);
    text("SCORE: " + score, 20, 30);
    
    noStroke(); 
    
        // === 「Goal!」表示追加 ===
    if (justScored && isGameActive) {
      textAlign(CENTER, CENTER);
      textSize(60);
      fill(255, 0, 0); // 赤文字
      text("GOAL!", width / 2, height / 2);
    } else if (missed && isGameActive) {
  textAlign(CENTER, CENTER);
  textSize(60);
  fill(0, 150, 255);
  text("MISS!", width / 2, height / 2);
}
    // クリア表示など
    if (!isGameActive) {
      textAlign(CENTER, CENTER);
      textSize(80);
      fill(255, 255, 0);
      text("CLEAR!", width / 2, height / 2 - 30);
      
      textSize(40);
      fill(255);
      text(String.format("TIME: %.2f sec", clearTime), width / 2, height / 2 + 40);
      
      textSize(18);
      fill(255);
      text("クリックしてもう一度プレイ", width / 2, height - 60);
      
    } else if (!isTimerStarted) {
      textAlign(CENTER, CENTER);
      textSize(24);
      fill(255);
      text("ゴール内をクリックしてスタート", width / 2, height - 60);
    }
  }
}
