float scale = 2.0f;
void setup(){
  size(400,400);
}

void draw(){
  float lastY = 0;
  for(int x = 0; x < width; x++){
    float y = map(getHeight(x),-1,1,width,0);
    if (x == 0){
      lastY = y;
      continue;
    }
    line(x-1,lastY,x,y);
    lastY = y;
  }
  noLoop();
}

float getHeight(float x){
  float mul = scale / width;
  return perlinOctaves(x*mul,3,0.9);
}

float perlinOctaves(float x, int octs, float persis){
  float total = 0;
  float freq = 1; 
  float amp = 1;
  float max = 0;
   
  for(int i = 0; i < octs; i++){
    total += noise(x * freq) * amp;
    max += amp;
    amp *= persis;
    freq *= 2;
  }
  return (total / max) * 2 - 1;
}
