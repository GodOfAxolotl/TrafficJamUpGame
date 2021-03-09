class LevelFactory {

  LevelFactory() {
  }

  Level getLevel(int id) {

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
