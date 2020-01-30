Gradient g;

void setup(){
  size(400,400);
  g = new Gradient(color(0,0,255),color(255));
  g.addColor(color(255,255,0),0.05);
  g.addColor(color(0,255,0),0.15);
  g.addColor(color(128),0.8);
  g.addColor(color(255),0.9);
  //g = new Gradient(color(0),color(255));
}

void draw(){
  int xNums = 400;
  int yNums = 400;
  float xScale = width/xNums;
  float yScale = height/yNums;
  noStroke();
  for(float x = 0; x < width; x += xScale){
    for(float y = 0; y < height; y += yScale){
      float val = getHeight(x,y);
      float valMapped = map(val,-1,1,0,1);
      color c = g.getLerpColorStrong(valMapped,0.25);
      fill(c);
      rect(x,y,xScale,yScale);  
    } 
  }
  noLoop();
}

float getHeight(float x, float y){
  float noi = perlinOctaves(x,y,2,0.8);//-1 to 1
  return noi * noi * 2 - 1;
}

float perlinOctaves(float x, float y, int octs, float persis){
  float total = 0;
  float freq = 4f / width; 
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

class Gradient {
  ArrayList<GradientPoint> points = new ArrayList<GradientPoint>();
  
  Gradient(color start, color end){
    GradientPoint srt = new GradientPoint(start,0);
    GradientPoint en = new GradientPoint(end,1);
    points.add(srt);
    points.add(en);
  }
  
  color getLerpColor(float pos){
   if (pos <= 0)
     return points.get(0).c;
   if (pos >= 1)
     return points.get(points.size()-1).c;
   for(int i = 0; i < points.size()-1; i++){
     GradientPoint cur = points.get(i);
     GradientPoint next = points.get(i+1);
     if (!(cur.pos < pos && pos < next.pos))
       continue;
     color c1 = cur.c;
     color c2 = next.c;
     float p1 = cur.pos;
     float p2 = next.pos;
     float range = p2 - p1;
     float amt = (pos - p1) / range;
     return lerpColor(c1,c2,amt);
   }
   return color(0);
  }

  color getLerpColorStrong(float pos, float buffer){
   if (pos <= 0)
     return points.get(0).c;
   if (pos >= 1)
     return points.get(points.size()-1).c;
   for(int i = 0; i < points.size()-1; i++){
     GradientPoint cur = points.get(i);
     GradientPoint next = points.get(i+1);
     if (!(cur.pos < pos && pos < next.pos))
       continue;
     color c1 = cur.c;
     color c2 = next.c;
     float p1 = cur.pos;
     float p2 = next.pos;
     float range = p2 - p1;
     float amt = (pos - p1) / range;
     if (amt < buffer)
       return c1;
     if(amt > 1-buffer)
       return c2;
     float lerpAmt = 2 * (amt-buffer)/buffer;
     return lerpColor(c1,c2,lerpAmt);
   }
   return color(0);
  }
  
  color getColor(float pos){
   if (pos <= 0)
     return points.get(0).c;
   if (pos >= 1)
     return points.get(points.size()-1).c;
   for(int i = 0; i < points.size()-1; i++){
     GradientPoint cur = points.get(i);
     GradientPoint next = points.get(i+1);
     if (!(cur.pos < pos && pos < next.pos))
       continue;
     return cur.c;
   }
   return color(0);
  }
  
  boolean addColor(color c, float pos){
   if (pos <=0 || pos >= 1)
     return false;
   for(int i = 0; i < points.size()-1; i++){
     GradientPoint cur  = points.get(i  );
     GradientPoint next = points.get(i+1);
     if(cur.pos  >  pos)
       continue;
     if(cur.pos  == pos)
       return false;
     if(pos  > next.pos)
       continue;
     if(next.pos == pos)
       return false;
     
     GradientPoint now = new GradientPoint(c,pos);
     points.add(i+1,now);
   }
   return false;
  }
}

class GradientPoint{
  color c;
  float pos;
  
  GradientPoint(color c, float pos){
    this.c = c;
    this.pos = pos;
  }
}
