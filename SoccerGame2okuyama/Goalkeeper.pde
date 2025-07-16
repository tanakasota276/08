// Goalkeeper.pde

class Goalkeeper {
  // === 基本的な属性 ===
  PVector position;
  float w = 120; // 当たり判定の幅
  float h = 180; // 当たり判定の高さ
  float boundsX, boundsY, boundsW, boundsH;

  PImage keeperImage; // ★ 1. キーパーの画像を格納する変数を追加

  // === アニメーション用の属性 ===
  PVector targetPosition;
  float speed = 20;
  boolean isMoving;
  
  // ★★★ 変更点: キーパーの賢さを決める確率 ★★★
  final float reactionChance = 0.65; 

  // コンストラクタ
  Goalkeeper(float x, float y, float gw, float gh) {
    boundsX = x;
    boundsY = y;
    boundsW = gw;
    boundsH = gh;
    
    // ★ 2. dataフォルダから画像を読み込む
    keeperImage = loadImage("keeper.png");
    
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
  }

  // AIの核となる移動ロジック (変更なし)
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
  }
  
  // 位置の更新 (変更なし)
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

  // 当たり判定 (変更なし)
  boolean isBlocking(int x, int y) {
    return (x > position.x && x < position.x + w && y > position.y && y < position.y + h);
  }

  // 描画
  void display() {
    update();
    
    // ★ 3. rect()の代わりにimage()で画像を描画する
    // fill(0, 0, 255);
    // noStroke();
    // rect(position.x, position.y, w, h);
    image(keeperImage, position.x, position.y, w, h);
  }
}
