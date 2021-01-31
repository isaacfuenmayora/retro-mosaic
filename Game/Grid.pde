abstract class Grid{ 
  protected byte[][] grid;
  protected byte direction;
  public Grid(int xLength,int yLength){
    grid = new byte[yLength][xLength];
  }
  protected byte getOppositeDirection(byte dir){
      switch(dir){
        case north: return south;
        case west:  return east;
        case south: return north;
        case east:  return west;
      } return direction;
  }
  
  protected void setDirection(){
    if(lastOne != 0){
      if(lastOne!=getOppositeDirection(direction))
        direction=poll();
      else
        poll();
    }
  }
  
}

class IVector{
  public int x,y;
  IVector(int x, int y){
    this.x=x;
    this.y=y;
  }
  void move(byte dir){
    //switch(dir){
    //  case north:
    //    y--;
    //    break;
    //  case west:
    //    x--;
    //    break;
    //  case south:
    //    y++;
    //    break;
    //  case east:
    //    x++;
    //    break;
    //}
    switch(dir){
      case north:
        x--;
        break;
      case west:
        y--;
        break;
      case south:
        x++;
        break;
      case east:
        y++;
        break;
    }
  }
  String toString(){
    return "("+x+", "+y+")";
  }
}
