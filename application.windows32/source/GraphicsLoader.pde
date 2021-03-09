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

  void drawImage(int id, int x, int y, float scale) {
    if (id < 9000 && id != 4000) {
      if (id != 3) {
        image(pics[id], x * scale, y * scale, pics[id].width*2, pics[id].height*2);  //Cursor Overlap
      } else {
        image(pics[id], x * scale - 2, y * scale - 2, pics[id].width*2, pics[id].height*2);
      }
    }
  }
}
