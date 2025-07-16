// Ball.pde

class Ball {
  PVector position;
  PVector initialPosition;
  PVector targetPosition;
  
  PImage ballImage; // ★ 1. ボールの画像を格納する変数を追加
  
  float ballSize = 50;
  float speed = 40;
  
  boolean isMoving;

  // コンストラクタ
  Ball() {
    // ★ 2. dataフォルダから画像を読み込む
    ballImage = loadImage("soccerball.png");

    initialPosition = new PVector(width / 2, height - 40);
    position = initialPosition.copy();
    targetPosition = new PVector();
    isMoving = false;
  }
  
  // シュート（アニメーションを開始）
  void shoot(int x, int y) {
    if (!isMoving) {
      targetPosition.set(x, y);
      isMoving = true;
    }
  }

  // ボールを初期位置に戻す
  void reset() {
    position.set(initialPosition);
    isMoving = false;
  }
  
  // アニメーションの更新処理
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

  // 描画
  void display() {
    update();
    
    // ★ 3. ellipse()の代わりにimage()で画像を描画する
    // fill(255);
    // noStroke();
    // ellipse(position.x, position.y, ballSize, ballSize);
  imageMode(CENTER); // ボールを描画する時だけ、基準点を「中心」に変更
  image(ballImage, position.x, position.y, ballSize, ballSize);
  imageMode(CORNER);  // すぐに基準点をデフォルトの「左上」に戻す
  }
}
