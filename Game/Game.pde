
SnakeGrid snak;

void setup(){
  size(515,515);
  byte numApples = 3;
  snak = new SnakeGrid(11,11,numApples);
}

void draw(){
  snak.display();
}
