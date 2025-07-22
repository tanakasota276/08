// === SoccerGame.pde ===

PImage backgroundImage;
PImage titleImage;

GameManager1 gameManager;
Goalkeeper1 keeper;
Ball1 ball;

// ゲームの状態を管理
enum GameState {
  START, PLAYING, CLEAR
}
GameState gameState = GameState.START;

// 難易度管理
enum Difficulty {
  EASY, NORMAL, HARD
}
Difficulty currentDifficulty = Difficulty.NORMAL;

// ゴールエリア
float goalX, goalY, goalWidth, goalHeight;

// アニメーション・ボタン用
float titleAnimOffset = 0;
float titleAnimSpeed = 0.1;
float startBtnX = 200;
float startBtnY = 300;
float startBtnW = 200;
float startBtnH = 50;

float easyBtnX = 100, easyBtnY = 220;
float normalBtnX = 250, normalBtnY = 220;
float hardBtnX = 400, hardBtnY = 220;
float diffBtnW = 100, diffBtnH = 40;

void setup() {
  size(600, 400);
  backgroundImage = loadImage("soccergoal.jpeg");
  titleImage = loadImage("title.jpg");

  goalWidth = 400;
  goalHeight = 200;
  goalX = (width - goalWidth) / 2;
  goalY = 50;

  keeper = new Goalkeeper1(goalX, goalY, goalWidth, goalHeight);
  keeper.setDifficulty(currentDifficulty);

  ball = new Ball1();
  gameManager = new GameManager1();
}

void draw() {
  image(backgroundImage, 0, 0, width, height);

  if (gameState == GameState.START) {
    showStartScreen();
  } else if (gameState == GameState.PLAYING) {
    gameManager.update(keeper, ball);

    if (gameManager.justScored) {
      ball.display();
      keeper.display();
    } else {
      keeper.display();
      ball.display();
    }

    gameManager.displayInfo();

    if (!gameManager.isGameActive) {
      gameState = GameState.CLEAR;
    }

  } else if (gameState == GameState.CLEAR) {
    gameManager.displayInfo();
  }
}

void mousePressed() {
  if (gameState == GameState.START) {
    if (mouseX > easyBtnX && mouseX < easyBtnX + diffBtnW &&
        mouseY > easyBtnY && mouseY < easyBtnY + diffBtnH) {
      currentDifficulty = Difficulty.EASY;
      return;
    }
    if (mouseX > normalBtnX && mouseX < normalBtnX + diffBtnW &&
        mouseY > normalBtnY && mouseY < normalBtnY + diffBtnH) {
      currentDifficulty = Difficulty.NORMAL;
      return;
    }
    if (mouseX > hardBtnX && mouseX < hardBtnX + diffBtnW &&
        mouseY > hardBtnY && mouseY < hardBtnY + diffBtnH) {
      currentDifficulty = Difficulty.HARD;
      return;
    }

    if (mouseX > startBtnX && mouseX < startBtnX + startBtnW &&
        mouseY > startBtnY && mouseY < startBtnY + startBtnH) {
      gameManager.reset(keeper, ball);
      applyDifficultyToKeeper();
      gameState = GameState.PLAYING;
    }
    return;
  }

  if (gameState == GameState.PLAYING) {
    boolean isMouseInGoal = (mouseX > goalX + 30 && mouseX < goalX + goalWidth - 30 &&
                              mouseY > goalY && mouseY < goalY + goalHeight - 40);
    if (isMouseInGoal) {
      gameManager.handleMouseClick(keeper, ball);
    } else if (!gameManager.isGameActive) {
      gameManager.reset(keeper, ball);
      keeper.setDifficulty(currentDifficulty);

    }
  }

  if (gameState == GameState.CLEAR) {
    gameManager.reset(keeper, ball);
    gameState = GameState.START;
  }
}

void showStartScreen() {
  image(titleImage, 0, 0, width, height);
  textFont(gameManager.japaneseFont);
  textAlign(CENTER, CENTER);

  titleAnimOffset += titleAnimSpeed;
  float yOffset = sin(titleAnimOffset) * 5;

  String title = "\u26bd Soccer Shoot Challenge!";
  textSize(47);
  fill(0, 0, 0, 150);
  text(title, width / 2 + 3, 80 + yOffset + 3);
  fill(255, 255, 0);
  text(title, width / 2, 80 + yOffset);

  textSize(22);
  fill(255);
  text("キーパーをかわしてゴールを決めろ!!", width / 2, 140);

  drawStartButton();
  drawDifficultyButtons();
}

void drawStartButton() {
  fill(0, 200, 0);
  stroke(255);
  strokeWeight(3);
  rect(startBtnX, startBtnY, startBtnW, startBtnH, 15);

  fill(255);
  textSize(24);
  text("▶ スタート", startBtnX + startBtnW / 2, startBtnY + startBtnH / 2);
}

void drawDifficultyButtons() {
  drawDifficultyButton("Easy", easyBtnX, easyBtnY, currentDifficulty == Difficulty.EASY);
  drawDifficultyButton("Normal", normalBtnX, normalBtnY, currentDifficulty == Difficulty.NORMAL);
  drawDifficultyButton("Hard", hardBtnX, hardBtnY, currentDifficulty == Difficulty.HARD);
}

void drawDifficultyButton(String label, float x, float y, boolean selected) {
  if (selected) fill(255, 150, 0); else fill(50);
  stroke(255); strokeWeight(2);
  rect(x, y, diffBtnW, diffBtnH, 10);

  fill(255);
  textSize(18);
  textAlign(CENTER, CENTER);
  text(label, x + diffBtnW / 2, y + diffBtnH / 2);
}

void applyDifficultyToKeeper() {
  if (currentDifficulty == Difficulty.EASY) {
    keeper.reactionChance = 0.3;
    keeper.speed = 10;
  } else if (currentDifficulty == Difficulty.NORMAL) {
    keeper.reactionChance = 0.6;
    keeper.speed = 15;
  } else if (currentDifficulty == Difficulty.HARD) {
    keeper.reactionChance = 0.85;
    keeper.speed = 20;
  }
}
