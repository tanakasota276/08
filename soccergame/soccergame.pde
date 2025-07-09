Ball ball;
GoalKeeper keeper;
Goal goal;
GameController game;

void setup() {
  size(800, 600);
  ball = new Ball();
  keeper = new GoalKeeper();
  goal = new Goal(100, 100, 600, 300);
  game = new GameController(ball, keeper, goal);
}

void draw() {
  background(200);

  goal.display();
  keeper.update();
  keeper.display();
  ball.update();
  ball.display();
  game.displayScore();

  if (game.isGameClear()) {
    game.displayClearTime();
  }
}

void mousePressed() {
  game.shoot(mouseX, mouseY);
}
