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


  String getID() {
    return id;
  }

  void update(int cpx, int cpy) {

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

  void display() {
    grid.display();
  }

 int posOfTopCar(int xPos, int yPos) {
   
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


  void moveTo(int x1, int y1, int x2, int y2) {
    grid.moveFromTo(x1, y1, x2, y2);
  }


  void gridInput(int x, int y, int id) {
    grid.setPoint(x, y, id);
  }

  int getGridPoint(int x, int y) {
    return grid.getPoint(x, y);
  }


  void getCar(Car car) {
    for (int i = 0; i < realCarsLength; i++) {
      if (cars[i] == null) {
        cars[i] = car;
        return;
      }
    }
    println("Nein");
  }      //was?
}
