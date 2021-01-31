byte input = 0;
Queue<Byte> lastInputs = new PriorityQueue<Byte>(3); 

public byte getInput(int rotation){
  if(rotation < 0 || rotation > 3)
    throw new ArithmeticException("getInput() requires a number in the range [0,3]. Given: " + rotation);
  switch(rotation){
    case 0:
      return input;
    case 1: //rotate  90 deg
      return (byte)(( ((input<<1)|((input>>3)&1))&15)|(input&240));
    case 2: //rotate 180 deg
      return (byte)((((input<<2)|((input>>2)&3))&15)|(input&240));
    case 3: //rotate 270 deg
      return (byte)((((input<<3)|((input>>1)&7))&15)|(input&240));
  }
  return input;
}
private void updateLastInputs(byte singleInput){
  if(lastInputs.size()<4)
    lastInputs.add(singleInput);
}
void keyPressed() {
  byte singleInput;
  if (key=='w' || (key == CODED && keyCode == UP)){
    singleInput=(byte)(input|1);
    input = singleInput;
    updateLastInputs(singleInput);
  }
  if (key=='s' || (key == CODED && keyCode == DOWN)){
    singleInput=(byte)(input|2);
    input = singleInput;
    updateLastInputs(singleInput);
  }
  if (key=='a' || (key == CODED && keyCode == LEFT)){
    singleInput=(byte)(input|4);
    input = singleInput;
    updateLastInputs(singleInput);
  }
  if (key=='d' || (key == CODED && keyCode == RIGHT)){
    singleInput=(byte)(input|8);
    input = singleInput;
    updateLastInputs(singleInput);
  }
  if (key==' '){
    singleInput=(byte)(input|16);
    input = singleInput;
    updateLastInputs(singleInput);
  }
  if (key=='m'){
    singleInput=(byte)(input|32);
    input = singleInput;
    updateLastInputs(singleInput);
  }
  if (key=='p'){
    singleInput=(byte)(input|64);
    input = singleInput;
    updateLastInputs(singleInput);
  }
}

void keyReleased() {
  if (key=='w' || (key == CODED && keyCode == UP))
    input = (byte)(input&254);
  if (key=='s' || (key == CODED && keyCode == DOWN))
    input = (byte)(input&253);
  if (key=='a' || (key == CODED && keyCode == LEFT))
    input = (byte)(input&251);
  if (key=='d' || (key == CODED && keyCode == RIGHT))
    input = (byte)(input&247);
  if (key==' ')
    input = (byte)(input&239);
  if (key=='m')
    input = (byte)(input&223);
  if (key=='p')
    input = (byte)(input&191);
}

/*
        W     P            1     64
      A S D              2 4 8
      <SPACE> M             16   32
*/
