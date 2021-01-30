public class SnakeGrid extends Grid{
  private Block head, tail;
  private int snakeLength;
  private Apple[] apples;  ////negative index in grid (starting at -1)
  //TODO: poisoned apple
  private int timer;
  private float scale; //pixels per block
  SnakeGrid(int w, int h, byte numApples){
    super(w,h);
    snakeLength=3;
    grid[h/2][w-4]=south;
    grid[h/2][w-3]=south;
    grid[h/2][w-2]=south;
    
    head= new Block(h/2,w-4);
    tail= new Block(h/2,w-2);
    
    apples = new Apple[numApples+1];
    for(byte pos=1; pos<apples.length; pos++)
      addApple(pos);
    timer=0;
    
    scale=(width-frameWidth*2.0f)/w;
    direction=north;
  }
  boolean move(){ //returns false if lost
    updateApples();
    direction=lastDirectionalInput;
    head.move(direction);
    if(head.i>=grid[0].length || head.i<0 || head.j>=grid.length || head.j<0 || grid[head.i][head.j]>0)
      return false;
    else if(grid[head.i][head.j]==0){   
      if(timer>0){
        timer--;
      }
      else{
        byte tailDir = getOppositeDirection(grid[tail.i][tail.j]);
        println(tailDir);
        grid[tail.i][tail.j]= 0;
        tail.move(tailDir);
        println(tail.i+", "+tail.j);
      }
    }
    else{
      replaceApple((byte)-grid[head.i][head.j]);
    }
    grid[head.i][head.j]= getOppositeDirection(direction);
    return true;
  }
  private void updateApples(){
    for(short pos=1; pos<apples.length; pos++)
      apples[pos].update();
  }
  private void replaceApple(byte pos){
    timer+=apples[pos].getNumLayers();
    snakeLength+=apples[pos].getNumLayers();
    grid[apples[pos].i][apples[pos].j]=0;
    addApple(pos);
  }  
  private void addApple(byte pos){
    int ni = (int)random(0,grid.length), nj = (int)random(0,grid[0].length);
    while(grid[ni][nj]!=0){
      ni = (int)random(0,grid.length);
      nj = (int)random(0,grid[0].length);
    }
    grid[ni][nj]=(byte)(-pos);
    apples[pos] = new Apple(ni,nj);
  }
  void display(){ //FIXME: draw frame instead of black boxes, much more efficient (?)
    background(51);
    stroke(255);
    for(int i = 0; i < grid.length; i++){
      for(int j = 0; j < grid[0].length; j++){
        fill(100,100,150);
        if(grid[i][j]==0)
          fill(0);
        else if(grid[i][j]>0)
          fill(70,70,150);
        else
          fill(200,40,40);
        rect(frameWidth+i*scale,frameWidth+j*scale,scale,scale);
        fill(255);
        text(""+(int)grid[i][j],frameWidth+i*scale,frameWidth+j*scale,scale,scale);
      }
    }
  }
}

private class Apple extends Block{
  private byte numLayers;
  private int timer; 
  Apple(int _i, int _j){
    super(_i,_j);
    numLayers=1;
    timer=0;
  }
  Apple(int _i, int _j, byte _numLayers, byte _timer){
    super(_i,_j);
    numLayers=_numLayers;
    timer=_timer;
  }
  byte getNumLayers(){
    return numLayers;
  }
  void update(){
    if(timer==0)
      return;
    timer--;
    //reduces time to current layers, then reduces by one layer
    if(numLayers>1 && timer==0){
      timer=numLayers;
      numLayers--;
    }
  }
}
