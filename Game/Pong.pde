int PlayerBarY;
int ComputerBarY;
int PlayerBarSpeed = 10;
int ComputerBarSpeed = 6;
int pongBallX;
int pongBallY;
PongBar pongBars = new PongBar();
PongBall pongBall = new PongBall();
Counter playerCounter;
Counter computerCounter;

public class Counter {
  private int count = 0;
  private int x, y;
  Counter(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void display() {
    fill(255);
    PFont f = createFont("Arial", 16, true);
    textFont(f,36);
    text(count, x, y);
  }
}

public class PongBall {
  float ballVelX = random(3,5);
  float ballVelY = random(3,5);
  float dir = random(0,1);
  int pongBallRadius = 6;
  
  void display() {
    fill(255,255,255);
    ellipse(pongBallX, pongBallY, 2*pongBallRadius,2*pongBallRadius);
  }
  
  void move() {
    pongBallX += ballVelX;
    pongBallY -= ballVelY;
    if(pongBallX > width-pongBallRadius || pongBallX < pongBallRadius) {
      if(ballVelX > 0)
        playerCounter.count++;
      else
        computerCounter.count++;
      pongBallX = width/2;
      pongBallY = (int)random(0.25*height, 0.75*height);
      ballVelX = random(2,4);
      ballVelY = random(2,4);
      dir = random(0,1);
      if(dir > 0.5)
        ballVelX*= -1;
    }
    
    if((pongBallY < pongBallRadius && ballVelY > 0) || (pongBallY > height-pongBallRadius && ballVelY < 0))
      ballVelY *= -1;
    if((pongBallX < 35+pongBallRadius && ballVelX < 0 && PlayerBarY < pongBallY && PlayerBarY+100 > pongBallY) || 
       (pongBallX > width-35-pongBallRadius && ballVelX > 0 && ComputerBarY < pongBallY && ComputerBarY+100 > pongBallY)){
      ballVelX *= -1.085;
      ballVelY *=  1.050;
      
    }
    
  }
  
}

public class PongBar {
  
  int targetY = 0;
  
  void display() {
    fill(76, 175, 80);
    stroke(0);
    rect(10, PlayerBarY, 20, 20);
    rect(10, PlayerBarY+20, 20, 20);
    rect(10, PlayerBarY+40, 20, 20);
    rect(10, PlayerBarY+60, 20, 20);
    rect(10, PlayerBarY+80, 20, 20);
    noStroke();
    fill(255,255,255);
    rect(width - 30, ComputerBarY, 20, 100);
  }
  
  void move() {
    byte playerInput = input;
    if((playerInput&south) == south && PlayerBarY+100 < height) PlayerBarY += PlayerBarSpeed;
    if((playerInput&north) == north && PlayerBarY     > 0)      PlayerBarY -= PlayerBarSpeed;
    
    if(pongBall.ballVelX < 0) targetY = height/2;
    else             targetY = pongBallY;
    
    if(ComputerBarY+50 < targetY-15 && ComputerBarY+100 < height)  ComputerBarY += ComputerBarSpeed;
    else if(ComputerBarY+50 > targetY+15 && ComputerBarY > 0)      ComputerBarY -= ComputerBarSpeed;  
  }
  
}
