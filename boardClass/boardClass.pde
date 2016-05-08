Board board = new Board();
ArrayList<Dot> dots = new ArrayList<Dot>();
void setup() {
  size(442, 456);
  background(0);
  smooth();
  ellipseMode(CENTER);
  int map[][] = board.map;
  for (int i=0; i<map.length; i++) {
    for (int j=0; j<map[i].length; j++) {
      switch(map[i][j]) {
        case 2:
          dots.add(new Dot(new PVector(board.xSize*j+board.xSize/2, board.ySize*i+board.ySize/2), 2));
          break;
        case 3:
          dots.add(new Dot(new PVector(board.xSize*j+board.xSize/2, board.ySize*i+board.ySize/2), 10));
          break;
      }
    }
  }
}
void draw() {
  board.draw();
      for (int i=0; i<dots.size(); i++) {
      Dot curDot = dots.get(i);
      curDot.draw();
    }
}

//Class contains all static elements for the game
//as well as functions to detect collisions
class Board {
  
  int[][] map;
  color wallColor = color(52,93,169);
  int xSize;
  int ySize;
  int score = 0;
  Board() {
      //0: empty
      //1: wall
      //2: dot
      //3: big dot
      map = new int[][] {
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0},
      {0,1,2,2,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,1,0},
      {0,1,3,1,1,2,1,1,1,2,1,2,1,1,1,2,1,1,3,1,0},
      {0,1,2,2,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,1,0},
      {0,1,2,1,1,2,1,2,1,1,1,1,1,2,1,2,1,1,2,1,0},
      {0,1,2,2,2,2,1,2,2,2,1,2,2,2,1,2,2,2,2,1,0},
      {0,1,1,1,1,2,1,1,1,0,1,0,1,1,1,2,1,1,1,1,0},
      {0,0,0,0,1,2,1,0,0,0,0,0,0,0,1,2,1,0,0,0,0},
      {1,1,1,1,1,2,1,0,1,1,1,1,1,0,1,2,1,1,1,1,1},
      {0,0,0,0,0,2,0,0,1,0,0,0,1,0,0,2,0,0,0,0,0},
      {1,1,1,1,1,2,1,0,1,1,1,1,1,0,1,2,1,1,1,1,1},
      {0,0,0,0,1,2,1,0,0,0,0,0,0,0,1,2,1,0,0,0,0},
      {0,1,1,1,1,2,1,0,1,1,1,1,1,0,1,2,1,1,1,1,0},
      {0,1,2,2,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,1,0},
      {0,1,2,1,1,2,1,1,1,2,1,2,1,1,1,2,1,1,2,1,0},
      {0,1,3,2,1,2,2,2,2,2,2,2,2,2,2,2,1,2,3,1,0},
      {0,1,1,2,1,2,1,2,1,1,1,1,1,2,1,2,1,2,1,1,0},
      {0,1,2,2,2,2,1,2,2,2,1,2,2,2,1,2,2,2,2,1,0},
      {0,1,2,1,1,1,1,1,1,2,1,2,1,1,1,1,1,1,2,1,0},
      {0,1,2,2,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,1,0},
      {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0},
      };
      //Inspiration
      //http://ccl.northwestern.edu/netlogo/models/models/Sample%20Models/Games/Pac-Man.png
      
      ySize = 456/map.length;   //What the size is of each grid point
      xSize = 442/map[0].length; //based on window and array size

  }
  void draw() {
    for (int i=0; i<map.length; i++) {
      for (int j=0; j<map[i].length; j++) {
        if (map[i][j] == 1) {
          fill(wallColor);
          stroke(wallColor);
          rect(xSize*j, ySize*i, xSize, ySize);
        }
      }
    }
    textSize(15);
    fill(255);
    text("Score: " + str(score),20,15);
  }
  boolean isColliding(PVector cord) { //Need to be fed the furthest pixel in the direction of travel
    if (get((int)cord.x, (int)cord.y)==wallColor) { //Check color of pixel given
      return(true);
    } else {
      return(false);
    }
  }
}

class Dot {
  PVector cord;
  int radius;
  Dot(PVector cord_, int radius_){
    cord = cord_;
    radius = radius_;
  }
  void draw() {
    fill(255);
    stroke(255);
    ellipse(cord.x, cord.y, radius, radius);
  }
  int collisionCheck(PVector player) {
    if (cord.dist(player)<radius) {
      switch(radius) {
        case 5:
          board.score+=10;
          break;
        case 10:
          board.score+=50;
          break;
      }
      return(radius); //So we can decide whether to turn ghosts blue
    } else {
      return(0);
    }
  }
}