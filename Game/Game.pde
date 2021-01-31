import java.util.PriorityQueue; 
import java.util.Queue; 
SnakeGrid snak;

void setup(){
  size(515,515);
  frameRate(12);
  byte numApples = 3;
  snak = new SnakeGrid(21,21,numApples);
}

void draw(){
  background(51);
  snak.display();
  if(!snak.move());
    //background(255);
}
