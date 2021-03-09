class GameSession {
  //madness
  LevelFactory fac = new LevelFactory();
  Level[] levels = new Level[40];



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
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////

  void update() {

    onCar = true;
    levels[activeLevel].update(cursorXPos, cursorYPos);
    Direction d = Direction.UNMOVABLE;
    boolean isCar;

    if (keyPressed && ( nor || nor1 ||eas || eas1 || sou || sou1 || wes || wes1 ) && frameCount % 3 == 0) {

      int car = -1;

        car = levels[activeLevel].posOfTopCar(cursorXPos, cursorYPos);
        

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
        } else if (sou || sou1) {
          settle();
          cursorYPos += 1;
          if (isCar && levels[activeLevel].cars[car].yPos + 1 < levels[activeLevel].grid.yLen && sou1) {
            levels[activeLevel].cars[car].move(2);
          }
        } else if (wes || wes1) {
          settle();
          cursorXPos -= 1;
        }

        break;


      case EAST:
        if (nor || nor1) {
          settle();
          cursorYPos -= 1;
        } else if (eas || eas1) {
          settle();
          cursorXPos += 1;
          if (isCar && levels[activeLevel].cars[car].xPos + levels[activeLevel].cars[car].xLen < levels[activeLevel].grid.xLen && eas1 && levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos) == 0) {
            levels[activeLevel].cars[car].move(1);
          }//TOFIX
        } else if (sou || sou1) {
          settle();
          cursorYPos += 1;
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
        } else if (sou || sou1) {
          settle();
          cursorYPos += 1;
          if (isCar && levels[activeLevel].cars[car].yPos + levels[activeLevel].cars[car].yLen  < levels[activeLevel].grid.yLen && sou1 && levels[activeLevel].grid.getPoint(cursorXPos, cursorYPos) == 0) {
            levels[activeLevel].cars[car].move(2);
          }//TOFIX
        } else if (wes || wes1) {
          settle();
          cursorXPos -= 1;
        }

        break;


      case WEST:
        if (nor || nor1) {
          settle();
          cursorYPos -= 1;
        } else if (eas || eas1) {
          settle();
          cursorXPos += 1;
          if (isCar && levels[activeLevel].cars[car].xPos + 1 < levels[activeLevel].grid.xLen && eas1) {
            levels[activeLevel].cars[car].move(1);
          }
        } else if (sou || sou1) {
          settle();
          cursorYPos += 1;
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
      }    //default doesnt move the car

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
        levels[activeLevel].gridInput(cursorXPos, cursorYPos, 3);    //Set the cursor
      }
    }

    if (levels[activeLevel].grid.checkForWin(levels[activeLevel].cars[0])) {
      newLevel();
    } //Done? Great, tick the level up!
  }

  /////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////

  void display() {
    try 
    {
      levels[activeLevel].display();
    } 
    catch (Exception e) {
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  void newLevel() {
    activeLevel += 1;
    
    int temp = activeLevel / levels.length;
    temp = floor(temp);
    levels[activeLevel - temp * levels.length] = fac.getLevel(activeLevel); //Errechnet einen Wert zur Umrechnung des active Levels um das Array nicht zu überfüllen

    if (activeLevel >= fac.levelCount) {
      activeLevel = 0;
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
