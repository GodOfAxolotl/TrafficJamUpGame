class Car {

  int id;
  int xPos;
  int yPos;      //Header
  int secXPos[] = new int[5];
  int sexYPos[] = new int[5];
  int xLen;
  int yLen;
  Direction dir;
  int graphic;
  boolean isMovable; // TODO

  Car(int name, int xPos, int yPos, int xLen, int yLen, Direction dir, int graphic) {
    this.id = name;
    this.xPos = xPos;
    this.yPos = yPos;
    this.xLen = xLen;
    this.yLen = yLen;
    this.dir = dir;
    this.graphic = graphic;
  }

  void update() {
  }

  void move(int dir) {
    switch(dir) {   // 0 = N , 1 = E, 2 = S, 3 = W
    case 0:
      yPos -= 1;
      break;
    case 1:
      xPos += 1;
      break;
    case 2:
      yPos += 1;
      break;
    case 3:
      xPos -= 1;
      break;
    }
  }
}
