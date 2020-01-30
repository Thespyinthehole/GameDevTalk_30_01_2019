class FullMarchingSquares extends MeshTerrainGenerator {
  FullMarchingSquares(boolean basic){
    super(basic); 
  }
  
  ArrayList<PVector> getVerts(int x, int y, int len, int hei){      
    ArrayList<PVector> verts = new ArrayList<PVector>();
    ArrayList<Float> values = new ArrayList<Float>();
    
    for(float i = 0; i <= 1; i++){
      for(float o = 0; o <= 1; o++){
        float value = getValue(x + len * i,y + hei * o);
        if (value <= 0)
          verts.add(new PVector(x + len * i,y + hei * o));
        values.add(value);
      }  
    }
    
    if(values.get(0) * values.get(1) < 0){
      PVector c1 = new PVector(x,y);
      PVector c2 = new PVector(x,y+hei);
      float lerp = -values.get(0)/(values.get(1)-values.get(0));
      c1.lerp(c2,lerp);
      verts.add(c1);
    }
    
    if(values.get(0) * values.get(2) < 0){
      PVector c1 = new PVector(x,y);
      PVector c2 = new PVector(x+len,y);
      float lerp = -values.get(0)/(values.get(2)-values.get(0));
      c1.lerp(c2,lerp);
      verts.add(c1);
    }
    
    if(values.get(3) * values.get(2) < 0){
      PVector c1 = new PVector(x+len,y+hei);
      PVector c2 = new PVector(x+len,y);
      float lerp = -values.get(3)/(values.get(2)-values.get(3));
      c1.lerp(c2,lerp);
      verts.add(c1);
    }
    
    if(values.get(3) * values.get(1) < 0){
      PVector c1 = new PVector(x+len,y+hei);
      PVector c2 = new PVector(x,y+hei);
      float lerp = -values.get(3)/(values.get(1)-values.get(3));
      c1.lerp(c2,lerp);
      verts.add(c1);
    }
    return verts;
  }
}
