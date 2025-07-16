Ball ball;
Goal goal;
Goalkeeper keeper;
GameManager manager;
PImage goalImg, ballImg;

void setup() {
  size(800, 600);
  goalImg = loadImage("goal.png");
  ballImg = loadImage("ball.png");
  goal = new Goal(goalImg);
  ball = new Ball(ballImg);
  keeper = new Goalkeeper(goal);
  manager = new GameManager(goal, keeper, ball);
}

void draw() {
  background(50, 150, 50);
  goal.display();
  keeper.update();
  keeper.display();
  ball.update();
  ball.display();
  manager.display();
}

void mousePressed() {
  manager.handleClick(mouseX, mouseY);
}
