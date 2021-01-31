public class GameManager{
  
  // 01 | Snake
  
  int currentSceneId = 1;
  boolean paused = false;
  int startFrame = 0;
  Timer pauseTimer = new Timer();
  
  public void playScene(){
    switch(currentSceneId){
      
      case 1:
        if(!paused){
          snak.move();
        }
        snak.display();
        
    }
    
    if(paused){
      int time = pauseTimer.getTime();
      background(0);
    }
    
  }
  
}
