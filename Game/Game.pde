
SnakeGrid snak;

void setup(){
  size(515,515);
  frameRate(12);
  byte numApples = 3;
  snak = new SnakeGrid(21,21,numApples);
}

void draw(){
  clear();
  snak.display();
  if(!snak.move());
    //background(255);
}
