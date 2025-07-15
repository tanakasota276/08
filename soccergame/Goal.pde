class Goal {
  float x, y;         // 左上の座標
  float w, h;         // ゴールの幅と高さ

  Goal(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

void display() {
  imageMode(CORNER);  // 左上基準
  image(goalImage, x, y, w, h);
}


  boolean isInside(float mx, float my) {
    return (mx >= x && mx <= x + w && my >= y && my <= y + h);
  }
}
