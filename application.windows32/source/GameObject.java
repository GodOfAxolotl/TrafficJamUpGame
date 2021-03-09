abstract class GameObject {
  
   int xPos;
   int yPos;
   int len;
   Direction dir;
   
   void GameObject(int xPos, int yPos, int len, Direction dir) {
     this.xPos = xPos;
     this.yPos = yPos;
     this.len = len;
     this.dir = dir;
   }
   
   abstract void display();
   
   abstract void update();
}
