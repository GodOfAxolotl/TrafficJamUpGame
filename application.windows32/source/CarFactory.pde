class CarFactory {

  CarFactory() {
  }

  Car getCar(int id, int x, int y, Direction dir) {

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
