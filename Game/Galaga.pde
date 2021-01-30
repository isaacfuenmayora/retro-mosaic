int gameFrameRate = 60;
int displayWidth = 640;
int displayHeight = displayWidth / 4 * 3;

PlayerShip player;

int enemyShipLimit = 1;
ArrayList<EnemyShip> enemyShips;

int playerProjectilesLimit = 5;
ArrayList<Projectile> playerProjectiles;

int enemyProjectilesLimit = 5;
ArrayList<Projectile> enemyProjectiles;



void setup(){
  frameRate(gameFrameRate);
  size(displayWidth, displayHeight);
  player = new PlayerShip(displayWidth / 2, displayHeight * 7 / 8, displayWidth / 64, 1, 5);
  enemyShips = new ArrayList<EnemyShip>();
  playerProjectiles = new ArrayList<Projectile>();
  enemyProjectiles = new ArrayList<Projectile>();
}

void draw(){
  background(50, 50, 50);
  player.drawModel(0, 255, 0);
  createNewEnemies();
  for(EnemyShip es : enemyShips){
    es.drawModel();
  }
  player.movePlayer();
  playerFireTurn();
}

void createNewEnemies(){
  if(enemyShips.size() < enemyShipLimit){
    enemyShips.add(new EnemyShip(displayWidth / 2, displayHeight / 8, displayWidth / 64, 3, 1, 255, 0, 0));
  }
}
  
void playerFireTurn(){
  println(playerProjectiles.size());
  if(player.isFiring() && (playerProjectiles.size() < playerProjectilesLimit)){
    playerProjectiles.add(new Projectile(player.getPosX(), player.getPosY(), displayWidth / 128, 2));
    println("Firing");
  } 
}
  
void playerHitTurn(){
  //Check if player projectiles hit enemies
}

void enemyFireTurn(){
  // Allow enemies to fire
}

void enemyHitTurn(){
  //Check if enemy projectiles hit player
}

public class EnemyShip extends Ship{
  int R;
  int B;
  int G;
  
  public EnemyShip(int posX, int posY, int hitboxRadius, int whoseHitbox, int life, int R, int B, int G){
    super(posX, posY, hitboxRadius, whoseHitbox, life);
    this.R = R;
    this.B = B;
    this.G = G;
  }
  
  void moveEnemy(){
    //Move somehow idk
  }
  
  void drawModel(){
    rectMode(RADIUS);
    fill(R, B, G);
    square(posX, posY, hitboxRadius);
    //Delete later
    super.debug_showHitbox();
  }
}

public class Hitbox{
  protected int posX;
  protected int posY;
  protected int hitboxRadius;
  protected int whoseHitbox; //1 is Player, 2 is Player Projectile, 3 is Enemy, 4 is Enemy Projectile
  
  public Hitbox(int posX, int posY, int hitboxRadius, int whoseHitbox){
    this.posX = posX;
    this.posY = posY;
    this.hitboxRadius = hitboxRadius;
    this.whoseHitbox = whoseHitbox;
  }
  
  int getPosX(){
    return posX;
  }
  
  int getPosY(){
    return posY;
  }
  
  int getHitboxRadius(){
    return hitboxRadius;
  }
  
  boolean isHit(Hitbox h){
    return dist(this.posX, this.posY, h.getPosX(), h.getPosY()) <= this.hitboxRadius + h.getHitboxRadius();
  }
  
  void debug_showHitbox(){
    ellipseMode(RADIUS); 
    fill(255, 255, 255);
    circle(this.posX, this.posY, this.hitboxRadius);
  }
}

public class PlayerShip extends Ship{
    
  public PlayerShip(int posX, int posY, int hitboxRadius, int whoseHitbox, int life){
    super(posX, posY, hitboxRadius, whoseHitbox, life);
  }
  
  void movePlayer(){
    if(keyPressed && key == 'a' && !(posX <= hitboxRadius)){
      posX += -2;
    }
    
    if(keyPressed && key == 'd' && !(posX >= displayWidth - hitboxRadius)){
      posX += 2;
    }
  }
  
  //Prevent firing multiple times when pressed, on click only
  boolean isFiring(){
    return (keyPressed && key == ' ');
  }
}

public class Projectile extends Hitbox{
  
  public Projectile(int posX, int posY, int hitboxRadius, int whoseHitbox){
    super(posX, posY, hitboxRadius, whoseHitbox);
  }
  
  void moveProjectile(){
    if(whoseHitbox == 2){
      //Move up
    }
    else if(whoseHitbox == 4){
      //Move down
    }
  }
}

public class Ship extends Hitbox{
  protected int life;
  
  public Ship(int posX, int posY, int hitboxRadius, int whoseHitbox, int life){
    super(posX, posY, hitboxRadius, whoseHitbox);
    this.life = life;
  }
  
  int getLife(){
    return life;
  }
  
  void setLife(int damage){
    life = life - damage;
  }
  
  void drawModel(int R, int B, int G){    
    rectMode(RADIUS);
    fill(R, B, G);
    square(posX, posY, hitboxRadius);
    //Delete later
    super.debug_showHitbox();
  }
}
