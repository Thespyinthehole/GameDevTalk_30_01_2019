void setup(){
  size(800,800); 
}
         

TerrainGenerator gen = new FullMarchingSquares(false);
void draw(){
  stroke(255);
  noStroke();  //strokeWeight(1);
  gen.draw(0,0,width,height,20,20);
  
  noLoop();
}
