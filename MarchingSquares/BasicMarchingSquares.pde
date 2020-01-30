class BasicMarchingSquares extends TerrainGenerator {  
  void drawOne(int x, int y, int len, int hei){
    float f1 = getValue(x,y);
    float f2 = getValue(x+len,y);
    float f3 = getValue(x,y+hei);
    float f4 = getValue(x+len,y+hei);
    
    if (f1 < 0){
      rect(x,y,len/2,hei/2);
    }
    
    if (f2 < 0){
      rect(x+len/2,y,len/2,hei/2);
    }
    
    if (f3 < 0){
      rect(x,y+hei/2,len/2,hei/2);
    }
    
    if (f4 < 0){
      rect(x+len/2,y+hei/2,len/2,hei/2);
    }
  }
}
