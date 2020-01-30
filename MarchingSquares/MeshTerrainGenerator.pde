class MeshTerrainGenerator extends TerrainGenerator {
  int[][] tris = new int[][]{
                  new int[]{},
                  new int[]{0,1,2},
                  new int[]{0,1,2},
                  new int[]{0,1,2,1,2,3},
                  new int[]{0,1,2},
                  new int[]{0,1,2,1,2,3},
                  new int[]{0,2,5,1,3,4,2,3,4,2,4,5},  //special case
                  new int[]{0,1,2,2,3,4,1,2,4},
                  new int[]{0,1,2},
                  new int[]{0,2,3,1,4,5,2,3,4,2,4,5},  //special case
                  new int[]{0,1,2,1,2,3},
                  new int[]{0,1,2,0,2,3,2,3,4},
                  new int[]{0,1,2,1,2,3},
                  new int[]{0,1,2,0,3,4,0,4,2},
                  new int[]{0,1,2,0,1,4,0,4,3},
                  new int[]{0,1,2,1,2,3},
               };
               
  boolean basic;
  
  MeshTerrainGenerator(boolean basic){
     this.basic = basic; 
  }
  
  void drawTriangles(ArrayList<PVector> verts, int[] tris){
    if (tris.length % 3 != 0)
      return;
    for(int i = 0; i < tris.length; i += 3){
      drawTriangle(verts,tris[i],tris[i+1],tris[i+2]);
    }
  }
  
  void drawTriangle(ArrayList<PVector> verts, int i, int o, int p){
    PVector v1 = verts.get(i);
    PVector v2 = verts.get(o);
    PVector v3 = verts.get(p);
    beginShape();
    vertex(v1.x,v1.y);
    vertex(v2.x,v2.y);
    vertex(v3.x,v3.y);
    endShape();
    //triangle(v1.x, v1.y, v2.x, v2.y, v3.x, v3.y);
  }
  
  
  int getTrisPosition(int x, int y, int len, int hei){
    int total = 0;
    int times = 0;
    for(float i = 0; i <= 1; i++){
      for(float o = 0; o <= 1; o++){
        float val = getValue(x + len * i,y + hei * o);
        total += val < 0 ? pow(2,times) : 0;
        times++;
      }  
    }
    return total;
  }
  
  void drawSquare(ArrayList<PVector> verts, int x, int y, int len, int hei){
    int pos = getTrisPosition(x,y,len,hei);
    if (basic){
      drawTriangles(verts,tris[pos]);
      return;
    } 
    if (pos == 6 || pos == 9){
      float mid = getValue(x+len/2,y+hei/2);
      if (mid < 0){
        drawTriangles(verts,tris[pos]);
        return;
      }
      
      int[] tri = new int[6];
      for(int i = 0; i < 6; i++){
         tri[i] = tris[pos][i]; 
      }
      drawTriangles(verts,tri); 
      return;
    }
    drawTriangles(verts,tris[pos]);  
  }
  
  void drawOne(int x, int y, int len, int hei){
    ArrayList<PVector> verts = getVerts(x,y,len,hei);
    drawSquare(verts,x,y,len,hei);
  }
  
  ArrayList<PVector> getVerts(int x, int y, int len, int hei){
    return null;
  }
}
