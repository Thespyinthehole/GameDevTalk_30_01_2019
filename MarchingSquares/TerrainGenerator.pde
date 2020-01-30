class TerrainGenerator {
  ValueGenerator generator = new ValueGenerator();
  
  float getValue(float x, float y){
    return generator.generateValue(x,y);
  }
  
  void drawOne(int x, int y, int len, int hei){
    
  }
  
  void draw(int x, int y, int len, int hei, int xScale, int yScale){
    for(int _x = 0; _x < len; _x+=xScale){
      for(int _y = 0; _y < hei; _y+=yScale){
        drawOne(x + _x, y + _y, xScale, yScale);   
      } 
    }
  }
}
