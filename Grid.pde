class Grid {

  GraphicsLoader graphic;

  CarFactory cf;

  int[][] grid;
  int[][] graphicGrid;
  float scale;
  int scaleSize = 0;
  float sizeOffset = -1;
  float posOffset = 0;
  int xLen;
  int yLen;
  float transX;
  float transY;

  int cPosX = 0;
  int cPosY = 0;
  Car cars[];

  int goalLine;

  Grid(int xLen, int yLen, float tx, float ty, int goalLine, Car[] c) {

    grid = new int[xLen][yLen];
    graphicGrid = new int[xLen][yLen];
    graphic = new GraphicsLoader();

    cars = new Car[c.length];
    arrayCopy(c, 0, cars, 0, c.length);


    for (int i = 0; i < xLen; i++) {
      for (int j = 0; j < yLen; j++) {
        grid[i][j] = 0;
        graphicGrid[i][j] = 0;
      }
    }
    this.goalLine = goalLine;
    scale = 64;
    this.xLen = xLen;
    this.yLen = yLen;
    posOffset = 1;
    scaleSize = (int)scale;
    transX = tx;
    transY = ty;
  }

  ////////////////////////////////////////////////////////////////////////

  void update() {
    
  }

  ////////////////////////////////////////////////////////////////////////

  void display() {
    pushMatrix();
    translate(transX, transY);
    
    fill(15, 17, 67, 254);
    rect(0, 0, scaleSize * xLen, scaleSize * yLen);
    
    for (int i = 0; i < grid.length; i++) {
        arrayCopy(grid[i], 0, graphicGrid[i], 0, grid[i].length);
    }
    
    for(int i = 0; i < cars.length; i++) {
     graphicGrid[cars[i].xPos][cars[i].yPos] = cars[i].graphic; 
    }
    
    for (int i = 0; i < xLen; i++) {
      for (int j = 0; j < yLen; j++) {
        graphic.drawImage(graphicGrid[i][j], i, j, scale);
        if (grid[i][j] == 3) {
          cPosX = i;
          cPosY = j;
        }
      }
    }
    graphic.drawImage(grid[cPosX][cPosY], cPosX, cPosY, scale);
    graphic.drawImage(4, xLen, goalLine, scale);
    graphic.drawImage(3, cPosX, cPosY, scale);

    popMatrix();
  }

  //////////////////////////////////////////////////////////////////

  boolean checkForWin(Car car) {
    if (car.yPos == goalLine && car.xPos == xLen - car.xLen) {
      return true;
    }
    return false;
  }

  /////////////////////////////////////////////////////////////////

  void setPoint(int x, int y, int id) {
    grid[x][y] = id;
  }

  //////////////////////////////////////////////////////////////////

  void moveFromTo(int x1, int y1, int x2, int y2) {
    int temp = grid[x1][y1];
    grid[x1][y1] = grid[x2][y2];
    grid[x2][y2] = temp;
  }

  //////////////////////////////////////////////////////////////////

  void reset() {
    for (int i = 0; i < xLen; i++) {
      for (int j = 0; j < yLen; j++) {
        grid[i][j] = 0;
      }
    }
  }

  /////////////////////////////////////////////////////////////////

  void setCursor(int cpx, int cpy) {
    cPosX = cpx;
    cPosY = cpy;
  }

  ////////////////////////////////////////////////////////////////

  float getScale() {
    return scale;
  }

  float getTransX() {
    return transX;
  }

  float getTransY() {
    return transY;
  }

  int getPoint(int x, int y) {
    try
    {
      return grid[x][y];
    } 
    catch(Exception e)
    {
      return 0;
    }
  }
  
   int getGPoint(int x, int y) {
    try
    {
      return grid[x][y];
    } 
    catch(Exception e)
    {
      return 0;
    }
  }
}
