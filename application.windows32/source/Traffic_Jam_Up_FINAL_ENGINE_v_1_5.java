import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Traffic_Jam_Up_FINAL_ENGINE_v_1_5 extends PApplet {

GameSession game;

int w = 600;
int h = 600;

String icon = "Items/Goal.png";


public void settings() {
  //size(1200, 800, P2D);
  fullScreen(P2D); //consider removing P2D when graphics seem blurred
  PJOGL.setIcon(icon);
}

public void setup() {
  frameRate(30);
  surface.setTitle("Traffic Jam Up!");
  game = new GameSession();
  w = width / 2;
  h = height / 2;
  background(45);
}




public void draw() {
  background(45);
  fill(255);
  text(frameRate + " FPS", 10, 20);
  text("Level: " + game.activeLevel, 10, 40);
  game.update();
  game.display();
}



public void keyPressed() {
  game.setInput(key, keyCode, true);
  game.getImpuls(true);
}


public void keyReleased() {
  game.setInput(key, keyCode, false);
  game.getImpuls(false);
}
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

  public void update() {
  }

  public void move(int dir) {
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
class CarFactory {

  CarFactory() {
  }

  public Car getCar(int id, int x, int y, Direction dir) {

    Car c;

    switch(id) {
    case 4000:
      c = new Car(4000, x, y, 2, 1, Direction.SOUTH, 2);
      return c;
    default:
      c = new Car(4000, x, y, 2, 1, Direction.SOUTH, 2);
      return c;
    }
  }
}


//ANYWHERE HERE IS A NULL POINTER I WANNA CRY  

class GameSession {
  //madness
  LevelFactory fac = new LevelFactory();
  Level[] levels = new Level[10];



  int cursorXPos = 0;
  int cursorYPos = 0;  
  int cursorPreId = 0;

  int preCursorXPos;
  int preCursorYPos;

  int activeLevel = 0;

  boolean nor, eas, sou, wes, cent;
  boolean nor1, eas1, sou1, wes1, cent1;

  boolean puls = false;

  boolean onCar = false;



  GameSession() {
    levels[0] = fac.getLevel(0);
    levels[1] = fac.getLevel(1);
    levels[2] = fac.getLevel(2);
    levels[3] = fac.getLevel(3);
    levels[4] = fac.getLevel(4);
    levels[5] = fac.getLevel(5);
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////

  public void update() {

    onCar = true;
    levels[activeLevel].update(cursorXPos, cursorYPos);
    Direction d = Direction.UNMOVABLE;
    boolean isCar;

    if (keyPressed && ( nor || nor1 ||eas || eas1 || sou || sou1 || wes || wes1 ) && frameCount % 4 == 0) {

      int car = -1;

      if (nor || nor1) {
        car = levels[activeLevel].posOfTopCar(cursorXPos, cursorYPos);
      } else if (eas ||eas1) {
        car = levels[activeLevel].posOfTopCar(cursorXPos, cursorYPos);
      } else if (sou || sou1) {
        car = levels[activeLevel].posOfTopCar(cursorXPos, cursorYPos);
      } else if (wes || wes1) {
        car = levels[activeLevel].posOfTopCar(cursorXPos, cursorYPos);
      }            //Do not touch, will we refactored final, could be used later

      if ( car != -1) {
        isCar = true;
      } else {
        isCar = false;
      }

      if (isCar) {
        d = levels[activeLevel].cars[car].dir;
      }

      switch(d) {
      case NORTH:
        if (nor || nor1) {
          settle();
          cursorYPos -= 1;
          if (isCar && levels[activeLevel].cars[car].yPos - 1 > 0 && nor1) {
            levels[activeLevel].cars[car].move(0);
          }
        } else if (eas || eas1) {
          settle();
          cursorXPos += 1;
          //   if (isCar && levels[activeLevel].cars[car].xPos + 1 < levels[activeLevel].grid.xLen && eas1) {
          //     levels[activeLevel].cars[car].move(1);
          //   }
        } else if (sou || sou1) {
          settle();
          cursorYPos += 1;
          if (isCar && levels[activeLevel].cars[car].yPos + 1 < levels[activeLevel].grid.yLen && sou1) {
            levels[activeLevel].cars[car].move(2);
          }
        } else if (wes || wes1) {
          settle();
          cursorXPos -= 1;
          //      if (isCar && levels[activeLevel].cars[car].xPos - 0 > 0 && wes1) {
          //      levels[activeLevel].cars[car].move(3);
          //     }
        }

        break;


      case EAST:
        if (nor || nor1) {
          settle();
          cursorYPos -= 1;
          //  if (isCar && levels[activeLevel].cars[car].yPos - 0 > 0 && nor1) {
          //     levels[activeLevel].cars[car].move(0);
          //   }
        } else if (eas || eas1) {
          settle();
          cursorXPos += 1;
          if (isCar && levels[activeLevel].cars[car].xPos + levels[activeLevel].cars[car].xLen < levels[activeLevel].grid.xLen && eas1 && levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos) == 0) {
            levels[activeLevel].cars[car].move(1);
          }//TOFIX
        } else if (sou || sou1) {
          settle();
          cursorYPos += 1;
          //    if (isCar && levels[activeLevel].cars[car].yPos + 1 < levels[activeLevel].grid.yLen && sou1) {
          //      levels[activeLevel].cars[car].move(2);
          //   }
        } else if (wes || wes1) {
          settle();
          cursorXPos -= 1;
          if (isCar && levels[activeLevel].cars[car].xPos > 0 && wes1 && levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos) == 0) {
            levels[activeLevel].cars[car].move(3);
          }
        }

        break;


      case SOUTH:
        if (nor || nor1) {
          settle();
          cursorYPos -= 1;
          if (isCar && levels[activeLevel].cars[car].yPos > 0 && nor1 && levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos) == 0) {
            levels[activeLevel].cars[car].move(0);
          }
        } else if (eas || eas1) {
          settle();
          cursorXPos += 1;
          // if (isCar && levels[activeLevel].cars[car].xPos + 1 < levels[activeLevel].grid.xLen && eas1) {
          //   levels[activeLevel].cars[car].move(1);
          // }
        } else if (sou || sou1) {
          settle();
          cursorYPos += 1;
          if (isCar && levels[activeLevel].cars[car].yPos + levels[activeLevel].cars[car].yLen  < levels[activeLevel].grid.yLen && sou1 && levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos) == 0) {
            levels[activeLevel].cars[car].move(2);
          }//TOFIX
        } else if (wes || wes1) {
          settle();
          cursorXPos -= 1;
          //  if (isCar && levels[activeLevel].cars[car].xPos - 0 > 0 && wes1) {
          //   levels[activeLevel].cars[car].move(3);
          //  }
        }

        break;


      case WEST:
        if (nor || nor1) {
          settle();
          cursorYPos -= 1;
          //if (isCar && levels[activeLevel].cars[car].yPos - 0 > 0 && nor1) {
          //levels[activeLevel].cars[car].move(0);
          //}
        } else if (eas || eas1) {
          settle();
          cursorXPos += 1;
          if (isCar && levels[activeLevel].cars[car].xPos + 1 < levels[activeLevel].grid.xLen && eas1) {
            levels[activeLevel].cars[car].move(1);
          }
        } else if (sou || sou1) {
          settle();
          cursorYPos += 1;
          //if (isCar && levels[activeLevel].cars[car].yPos + 1 < levels[activeLevel].grid.yLen && sou1) {
          //  levels[activeLevel].cars[car].move(2);
          // }
        } else if (wes || wes1) {
          settle();
          cursorXPos -= 1;
          if (isCar && levels[activeLevel].cars[car].xPos - 1 > 0 && wes1) {
            levels[activeLevel].cars[car].move(3);
          }
        }
        break;


      case CENTERED:
        if (nor || nor1) {
          settle();
          cursorYPos -= 1;
          if (isCar && levels[activeLevel].cars[car].yPos - 0 > 0 && nor1 && levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos) == 0) {
            levels[activeLevel].cars[car].move(0);
          }
        } else if (eas || eas1) {
          settle();
          cursorXPos += 1;
          if (isCar && levels[activeLevel].cars[car].xPos + 1 < levels[activeLevel].grid.xLen && eas1 && levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos) == 0) {
            levels[activeLevel].cars[car].move(1);
          }
        } else if (sou || sou1) {
          settle();
          cursorYPos += 1;
          if (isCar && levels[activeLevel].cars[car].yPos + 1 < levels[activeLevel].grid.yLen && sou1 && levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos) == 0) {
            levels[activeLevel].cars[car].move(2);
          }
        } else if (wes || wes1) {
          settle();
          cursorXPos -= 1;
          if (isCar && levels[activeLevel].cars[car].xPos - 0 > 0 && wes1 && levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos) == 0) {
            levels[activeLevel].cars[car].move(3);
          }
        }
        break;
      default: 
        if (nor || nor1) {
          settle();
          cursorYPos -= 1;
        } else if (eas || eas1) {
          settle();
          cursorXPos += 1;
        } else if (sou || sou1) {
          settle();
          cursorYPos += 1;
        } else if (wes || wes1) {
          settle();
          cursorXPos -= 1;
        }
      }

      try {
        levels[activeLevel].gridInput(preCursorXPos, preCursorYPos, cursorPreId);
        savePreId(cursorXPos, cursorYPos);
        if (cursorPreId != 3 && cursorPreId != 0 ) {
          onCar = true;
        } else {
          onCar = false;
        }
        levels[activeLevel].gridInput(cursorXPos, cursorYPos, 3);
      }
      catch(Exception e) {
        if (nor || nor1) {
          settle();
          cursorYPos += 1;
          savePreId(cursorXPos, cursorYPos);
        } else if (eas || eas1) {
          settle();
          cursorXPos -= 1;
          savePreId(cursorXPos, cursorYPos);
        } else if (sou || sou1) {
          settle();
          cursorYPos -= 1;
          savePreId(cursorXPos, cursorYPos);
        } else if (wes || wes1) {
          settle();
          cursorXPos += 1;
          savePreId(cursorXPos, cursorYPos);
        }
        levels[activeLevel].gridInput(cursorXPos, cursorYPos, 3);
      }
    }

    //levels[activeLevel].grid.grid[cursorXPos][cursorYPos] = 3;

    //levels[activeLevel].grid.graphic.drawImage(3,cursorXPos, cursorYPos, levels[activeLevel].grid.scale);

    if (levels[activeLevel].grid.checkForWin(levels[activeLevel].cars[0])) {
      newLevel();
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////

  public void display() {
    levels[activeLevel].display();
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  public void newLevel() {
    activeLevel += 1;
    if(levels.length <= activeLevel) {
      noLoop();
      text("You did the thing", 100, 100);
    }
    cursorXPos = 0;
    cursorYPos = 0;
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  public void setInput(final int k, final int kc, final boolean act) {    // Give this method a Key and a Keycode and a state and boolean statement and it will registrate the fitting instructions

    switch(k) {
    case 'w':
      nor = act;
      break;
    case 'W':
      nor = act;
      break;
    case 'd':
      eas = act;
      break;
    case 'D':
      eas = act;
      break;
    case 's':
      sou = act;
      break;
    case 'S':
      sou = act;
      break;
    case 'a':
      wes = act;
      break;
    case 'A':
      wes = act;
      break;
    }
    switch(kc) {
    case UP:
      nor1 = act;
      break;
    case RIGHT:
      eas1 = act;
      break;
    case DOWN:
      sou1 = act;
      break;
    case LEFT: 
      wes1 = act;
      break;
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  public boolean checkSurroundings(boolean north) {
    if (north) {
      if (levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos + 2) == 0 || // plus 2, da secondary
        levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos - 1) == 0 ) 
      {
        println("false 1");
        return false;
      }
    } else if ( levels[activeLevel].grid.getPoint(cursorXPos - 1, cursorYPos) == 0 ||
      levels[activeLevel].grid.getPoint(cursorXPos + 2, cursorYPos) == 0 )
    {
      println("false 2");
      return false;
    }
    println("false 1");
    return true;
  }      //retutrns false if there is nothing arround

  /////////////////////////////////////////////////////////////////////////////////////////

  public void settle() {
    preCursorXPos = cursorXPos;
    preCursorYPos = cursorYPos;
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  public void savePreId(int x, int y) {
    cursorPreId = levels[activeLevel].grid.getPoint(x, y);
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  public void getImpuls(boolean impuls) {
    this.puls = impuls;
  }
}

class GraphicsLoader {

  String[] paths = {
    "Background/empty.png", //0, Empty
    "Test/TestGraphic.png", //1, test
    "Test/Test2by2.png", //2, test
    "Cursor/Cursor.png", //3, Cursor
    "Items/Goal.png",         //4 Goal
    "Items/TutorPlateMove.png", // 5 Tutorial Move
    "Items/TutorPlateDrag.png",  // 6 Tutorial Drag
    "Test/TestEast.png", // 7
    "Test/TestEastDir.png", // 8
    "Test/TestWestDir.png", // 9
    "Test/ThreeSouth.png", // 10
    "Test/ThreeEast.png", // 11
    "Test/Player.png" // 12
  };
  PImage[] pics;

  GraphicsLoader() {
    pics = new PImage[paths.length];

    for ( int i = 0; i < paths.length; i++) {
      pics[i] = loadImage(paths[i]);
    }
  }

  public void drawImage(int id, int x, int y, float scale) {
    if (id < 9000 && id != 4000) {
      if (id != 3) {
        image(pics[id], x * scale, y * scale, pics[id].width*2, pics[id].height*2);  //Cursor Overlap
      } else {
        image(pics[id], x * scale - 2, y * scale - 2, pics[id].width*2, pics[id].height*2);
      }
    }
  }
}
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
    arraycopy(c, 0, cars, 0, c.length);


    for (int i = 0; i < xLen; i++) {
      for (int j = 0; j < yLen; j++) {
        grid[i][j] = 0;
        graphicGrid[i][j] = 0;
      }
    }
    //grid[cPosX][cPosY] = 3;
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

  public void update() {
    
  }

  ////////////////////////////////////////////////////////////////////////

  public void display() {
    pushMatrix();
    translate(transX, transY);
    
    fill(15, 17, 67, 254);
    rect(0, 0, scaleSize * xLen, scaleSize * yLen);
    
    for (int i = 0; i < grid.length; i++) {
        System.arraycopy(grid[i], 0, graphicGrid[i], 0, grid[i].length);
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

  public boolean checkForWin(Car car) {
    if (car.yPos == goalLine && car.xPos == xLen - car.xLen) {
      return true;
    }
    return false;
  }

  /////////////////////////////////////////////////////////////////

  public void setPoint(int x, int y, int id) {
    grid[x][y] = id;
  }

  //////////////////////////////////////////////////////////////////

  public void moveFromTo(int x1, int y1, int x2, int y2) {
    int temp = grid[x1][y1];
    grid[x1][y1] = grid[x2][y2];
    grid[x2][y2] = temp;
  }

  //////////////////////////////////////////////////////////////////

  public void reset() {
    for (int i = 0; i < xLen; i++) {
      for (int j = 0; j < yLen; j++) {
        grid[i][j] = 0;
      }
    }
  }

  /////////////////////////////////////////////////////////////////

  public void setCursor(int cpx, int cpy) {
    cPosX = cpx;
    cPosY = cpy;
  }

  ////////////////////////////////////////////////////////////////

  public float getScale() {
    return scale;
  }

  public float getTransX() {
    return transX;
  }

  public float getTransY() {
    return transY;
  }

  public int getPoint(int x, int y) {
    try
    {
      return grid[x][y];
    } 
    catch(Exception e)
    {
      return 0;
    }
  }
  
   public int getGPoint(int x, int y) {
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

class Level {

  String id;
  Grid grid;

  Car[] cars;

  int realCarsLength;
  boolean stageDone = false;
  

  Level(String id, int x, int y, int gl, Car[] c) {
    this.id = id;
    cars = new Car[c.length];
    realCarsLength = c.length;
    arraycopy(c, 0, cars, 0, c.length);

    grid = new Grid(x, y, width / 4, height / 4, gl, c);


    update(0, 0);
  }


  public String getID() {
    return id;
  }

  public void update(int cpx, int cpy) {

    grid.reset();
    grid.update();

    for (int i = 0; i < realCarsLength; i++) {
      for (int j = 0; j < cars[i].xLen; j++) {
        for (int k = 0; k < cars[i].yLen; k++) {
          if (j == 0 && k == 0) {
            grid.setPoint(cars[i].xPos, cars[i].yPos, cars[i].id); //setzt den Header
          } else {
            switch(cars[i].dir) {
            case NORTH:
              grid.setPoint(cars[i].xPos + j, cars[i].yPos - k, cars[i].id);
              break;

            case EAST:
              grid.setPoint(cars[i].xPos + j, cars[i].yPos + k, cars[i].id);
              break;

            case SOUTH:
              grid.setPoint(cars[i].xPos + j, cars[i].yPos + k, cars[i].id);
              break;

            case WEST:
              grid.setPoint(cars[i].xPos - j, cars[i].yPos - k, cars[i].id);
              break;

            case CENTERED:

              break;
            }
          }
        }
      }
    }
    grid.setCursor(cpx, cpy);

    if (grid.checkForWin(cars[0])) {
      stageDone = true;
    }
  }

  public void display() {
    grid.display();
  }

 public int posOfTopCar(int xPos, int yPos) {
   
   /*for (int i = 0; i < realCarsLength; i++) {
      if (xPos == cars[i].xPos && yPos == cars[i].yPos ) {
        //println("POSOFTOPCAR GOT A RESULT: " + i);
        return i;
      }
    }
    //println("POSOFTOPCAR GOT NO RESULT");
    return -1;*/
    
    int identity = grid.getPoint(xPos, yPos);
    println("ID: " + identity);
    for (int i = 0; i < realCarsLength; i++) {
      if (cars[i].id == identity) {
        println("Auto: " + i);
        return i;
      }
    } 
    println("nix");
    return -1;
  } 


  public void moveTo(int x1, int y1, int x2, int y2) {
    grid.moveFromTo(x1, y1, x2, y2);
  }


  public void gridInput(int x, int y, int id) {
    grid.setPoint(x, y, id);
  }

  public int getGridPoint(int x, int y) {
    return grid.getPoint(x, y);
  }


  public void getCar(Car car) {
    for (int i = 0; i < realCarsLength; i++) {
      if (cars[i] == null) {
        cars[i] = car;
        return;
      }
    }
    println("Nein");
  }      //was?
}
class LevelFactory {

  LevelFactory() {
  }

  public Level getLevel(int id) {

    Level l;
    Car[] c;

    //Car(int name, int xPos, int yPos, int xlen, int yLen, Direction dir, int graphic) Constructor for refference 
    //USE ONLY SOUTH, EAST and CETERED!

    switch(id) {   
    case -1:
      c = new Car[5];
      c[0] = new Car(9000, 0, 4, 2, 1, Direction.EAST, 12);
      c[1] = new Car(9001, 4, 2, 2, 1, Direction.EAST, 8);
      c[2] = new Car(4001, 5, 5, 1, 1, Direction.CENTERED, 1);
      c[3] = new Car(4001, 2, 7, 2, 1, Direction.EAST, 9);
      c[4] = new Car(4001, 7, 2, 1, 2, Direction.SOUTH, 2);
      l = new Level("DEBUG", 10, 8, 4, c);
      return l;

    case 0:
      c = new Car[3];
      c[0] = new Car(9000, 0, 4, 2, 1, Direction.EAST, 12);
      c[1] = new Car(9001, 4, 6, 1, 1, Direction.UNMOVABLE, 5);
      c[2] = new Car(9002, 6, 6, 1, 1, Direction.UNMOVABLE, 6);
      //c[3] = new Car(9003, 5, 3, 1, 3, Direction.SOUTH, 10);
      //c[4] = new Car(9004, 4, 1, 3, 1, Direction.EAST, 11);
      l = new Level("Tutorial", 10, 8, 4, c);
      l.gridInput(l.grid.yLen, 1, 5);
      return l;

    case 1: 
      c = new Car[4];
      c[0] = new Car(9000, 0, 4, 2, 1, Direction.EAST, 12);
      c[1] = new Car(9001, 5, 3, 1, 3, Direction.SOUTH, 10);
      c[2] = new Car(9002, 2, 6, 1, 1, Direction.UNMOVABLE, 5);
      c[3] = new Car(9003, 7, 6, 1, 1, Direction.UNMOVABLE, 6);
      l = new Level("Level 1", 10, 8, 4, c);
      return l;

    case 2: 
      c = new Car[4];
      c[0] = new Car(4000, 0, 4, 2, 1, Direction.EAST, 12);
      c[1] = new Car(9001, 5, 3, 1, 3, Direction.SOUTH, 10);
      c[2] = new Car(9002, 4, 1, 3, 1, Direction.EAST, 11);
      c[3] = new Car(9003, 5, 7, 1, 1, Direction.UNMOVABLE, 1);
      l = new Level("Level 2", 10, 8, 4, c);
      return l;

    case 3: 
      c = new Car[1];
      c[0] = new Car(4000, 0, 5, 2, 1, Direction.EAST, 12);
      l = new Level("Level 3", 10, 8, 5, c);
      return l;

    case 4: 
      c = new Car[1];
      c[0] = new Car(4000, 0, 4, 2, 1, Direction.EAST, 12);
      l = new Level("Level 4", 10, 8, 4, c);
      return l;

    case 5: 
      c = new Car[1];
      c[0] = new Car(4000, 0, 4, 2, 1, Direction.EAST, 12);
      l = new Level("Level 5", 10, 8, 4, c);
      return l;

    default:
      c = new Car[20];
      l = new Level("TESTSTAGE", 10, 8, 4, c);
      return l;
    }
  }
}


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Traffic_Jam_Up_FINAL_ENGINE_v_1_5" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
