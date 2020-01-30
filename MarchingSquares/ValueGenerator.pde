class ValueGenerator {
  float generateValue(float x, float y){
    float flat = flatGround(y-10);
    return flat + _cos(x/width) ;//_noise(x,y,4,0.4);      
  }
  
  float flatGround(float y){
    float ratio = (y)/ (height); 
    return -(ratio * 2 - 1);
  }
  
  float _sin(float a){
    return sin(a * 2 * PI);
  }
  
  float _cos(float a){
    return cos(a * 2 * PI);
  }
  
  float _noise(float x, float y){
    float scale = 5;
    float xScale = scale / width;
    float yScale = scale / height;
    return noise(x * xScale, y * yScale) * 2 - 1;
  }
  
  float _noise(float x, float y, int octs, float persis){
  float total = 0;
  float freq = 0.0025; 
  float amp = 128;
  float max = 0;
   
  for(int i = 0; i < octs; i++){
    total += noise(x * freq, y * freq) * amp;
    max += amp;
    amp *= persis;
    freq *= 2;
  }
  return (total / max) * 2 - 1;
}
}
