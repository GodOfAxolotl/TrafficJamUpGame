class CarFactory {

  CarFactory() {
  }

  Car getCar(int id, int ident, int x, int y) {

    Car c;

    switch(id) {
      
    case 4000:
      c = new Car(4000, x, y, 2, 1, Direction.SOUTH, 2);
      return c;

    case 4010: // Player
      c = new Car(ident, 0, y, 2, 1, Direction.EAST, 12);
      return c;


    default:
      c = new Car(ident, x, y, 2, 1, Direction.SOUTH, 2);
      return c;
    }
  }
}


//ANYWHERE HERE IS A NULL POINTER I WANNA CRY  
//TODO: Implement this, or don't. Whatever fits most...
