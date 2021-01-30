public abstract class Grid{
  protected final static byte north=1, west=4, south=2, east=8;
  protected final float frameWidth=15;
  protected byte direction; 
  protected byte[][] grid;
  Grid(int w, int h){
    grid = new byte[h][w];
  }
  byte getOppositeDirection(byte dir){
    switch(dir){
      case north:
        return south;
      case west:
        return east;
      case south:
        return north;
      case east:
        return west;
    }
    return 0;
  }
}
public class Block{
  protected final static byte north=1, west=2, south=4, east=8;
  public int i, j;
  Block(int _i, int _j){
    i=_i;
    j=_j;
  }
  void move(byte dir){
    switch(dir){
      case north:
        j--;
        break;
      case west:
        i++;
        break;
      case south:
        j++;
        break;
      case east:
        i--;
        break;
    }
  }

}
