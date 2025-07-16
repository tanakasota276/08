class GoalKeeper {
  float x, y;
  float radius = 40;
  float vx = 4;

  GoalKeeper() {
    x = width / 2;
    // y座標をゴールの下辺に合わせて調整（高さは draw() 内で再設定）
  }

  void update() {
    x += vx;
    // ゴール枠内の左右端で反転
    if (x < goal.x + radius || x > goal.x + goal.w - radius) {
      vx *= -1;
    }

    // y座標を毎フレーム更新してゴール下辺に固定
    y = goal.y + goal.h - radius;
  }

void display() {
  imageMode(CENTER);
  image(keeperImage, x, y, 80, 80);  // サイズ調整可
}


  boolean isSaved(float sx, float sy) {
    float d = dist(sx, sy, x, y);
    return d <= radius;
  }
}
