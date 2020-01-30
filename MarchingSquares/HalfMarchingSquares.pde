class HalfMarchingSquares extends MeshTerrainGenerator {
  HalfMarchingSquares(boolean basic){
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
      verts.add(new PVector(x, y + hei/2));
    }
    
    if(values.get(0) * values.get(2) < 0){
      verts.add(new PVector(x + len/2, y));
    }
    
    if(values.get(3) * values.get(2) < 0){
      verts.add(new PVector(x + len, y + hei/2));
    }
    
    if(values.get(3) * values.get(1) <= 0){
      verts.add(new PVector(x + len/2, y + hei));
    }
    return verts;
  }
}
