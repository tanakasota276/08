Ball ball;
GoalKeeper keeper;
Goal goal;
GameController game;
int buttonX, buttonY, buttonW = 200, buttonH = 50;
boolean isButtonHovered = false;
PImage goalImage, keeperImage, ballImage;

void setup() {
  size(800, 600);

  goalImage = loadImage("soccer_goal.png");
  keeperImage = loadImage("goal_keeper.png");
  ballImage = loadImage("soccer_ball.png");


  ball = new Ball();
  keeper = new GoalKeeper();
  goal = new Goal(100, 100, 600, 300);
  game = new GameController(ball, keeper, goal);

  buttonX = width / 2 - buttonW / 2;
  buttonY = height / 2 + 60;
}


void draw() {
  
 background(34, 139, 34);
  
  goal.display();
  keeper.update();
  keeper.display();
  ball.update();
  ball.display();
  game.displayScore();
  game.checkResult();
  game.displayMessage();

  if (game.isGameClear()) {
    game.displayClearTime();
    // マウスオーバー判定
  isButtonHovered = (mouseX >= buttonX && mouseX <= buttonX + buttonW &&
                     mouseY >= buttonY && mouseY <= buttonY + buttonH);

  // ボタン描画
  fill(isButtonHovered ? color(180, 220, 180) : color(200));
  stroke(0);
  rect(buttonX, buttonY, buttonW, buttonH, 10);

  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("restart", buttonX + buttonW / 2, buttonY + buttonH / 2);
  }
  
}

void mousePressed() {
  if (game.canShoot()) {
    game.shoot(mouseX, mouseY);
  }
  if (game.isGameClear()) {
    if (mouseX >= buttonX && mouseX <= buttonX + buttonW &&
        mouseY >= buttonY && mouseY <= buttonY + buttonH) {
      game.resetGame();
    }
  }
}
