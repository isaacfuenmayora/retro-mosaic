<<<<<<< Updated upstream
void setup(){
  
}

void draw(){

=======
final static byte north=1, west=4, south=2, east=8, space=16, map=32, pause=64;
final static byte wall=3, empty=5;
SnakeGrid snak;
byte numApples = 5, appleDepth = 1;

GameManager game = new GameManager();

void setup(){
  
  ellipseMode(RADIUS);
  frameRate(60);
  size(700,700);
  
  
  snak = new SnakeGrid(21,21,numApples,appleDepth);
  
  //Starting x pos, y pos, ship radius, player = 1, life, R, G, B
  playerG = new PlayerShip(width / 2, height * 7 / 8, width / 48, 1, 5, 0, 255, 0);
  enemyShips = new ArrayList<EnemyShip>();
  playerProjectiles = new ArrayList<Projectile>();
  enemyProjectiles = new ArrayList<Projectile>();
  generateStars();
  
  PlayerBarY = height/2 - 50;
  ComputerBarY = height/2 - 50;
  pongBallX = width/2;
  pongBallY = height/2;
  playerCounter = new Counter((int)(width*0.35)-10, height/2 - 10);
  computerCounter = new Counter((int)(width*0.65)-10, height/2 - 10);
  
}

void draw(){
  
  background(51);
  
  game.playScene();
  previousInput = input;
}

void mouseClicked(){
  game.currentSceneId++;
  if(game.currentSceneId==4){
    game.currentSceneId=1;
  }
>>>>>>> Stashed changes
}
