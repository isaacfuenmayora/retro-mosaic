public class Timer{
  
  private int startFrame;
  
  public Timer(){
    startFrame = frameCount;
  }
  
  public int getTime(){
    return frameCount-this.startFrame;
  }
  
  public void resetTime(){
    startFrame = frameCount;
  }
  
}
