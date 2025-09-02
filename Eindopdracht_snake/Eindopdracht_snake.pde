ArrayList<PVector> grid;
PFont handJet;
boolean dead;
Apple ap1;
Snake snake;

void setup() {
  size(850, 850);
  background(24);

  handJet = createFont("Handjet-Light.ttf", 180);

  grid = new ArrayList<PVector>();
  for (int i = 0; i < 850; i += 50) {
    for (int j = 0; j < 850; j += 50) {
      grid.add(new PVector(j, i));
    }
  }
  
  ap1 = new Apple();
  snake = new Snake(grid.size()/2);
  
  frameRate(8);
}

void draw() {
  snake.update();
  ap1.update();
  gameOver();
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    if (snake.direction != 3) {
      snake.direction = 1;
    }
  } else if (key == 'a' || key == 'A') {
    if (snake.direction != 4) {
      snake.direction = 2;
    }
  } else if (key == 's' || key == 'S') {
    if (snake.direction != 1) {
      snake.direction = 3;
    }
  } else if (key == 'd' || key == 'D') {
    if (snake.direction != 2) {
      snake.direction = 4;
    }
  }
}

class Snake {
  int lastPos, currentPos;
  byte direction;
  IntList tailPositions;

  Snake(int startPos) {
    lastPos = startPos;
    currentPos = lastPos;
    
    tailPositions = new IntList();
  }

  void movement() {
    switch(direction) {
    case 1:
      lastPos = currentPos;
      currentPos = lastPos - 17;
      lastPos = currentPos + 17;
      break;

    case 2:
      lastPos = currentPos;
      currentPos = lastPos - 1;
      lastPos = currentPos + 1;
      break;

    case 3:
      lastPos = currentPos;
      currentPos = lastPos + 17;
      lastPos = currentPos - 17;
      break;

    case 4:
      lastPos = currentPos;
      currentPos = lastPos + 1;
      lastPos = currentPos - 1;
      break;
    }

    background(24);

    if (currentPos >= grid.size()) {
      lastPos = currentPos;
      currentPos = lastPos - 289;
      lastPos = currentPos + 272;
    } else if (currentPos < 0) {
      lastPos = currentPos;
      currentPos = lastPos + 289;
      lastPos = currentPos - 272;
    }

    square(grid.get(currentPos).x, grid.get(currentPos).y, 50);

    if (currentPos % 17 == 0) {
      if (direction == 2) {
        lastPos = currentPos;
        currentPos = lastPos + 17;
      }
    } else if ((currentPos + 1) % 17 == 0) {
      if (direction == 4) {
        lastPos = currentPos;
        currentPos = lastPos - 17;
      }
    }

    if (lastPos % 17 == 0) {
      if (direction == 2) {
        lastPos = currentPos - 16;
      }
    } else if ((lastPos + 1) % 17 == 0) {
      if (direction == 4) {
        lastPos = currentPos + 16;
      }
    }

    for (int i = 1; i < tailPositions.size(); i++) {
      if (currentPos == tailPositions.get(i)) {
        dead = true;
      }
    }
  }

  void drawTail() {
    for (int i = tailPositions.size(); i > 0; i--) {
      if (i == 1) {
        tailPositions.set(i - 1, lastPos);
      } else {
        tailPositions.set(i - 1, tailPositions.get(i - 2));
      }
      
      square(grid.get(tailPositions.get(i-1)).x, grid.get(tailPositions.get(i-1)).y, 50);
    }
  }

  void growTail() {
    if (tailPositions.size() == 0) {
      tailPositions.append(lastPos);
    } else if (tailPositions.size() == 1) {
      tailPositions.append(tailPositions.get(0));
    } else {
      tailPositions.append(tailPositions.get(tailPositions.size() - 2));
    }
  }

  void update() {
    movement();
    drawTail();
  }
}

class Apple {
  int applePos;
  PShape apple;
  boolean isApple;

  void apple() {
    if (!isApple) {
      boolean obstructed = false;
      int r = int(random(0, grid.size()));

      for (int i = 0; i < snake.tailPositions.size() - 1; i++) {
        if (!obstructed) {
          if (r == snake.tailPositions.get(i)) {
            obstructed = true;
          }
        }
      }

      if (r != snake.currentPos && !obstructed) {
        apple = createShape(RECT, grid.get(r).x, grid.get(r).y, 50, 50);
        apple.setFill(color(40, 240, 10));
        shape(apple, 0, 0);

        applePos = r;
        isApple = true;
      } else {
        return;
      }
    } else {
      apple = createShape(RECT, grid.get(applePos).x, grid.get(applePos).y, 50, 50);
      apple.setFill(color(40, 240, 10));
      shape(apple, 0, 0);
    }

    if (applePos == snake.currentPos || applePos == snake.lastPos) {
      isApple = false;
      snake.growTail();
    }
  }

  void update() {
    apple();
  }
}

void gameOver() {
  if (dead) {
    noLoop();
    background(24);
    textFont(handJet);
    text("Game Over", 120, 450);
  }
}
