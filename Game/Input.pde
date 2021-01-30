private byte input = 0;

public byte getInput(int rotation){
  switch(rotation){
    case 0:
      return input;
    //rotate 90deg
    case 1:
      return (byte)(( ((input<<1)|((input>>3)&1))&15)|(input&240));
    //rotate 180deg
    case 2:
      return (byte)((((input<<2)|((input>>2)&3))&15)|(input&240));
    //rotate 270deg
    case 3:
      return (byte)((((input<<3)|((input>>1)&7))&15)|(input&240));
  }
  return 0;
}

void keyPressed() {
   if (key=='w')
     input = (byte)(input|1);
   if (key=='a')
     input = (byte)(input|2);
   if (key=='s')
     input = (byte)(input|4);
   if (key=='d')
     input = (byte)(input|8);
   if (key==' ')
     input = (byte)(input|16);
}

void keyReleased() {
   if (key=='w')
     input = (byte)(input&254);
   if (key=='a')
     input = (byte)(input&253);
   if (key=='s')
     input = (byte)(input&251);
   if (key=='d')
     input = (byte)(input&247);
   if (key==' ')
     input = (byte)(input&239);
}

/*
    W            1
  A S D        2 4 8
      <SPACE>        16
*/
