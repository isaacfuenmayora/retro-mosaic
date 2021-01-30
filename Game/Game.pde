
SnakeGrid snak;

void setup(){
  size(512,512);
  snak = new SnakeGrid(512,512,1);
}

void draw(){
  snak.display();
}
