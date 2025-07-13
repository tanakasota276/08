//SoccerGame.pde
// === グローバル変数 ===
PImage backgroundImage; // 画像を格納する変数
GameManager gameManager;
Goalkeeper keeper;
Ball ball;

// ゴールエリアの定義 (当たり判定などの内部計算にそのまま使います)
float goalX, goalY, goalWidth, goalHeight;

// === ゲームの初期設定 ===
void setup() {
  size(600, 400);
  
  imageMode(CENTER);

  // ★ 1. ファイル名を "soccergoal.jpeg" に変更
  backgroundImage = loadImage("soccergoal.jpeg");
  
  // ゴールエリアの定義はそのまま残す
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
  // 背景に画像を表示
  image(backgroundImage, 0, 0, width, height);

  // ★ 2. ゴールを描画していた4行を削除またはコメントアウト
  /*
  stroke(255);
  strokeWeight(3);
  noFill();
  rect(goalX, goalY, goalWidth, goalHeight);
  */
  
  // 各オブジェクトの更新と描画
  gameManager.update(keeper, ball);
  
  keeper.display();
  ball.display();
  gameManager.displayInfo();
}

// マウスクリック時の処理は変更なし
void mousePressed() {
// (以下、変更なし)
  boolean isMouseInGoal = (mouseX > goalX && mouseX < goalX + goalWidth && 
                           mouseY > goalY && mouseY < goalY + goalHeight);
                           
  if (isMouseInGoal) {
    gameManager.handleMouseClick(keeper, ball);
  } else if (!gameManager.isGameActive) {
    gameManager.reset(keeper, ball);
  }
}
