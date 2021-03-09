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

  void update() {

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

  void display() {
    levels[activeLevel].display();
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  void newLevel() {
    activeLevel += 1;
    if(levels.length <= activeLevel) {
      noLoop();
      text("You did the thing", 100, 100);
    }
    cursorXPos = 0;
    cursorYPos = 0;
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  void setInput(final int k, final int kc, final boolean act) {    // Give this method a Key and a Keycode and a state and boolean statement and it will registrate the fitting instructions

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

  boolean checkSurroundings(boolean north) {
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

  void settle() {
    preCursorXPos = cursorXPos;
    preCursorYPos = cursorYPos;
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  void savePreId(int x, int y) {
    cursorPreId = levels[activeLevel].grid.getPoint(x, y);
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  void getImpuls(boolean impuls) {
    this.puls = impuls;
  }
}
