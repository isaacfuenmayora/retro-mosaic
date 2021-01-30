int gridSize = 5;
float boxSize = 0;

ArrayList<Event> events = new ArrayList<Event>();

Block[] blocks = {new Player(3,3),new Block(1,1,false),new Block(1,2,false),new Block(1,3,true),new Block(2,2,false),new Block(2,3,true),new Block(2,4,true),new Block(3,4,true),new Block(4,1,false)};
int[][] board;
Player player = (Player)blocks[0];

void setup(){
  size(500, 500);
  frameRate(60);
  //Determine display size "boxSize"
  float min = min(width,height)-1;
  boxSize = min/gridSize;
  strokeWeight(min/(gridSize*15));
  
  resetBoard();
  
}

void draw(){
  background(51);
  noStroke();
  
  //Update events
  boolean flag = false;
  for(int i = 0; i < events.size(); i++){
    Event currentEvent = events.get(i);
    if(currentEvent.apply()){
      currentEvent.m.x = round(currentEvent.m.x);
      currentEvent.m.y = round(currentEvent.m.y);
      currentEvent.m.checked = false;
      currentEvent.m.blocked = false;
      events.remove(i);
      i--;
      flag = true;
    }
  }
  
  //Recalculate "board" once moving is finished
  if(flag)
    resetBoard();
    
  //Display boxes
  for(Block b: blocks){
    b.show();
  }
  
  //Display gridlines
  stroke(100);
  noFill();
  for(int i = 0; i <= gridSize; i++){
    line(i*boxSize, 0, i*boxSize, gridSize*boxSize);
  }
  for(int j = 0; j <= gridSize; j++){
    line(0, j*boxSize, gridSize*boxSize, j*boxSize);
  }
  
}

void keyPressed(){
  if(!player.isMoving){
    player.isValidMove(key);
  }
}

void resetBoard(){
  board = new int[gridSize][gridSize];
  for(int i = 0; i < blocks.length; i++)
      board[(int)blocks[i].x][(int)blocks[i].y] = i;
}
