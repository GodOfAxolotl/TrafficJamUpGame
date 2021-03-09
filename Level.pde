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
    arrayCopy(c, 0, cars, 0, c.length);

    grid = new Grid(x, y, width / 4, height / 4, gl, c);


    update(0, 0);
  }

///////////////////////////////////////////////////////////////////////

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
              
            }    //Setzt die ID auf die vom Auto bedeckten Punkte. Die ID wird nicht gezeichnet, jedoch gemessen, daher ein Graphisches und ein Kartisches Grid
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
  }  //verweis auf grid

  ///////////////////////////////////////////////////////////////////////

  int posOfTopCar(int xPos, int yPos) {
    int identity = grid.getPoint(xPos, yPos); // Speichere dir die ID des Tiles für später
    for (int i = 0; i < realCarsLength; i++) {
      if (cars[i].id == identity) { //Stimmt die Ausgewiesene ID in der Tabelle mit der ID eines Autos überein?
        return i;
      }
    } 
    return -1; // Fehler-Ticket -1: Es wurde nichts gefunden...
  } //Wenn implimentiert, muss einen Failsafe für das -1 Ticket enthalten 

  ///////////////////////////////////////////////////////////////////////

  void getCar(Car car) {
    for (int i = 0; i < realCarsLength; i++) {
      if (cars[i] == null) {
        cars[i] = car;
        return;
      }
    }
  }      //was? Was macht das? Ich lass es hier stehen, keiner packt diese Methode an

  ///////////////////////////////////////////////////////////////////////
  //Steuerungsmethoden:

  void moveTo(int x1, int y1, int x2, int y2) {
    grid.moveFromTo(x1, y1, x2, y2);
  }


  void gridInput(int x, int y, int id) {
    grid.setPoint(x, y, id);
  }

  String getID() {
    return id;
  }

  int getGridPoint(int x, int y) {
    return grid.getPoint(x, y);
  }
}
