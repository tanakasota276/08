// === グローバル変数 ===
GameManager gameManager;
Goalkeeper keeper;
Ball ball;

// ゴールエリアの定義
float goalX, goalY, goalWidth, goalHeight;

// === ゲームの初期設定 ===
void setup() {
  size(600, 400); 
  
  goalWidth = 400;
  goalHeight = 200;
  goalX = (width - goalWidth) / 2;
  goalY = 50;
  
  // 各クラスのオブジェクトを生成
  keeper = new Goalkeeper(goalX, goalY, goalWidth, goalHeight);
  ball = new Ball();
  gameManager = new GameManager();
}

// === メインの描画ループ ===
void draw() {
  background(100, 200, 100); 

  // ゴールを描画
  stroke(255);
  strokeWeight(3);
  noFill();
  rect(goalX, goalY, goalWidth, goalHeight);
  
  // 各オブジェクトの更新と描画
  // ★★★ 変更点: GameManagerがボールとキーパーの状態を監視する ★★★
  gameManager.update(keeper, ball);
  
  keeper.display();
  ball.display();
  gameManager.displayInfo(); // 文字情報の描画メソッドを分離
}

// === マウスクリック時の処理 ===
void mousePressed() {
  boolean isMouseInGoal = (mouseX > goalX && mouseX < goalX + goalWidth && 
                           mouseY > goalY && mouseY < goalY + goalHeight);
                           
  if (isMouseInGoal) {
    // ★★★ 変更点: GameManagerのクリック処理メソッドを呼び出す ★★★
    gameManager.handleMouseClick(keeper, ball);
  } else if (!gameManager.isGameActive) {
    gameManager.reset(keeper, ball);
  }
}
