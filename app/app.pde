//SoccerGame.pde
// === グローバル変数 ===
PImage backgroundImage;
GameManager1 gameManager;
Goalkeeper1 keeper;
Ball1 ball;

// ゴールエリアの定義
float goalX, goalY, goalWidth, goalHeight;

// === ゲームの初期設定 ===
void setup() {
  size(600, 400);

  backgroundImage = loadImage("soccergoal.jpeg");
  
  goalWidth = 400;
  goalHeight = 200;
  goalX = (width - goalWidth) / 2;
  goalY = 50;
  
  keeper = new Goalkeeper1(goalX, goalY, goalWidth, goalHeight);
  ball = new Ball1();
  gameManager = new GameManager1();
}

// === メインの描画ループ ===
void draw() {
  image(backgroundImage, 0, 0, width, height);

  // 各オブジェクトの更新
  gameManager.update(keeper, ball);
  
  // ★ 描画順を条件分岐
  if (gameManager.justScored) {
    // ゴールが決まった場合：ボール → キーパー (ボールが奥)
    ball.display();
    keeper.display();
  } else {
    // それ以外の場合：キーパー → ボール (ボールが手前)
    keeper.display();
    ball.display();
  }
  
  gameManager.displayInfo();
}

// === マウスクリック時の処理 ===
void mousePressed() {
  boolean isMouseInGoal = (mouseX > goalX && mouseX < goalX + goalWidth && 
                           mouseY > goalY && mouseY < goalY + goalHeight);
                           
  if (isMouseInGoal) {
    gameManager.handleMouseClick(keeper, ball);
  } else if (!gameManager.isGameActive) {
    gameManager.reset(keeper, ball);
  }
}
