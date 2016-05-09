//GLOBAL VARIABLE
PVector playerCord = new PVector(20, 30);
PVector blueGhostCord = new PVector(200, 200);
PVector orangeGhostCord = new PVector(230, 200);
PVector redGhostCord = new PVector(260, 200);
PVector pinkGhostCord = new PVector(290, 200);

//making the player and ghosts
Player pacman = new Player(40);
Ghosts blueGhost = new Ghosts(20, #0000FF);
Ghosts orangeGhost = new Ghosts(20, #FFA500);
Ghosts redGhost = new Ghosts(20, #FF0000);
Ghosts pinkGhost = new Ghosts(20, #FFB6C1);

float speed = 1.5;
String direction;

class Player {
  int size;

  Player(int initialSize) {
    size = initialSize;
  }

  void drawPac() {
    background(0);

    // Draw the yellow circle
    fill(255, 255, 0);
    ellipseMode(RADIUS);

    for ( int i=-1; i < 2; i++) {
      for ( int j=-1; j < 2; j++) {
        pushMatrix();
        translate(playerCord.x + (i * width), playerCord.y + (j*height));
        if (direction == "left") { 
          rotate(PI);
        }
        if (direction == "down") { 
          rotate(HALF_PI);
        }
        if (direction == "up") { 
          rotate( PI + HALF_PI );
        }
        arc(0, 0, size, size, map((millis() % 500), 0, 500, 0, 0.52), map((millis() % 500), 0, 500, TWO_PI, 5.76) );
        popMatrix();
      }
    }
  }

  void move() {
    //moving the pacman with the arrow keys
    if (key==CODED) {
      if (keyCode == UP) {
        playerCord.y -= speed;
        direction = "up";
      } else if (keyCode == DOWN) {
        playerCord.y += speed;
        direction = "down";
      } else if (keyCode == RIGHT) {
        playerCord.x += speed;
        direction = "right";
      } else if (keyCode == LEFT) {
        playerCord.x -= speed;
        direction = "left";
      }
    }

    //checking the borders
    if (playerCord.y > height) {
      playerCord.y = 0;
    } else if (playerCord.y < 0) {
      playerCord.y = height;
    } else if (playerCord.x > width) {
      playerCord.x = 0;
    } else if (playerCord.x < 0) {
      playerCord.x = width;
    }
  }
}

class Ghosts {
  int size;
  color c;

  Ghosts(int initialSize, color initialc) {
    size = initialSize;
    c = initialc;
  }

  void drawGhost() {
    fill(c);
    if (c == #0000FF) { //blue
      rect(blueGhostCord.x, blueGhostCord.y, size, size);
    } else if (c == #FFB6C1) { //pink
      rect(pinkGhostCord.x, pinkGhostCord.y, size, size);
    } else if (c == #FF0000) { //red
      rect(redGhostCord.x, redGhostCord.y, size, size);
    } else if (c == #FFA500) { //orange
      rect(orangeGhostCord.x, orangeGhostCord.y, size, size);
    }
  }

  void chase() {
    if (c == #FF0000) { //red -> corner is top left
      //wants to chase pacman directly
    } else if (c == #FFB6C1) { //pink -> corner is top right
      //aims a small distance ahead of pacman
    } else if (c == #0000FF) { //blue -> corner is bottom left
      //targets the reflection of pink position across pinkys target
    } else if (c == #FFA500) { //orange -> corner is bottom right
      //random movement
    }
  }

  void scatter() {
    //all goes go to their corners

    if (c == #FF0000) { //red -> corner is top left
    } else if (c == #FFB6C1) { //pink -> corner is top right
    } else if (c == #0000FF) { //blue -> corner is bottom left
    } else if (c == #FFA500) { //orange -> corner is bottom right
    }
  }

  void frightened() {
    //happens when pacman eats a big dot, all become blue and move randomly
  }
}


void setup() {
  size(400, 400);
  background(255);
  smooth();
}

void draw() {
  pacman.drawPac();
  pacman.move();

  blueGhost.drawGhost();
  redGhost.drawGhost();
  orangeGhost.drawGhost();
  pinkGhost.drawGhost();
}