public class GameManager{
  
  // 01 | Snake
  
  int currentSceneId = 1;
  boolean paused = false;
  boolean enablingPause = false;
  boolean disablingPause = false;
  int startFrame = 0;
  Timer pauseTimer = new Timer();
  Timer sceneTimer = new Timer();
  
  private void pauseSequence(){
    int time = pauseTimer.getTime();
    if(time >= 7){
      if(disablingPause){
        paused = false;
      }
      enablingPause = false;
      disablingPause = false;
    }
    if(enablingPause){
      displayPauseScreen(7*time);
    }
    else if(disablingPause){
      displayPauseScreen(70-7*time);
    }
  }
  
  private void displayPauseScreen(int a){
      fill(255, a);
      noStroke();
      rect(0,0,width,height);
    }
  
  public void playScene(){
    
    //Handle pause input, set either enabling pause or disabling pause to true
    if(((input&pause)==pause && (previousInput&pause)==0) && !(enablingPause || disablingPause)){
      if(paused){
        disablingPause = true;
        pauseTimer.resetTime();
      }
      enablingPause = !disablingPause;
      paused = true;
    }
    
    //Run current scene
    switch(currentSceneId){
      
      //SNAKE
      case 1:
        rectMode(CORNER);
        if(!paused){
          if(sceneTimer.getTime()>=7){
            if(snak.move()){
              snak = new SnakeGrid(21,21,numApples,appleDepth);
            }
            sceneTimer.resetTime();
          }
        }
        snak.display();
        break;
      
      //GLALACTICA
      case 2:
        rectMode(RADIUS);
        if(!paused){
          playerG.incrementCounter();
          createNewEnemies();
            
          playerG.movePlayer();
          moveEnemies();
          
          playerFireTurn();
          enemyFireTurn();
          
          playerHitTurn();
          enemyHitTurn();
          sceneTimer.resetTime();
        }
        generateBackground();
        drawEnemies();
        playerG.drawModel();
        break;
        
      //PONGCHAMP
      case 3:
        rectMode(CORNER);
        if(!paused){
          pongBars.move();
          pongBall.move();
        }
        pongBars.display();
        pongBall.display();
        computerCounter.display();
        playerCounter.display();
        break;
      
    }
    
    if(enablingPause || disablingPause)
      pauseSequence();
    else if (paused)
      displayPauseScreen(70);
    
  }
  
  
  
}
