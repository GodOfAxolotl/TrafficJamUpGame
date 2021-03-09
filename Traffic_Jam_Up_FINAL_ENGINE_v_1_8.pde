GameSession game;

int w = 600;
int h = 600;
int fps = 30;

String icon = "Items/Goal.png";


void settings() {
  size(displayWidth, displayHeight - displayHeight / 20, P2D);
  //fullScreen(P2D); //consider removing P2D when graphics seem blurred
  PJOGL.setIcon(icon);
}

void setup() {
  frameRate(fps);
  surface.setTitle("Traffic Jam Up!");
  game = new GameSession();
  w = width / 2;
  h = height / 2;
  background(45);
}



void draw() {
  background(65);
  fill(255);
  text(frameRate + " FPS", 10, 20);
  text(game.levels[game.activeLevel].id, 10, 40);
  game.update();
  game.display();
}



void keyPressed() {
  game.setInput(key, keyCode, true);
  game.getImpuls(true);
}


void keyReleased() {
  game.setInput(key, keyCode, false);
  game.getImpuls(false);
}
