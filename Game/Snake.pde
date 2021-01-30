public class SnakeGrid extends Grid{
  private Block head, tail;
  private int snakeLength;
  private Apple[] apples;
  //TODO: poisoned apple
  private int timer;
  private int scale; //pixels per block
  SnakeGrid(int w, int h, int numApples){
    super(w,h);
    snakeLength=3;
    grid[h-4][w/2]=south;
    grid[h-3][w/2]=south;
    grid[h-2][w/2]=south;
    
    head= new Block(w/2,h-4);
    tail= new Block(w/2,h-2);
    
    apples = new Apple[numApples];
    scale=(width-frameWidth*2)/w;
    direction=north;
  }
  boolean move(){ //returns false if lost
    updateApples();
    head.move(direction);
    grid[head.i][head.j]= getOppositeDirection(direction);
    if(grid[head.i][head.j]>0 || head.i>=grid[0].length || head.i<0 || head.j>=grid.length || head.j<0){
      return false;
    }
    else if(grid[head.i][head.j]==0){
      timer--;
      if(timer>0)
        return true;
      tail.move(grid[tail.i][tail.j]);
      grid[tail.i][tail.j]= 0;
    }
    else{
      replaceApple(head.i, head.j);
    }
    return true;
  }
  void updateApples(){
    for(Apple a: apples)
      a.update();
  }
  void replaceApple(int i, int j){
    int pos=0;
    while(apples[pos].i!=i || apples[pos].j!=j){
      pos++;
    }
    timer+=apples[pos].getNumLayers();
    snakeLength+=apples[pos].getNumLayers();
    int ni = (int)random(0,grid.length+1), nj = (int)random(0,grid[0].length+1);
    while(grid[i][j]!=0){
      ni = (int)random(0,grid.length+1);
      nj = (int)random(0,grid[0].length+1);
    }
    apples[pos] = new Apple(ni,nj);
  }
  void display(){
    background(51);
    for(int i = 0; i < grid.length; i++){
      for(int j = 0; j < grid[0].length; j++){
        if(grid[i][j]==0)
          fill(0);
        else if(grid[i][j]>0){
          fill(70,70,150);
          print("bruh");
        }
        else
          fill(200,20,20);
        rect(frameWidth+i*scale,frameWidth+j*scale,scale,scale);
      }
      print();
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
