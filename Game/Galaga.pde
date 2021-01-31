float[] starMapX;
float[] starMapY;
int[] starMapColor;
float[] starMapSize;
int stars = 50;

PlayerShip playerG;
int scoreGalaga = 0;
int enemyShipLimit = 4;
ArrayList<EnemyShip> enemyShips;

int playerProjectilesLimit = 5;
ArrayList<Projectile> playerProjectiles;

int enemyProjectilesLimit = 6;
ArrayList<Projectile> enemyProjectiles;

int projectileSize = 5;


void drawEnemies(){
    
    fill(255);
    PFont f = createFont("Arial", 16, true);
    textFont(f,36);
    text(scoreGalaga, 20, 50);
    
    for(EnemyShip es : enemyShips){
    es.drawModel();
    es.incrementCounter();
  }
  for(Projectile p : playerProjectiles){
    p.drawModel();
  }
  for(Projectile p : enemyProjectiles){
      p.drawModel();
    }
}

void moveEnemies(){
    for(int i = 0; i < enemyShips.size(); i++){
    enemyShips.get(i).moveEnemy();
    if(enemyShips.get(i).isOffMap()){
      enemyShips.remove(i);
      i--;
    }
  }
  for(Projectile p : playerProjectiles){
    p.moveProjectile();
  }
  for(Projectile p : enemyProjectiles){
      p.moveProjectile();
    }
}

//Fill the game with new enemies 
void createNewEnemies(){
  if(enemyShips.size() < enemyShipLimit){
    //X pos, Y pos, radius of ship, hp, enemy = 3, R, G, B
    enemyShips.add(new EnemyShip(int(random(width / 8, width * 7 / 8)), height / 8, width / 48, 3, 1, 255, 0, 0));
  }
}
  
//checks if player wants to fire and shoots off new projectiles
void playerFireTurn(){
  if(playerG.isFiring() && (playerProjectiles.size() < playerProjectilesLimit) && playerG.getCounter() >= 10){
    //X pos, Y pos, radius of projectile, player projectile = 2, R, G, B
    playerProjectiles.add(new Projectile(playerG.getPosX(), playerG.getPosY(), projectileSize, 2, 0, 255, 0));
    playerG.resetCounter();
  }
}

//checks if any player projectiles hit any enemies
void playerHitTurn(){
  //Check if player projectiles hit enemies
  for(int i = 0; i < enemyShips.size(); i++){
    for(int j = 0; j < playerProjectiles.size(); j++){
      if(enemyShips.get(i).isHit(playerProjectiles.get(j))){
        playerProjectiles.remove(j);
        j--;
        enemyShips.get(i).reduceLife(1);
        if(enemyShips.get(i).getLife() <= 0){
          enemyShips.remove(i);
          scoreGalaga++;
        }
        break;
      }
      else if(playerProjectiles.get(j).isOffMap()){
        playerProjectiles.remove(j);
        j--;
      }
    }
  }
}

//Enemy ai shoots off new projectiles to the player
void enemyFireTurn(){
  if(enemyProjectiles.size() < enemyProjectilesLimit){
    for(EnemyShip es : enemyShips){
      if(random(0, 1) > 0.99 || (es.getCounter() >= 15 && es.getPosX() <= (playerG.getPosX() + projectileSize) && es.getPosX() > (playerG.getPosX() - projectileSize))){
        //X pos, Y pos, radius of projectile, enemy projectile = 4, R, G, B
        enemyProjectiles.add(new Projectile(es.getPosX(), es.getPosY(), projectileSize, 4, 255, 0, 0));
        es.resetCounter();
      }
    }      
  }
}

//checks if enemy projectiles hit the player
void enemyHitTurn(){
  for(int i = 0; i < enemyProjectiles.size(); i++){
    if(playerG.isHit(enemyProjectiles.get(i))){
      enemyProjectiles.remove(i);
      i--;
      playerG.reduceLife(1);
    }
    
    else if(enemyProjectiles.get(i).isOffMap()){
      enemyProjectiles.remove(i);
      i--;
    }
  }
}

