import java.util.LinkedList;

class SnakeGrid extends Grid{
  private IVector tail, head;
  private int snakeLength;
  private int timer;      // determines how long is left until the snake stops increasing
  private Apple[] apples; // apples[0]==null, the rest are accesed through the negative index in grid
  private LinkedList<Byte> dirs;
  
  private float scale; //pixels per block
  //private color snakeColor = new color(.5);
  
  public SnakeGrid(int w, int l, int numApples, byte appleDepth){
    super(w,l);
    snakeLength=1;
    
    head=new IVector(w/2,l/2);
    tail=new IVector(w/2,l/2);
    
    grid[head.y][head.x]=1; //FIXME: possible error
    //grid[tail.y][tail.x]=1;
    
    timer=2;
    apples = new Apple[numApples+1];
    for(byte i=1; i<apples.length; i++)
      addApple(i,appleDepth);
    dirs = new LinkedList<Byte>();
    //dirs.addLast(north);
    
    scale=(width)/w;
  }
  
  
  public IVector getHead(){return head;}
  public IVector getTail(){return tail;}
  public int getLength(){return snakeLength;}
  public boolean move(){ //true if lost;
    updateApples();
    setDirection();
    println((int)direction);
    println(head);
    println(tail);
    println();
    IVector newHead = new IVector(head.x,head.y);
    newHead.move(direction);
    if(newHead.x < 0 || newHead.x >= grid[0].length || newHead.y < 0 || newHead.y >= grid.length || grid[newHead.y][newHead.x]==wall || grid[newHead.y][newHead.x]==1)
      return true;
    head.move(direction);
    dirs.addFirst(direction);
    byte consumed = grid[head.y][head.x];
    grid[head.y][head.x]=1;
    snakeLength++;
    if(consumed<0)
      replaceApple((byte)(-grid[head.y][head.x]));
    if(timer==0){
      grid[tail.y][tail.x]=0;
      tail.move(dirs.removeLast());
      snakeLength--;
    }
    else{
      timer--;
    }
    return false;
  }
  
  private void updateApples(){
    for(short pos=1; pos<apples.length; pos++)
      apples[pos].update();
  }
  private void addApple(byte pos, byte depth){
    int nx = (int)random(0,grid.length), ny = (int)random(0,grid[0].length);
    while(grid[ny][nx]!=0){
      ny = (int)random(0,grid.length);
      nx = (int)random(0,grid[0].length);
    }
    grid[ny][nx]=(byte)(-pos);
    apples[pos] = new Apple(ny,nx,depth,head);
  }
  private void replaceApple(byte pos){//FIXME: maybe not neccesary?
    println("apple:"+(int)pos);
    pos=(byte)(-pos);
    byte depth= apples[pos].getDepth();
    timer+=depth;
    addApple(pos,apples[pos].getDepth());
    println("timer:"+timer);
  } 
  
  
  public void display(){
    for(int i = 0; i < grid.length; i++){
      for(int j = 0; j < grid[0].length; j++){
        fill(76, 175, 80);
        if(grid[i][j]==0)
          fill(0);
        else if(grid[i][j]>0)
          fill(76, 175, 80);
        else
          apples[-grid[i][j]].display(scale);
        rect(i*scale,j*scale,scale,scale);
        //fill(255);
        //text(""+(int)grid[j][i],j*scale,i*scale,scale,scale);
      }
    }
  }
}

private class Apple extends IVector{
  private byte depth;
  private int timer;
  Apple(int c, int r, byte depth, IVector head){
    super(c,r);
    this.depth=depth;
    timer=head.x+head.y-x-y;
  }
  
  public byte getDepth(){return depth;}
  public void update(){
    if(timer>1) timer--;
    else if(depth>=2){
      depth--;
      timer=12-depth/3; //timer algorithm: TODO: explore distance based timer
    }
  }
  
