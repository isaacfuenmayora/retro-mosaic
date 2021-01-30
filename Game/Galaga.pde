//George Rauta
int gameFrameRate = 60;
int displayWidth = 640;
int displayHeight = displayWidth / 4 * 3;
PlayerShip player;


void setup(){
  frameRate(gameFrameRate);
  size(displayWidth, displayHeight);
  player = new PlayerShip(displayWidth / 2, displayHeight * 7 / 8, displayWidth / 64, 1, 5);
}

void draw(){
  background(50, 50, 50);
  player.drawModel(0, 255, 0);
  player.movePlayer();
  //Figure out how to keep track of all projectiles and if they hit something
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

public class Ship extends Hitbox{
  protected int life;
  
  public Ship(int posX, int posY, int hitboxRadius, int whoseHitbox, int life){
    super(posX, posY, hitboxRadius, whoseHitbox);
    this.life = life;
  }
  
  void drawModel(int R, int B, int G){    
    rectMode(RADIUS);
    fill(R, B, G);
    square(posX, posY, hitboxRadius);
    //Delete later
    super.debug_showHitbox();
  }
  
  void fireProjectile(){
    
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
}

public class EnemyShip extends Ship{
  public EnemyShip(int posX, int posY, int hitboxRadius, int whoseHitbox, int life){
    super(posX, posY, hitboxRadius, whoseHitbox, life);
  }
  
  void moveEnemy(){
    //Move somehow idk
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