void generateStars(){
  starMapX = new float[50];
  starMapY = new float[50];
  starMapColor = new int[50];
  starMapSize = new float[50];
  for(int i = 0; i < stars; i++){
    starMapX[i] = random(0, width);
    starMapY[i] = random(0, height);
    starMapColor[i] = int(random(0, 255));
    starMapSize[i] = random(0, 4);
  }
}

void generateBackground(){
  background(25, 25, 25);
  for(int i = 0; i < stars; i++){
    fill(255, 255, starMapColor[i]);
    circle(starMapX[i], starMapY[i], starMapSize[i]);
  }
}

public class EnemyShip extends Ship{
  protected int R;
  protected int B;
  protected int G;
  private int sideMovement;
  
  public EnemyShip(int posX, int posY, int hitboxRadius, int whoseHitbox, int life, int R, int G, int B){
    super(posX, posY, hitboxRadius, whoseHitbox, life, R, G, B);
  }
  
  void moveEnemy(){
    posY += int(random(0, 2));
    if(posX >= width - hitboxRadius)
      sideMovement = -3;
    else if(posX <= hitboxRadius)
       sideMovement = 3;
    else if(firingCounter % 20 == 0){
        sideMovement = int(random(-4, 4));
    }
    posX += sideMovement;
  }
  
  boolean isOffMap(){
    return(posY >= height);
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
  
  int playerMovementSpeed = 4;
    
  public PlayerShip(int posX, int posY, int hitboxRadius, int whoseHitbox, int life, int R, int G, int B){
    super(posX, posY, hitboxRadius, whoseHitbox, life, R, G, B);
  }
  
  void movePlayer(){
    byte playerInput = input;
    if((playerInput&west) == west && !(posX <= hitboxRadius)){
      posX -= playerMovementSpeed;
    }
    
    if((playerInput&east) == east && !(posX >= width - hitboxRadius)){
      posX += playerMovementSpeed;
    }
  }
  
  //Prevent firing multiple times when pressed, on click only
  boolean isFiring(){
    return ((getInput(0)&16) == 16 && firingCounter >= 10);
  }
}

public class Projectile extends Hitbox{
  protected int R;
  protected int G;
  protected int B;
  private int projectileSpeed = 7;

  
  public Projectile(int posX, int posY, int hitboxRadius, int whoseHitbox, int R, int G, int B){
    super(posX, posY, hitboxRadius, whoseHitbox);
    this.R = R;
    this.G = G;
    this.B = B;
  }
  
  void moveProjectile(){
    if(whoseHitbox == 2){
      this.posY += -1 * projectileSpeed;
    }
    else if(whoseHitbox == 4){
      this.posY += projectileSpeed;
    }
  }
  
  void drawModel(){
    fill(R, G, B);
    circle(posX, posY, hitboxRadius);
  }
  
  boolean isOffMap(){
    return(posY <= 0 || posY >= height);
  }
    
}

public class Ship extends Hitbox{
  protected int life;
  protected int R;
  protected int G;
  protected int B;
  protected int firingCounter = 0;

  
  public Ship(int posX, int posY, int hitboxRadius, int whoseHitbox, int life, int R, int G, int B){
    super(posX, posY, hitboxRadius, whoseHitbox);
    this.life = life;
    this.R = R;
    this.G = G;
    this.B = B;

  }
  
  int getLife(){
    return life;
  }
  
  void reduceLife(int damage){
    life = life - damage;
  }
  
  void incrementCounter(){
    firingCounter++;
  }
  
  void resetCounter(){
    firingCounter = 0;
  }
  
  int getCounter(){
    return firingCounter;
  }
  
  void drawModel(){
    fill(R, G, B);
    square(posX, posY, hitboxRadius);
    //super.debug_showHitbox();
  }
}