  public void display(float blockLength){
    stroke(.1);
    float pixDepth = blockLength/depth;
    float screenX = x*blockLength, screenY = y*blockLength;
    for(int i=0; i<=depth; i++){
      fill(250, 0, 20);
      //if(i==depth) fill(gR,gG,gB);
      if(depth==1){
        //fill(aR[0],aG[0],aB[0]);
        square(x*blockLength,y*blockLength,pixDepth*(depth-i));
        i+=2;
        screenX+=pixDepth;
        screenY+=pixDepth;
        //fill(gR,gG,gB);
      }
      square(screenX,screenY,pixDepth*(depth-i));
      screenX+=depth/2;
      screenY+=depth/2;
    }
    stroke(1);
  }
}
  ////TODO: merge moveSnake and updateGrid
  ///** moves the snake, returns {-1} if it is not a valid move, {-2,applePos} if got apple, {-3} if still growing, otherwise returns the position left in the dust **/
  //private IVector moveSnake(){
  //   setDirection();
  //   int dx=0, dy=0;
  //   //set the change in either x or y for head
  //   if((direction&(north|south))>0) dy=1;
  //   else dx=1;
  //   if(direction==north || direction==west){
  //     dx=-dx;
  //     dy=-dy;
  //   }
  //   //check the spot the head will move into
  //   IVector newHead = new IVector(head.x+dx,head.y+dy);
  //   if(newHead.x<0 || newHead.x>=grid[0].length || newHead.y<0 || newHead.y>=grid.length || grid[newHead.y][newHead.x]>0){
  //     //if it's a wall or itself, you lose
  //     IVector nope = new IVector(-1,-1);
  //     return nope; 
  //   }
  //   //update head position
  //   head.x=newHead.x;
  //   head.y=newHead.y;
  //   //add the newest direction to the list
  //   dirs.add(direction);
  //   //consumes apple if it's at the new spot
  //   if(grid[newHead.y][newHead.x] < 0){
  //     IVector yup = new IVector(-2,-grid[newHead.y][newHead.x]);
  //     snakeLength++;
  //     timer=max(0,timer+apples[-grid[newHead.y][newHead.x]].getDepth()-1);
  //     return yup;
  //   }
  //   //reduces timer if it's still growing
  //   if(timer>0){
  //     IVector growing = new IVector(-3,-3);
  //     timer--;
  //     return growing;
  //   }
  //   //saves the spot where the tail was before this move
  //   IVector dust = new IVector(tail.x,tail.y);
  //   //removes last direction (where the tail was)
  //   byte dir = dirs.poll();
  //   //set the change in either x or y for tail
  //   dx=0; dy=0;
  //   if((dir&(north|south))>0) dy=1;
  //   else dx=1;
  //   if(dir==north || dir==west){
  //     dx=-dx;
  //     dy=-dy;
  //   }
  //   //update tail position
  //   tail.x+=dx;
  //   tail.y+=dy;
  //   //return previous tail position
  //   return dust;
  //}
  ///*returns {-1} if the game is lost,{-2} if apple was found or if growing, {x,y} otherwise*/
  //public IVector updateGrid(){
  //  //get position of the place where the tail was
  //  updateApples();
  //  IVector dust = moveSnake();
  //  println(dust);
  //  if(dust.x>=0){
  //    grid[dust.y][dust.x]=0;
  //    //println(grid[dust.y][dust.x]);
  //  }
  //  if(dirs.isEmpty())
  //  //loss
  //  if(dust.x==-1) 
  //    return dust;
  //  //apple or growing
  //  if(dust.x<-1){
  //    //if an apple was consumed, make a new one
  //    if(dust.x==-2){
  //      //put an apple in a random place
  //      replaceApple((byte)(dust.y));
  //    }
  //    //get the new head position, and update the grid
  //    grid[head.y][head.x]=dirs.getFirst();
  //    //return the indicator that there should not be a block deleted
  //    return new IVector(-2,-2);
  //  }
  //  ////get the new head position, and update the grid
  //  grid[head.y][head.x]=dirs.getFirst();//FIXME FIXME
  //  //return head pos and position of the previous tail
  //  return dust;
  //}
