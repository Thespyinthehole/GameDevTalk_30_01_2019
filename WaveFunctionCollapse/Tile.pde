public class Tile {
  color c;  
  String name = "";
  
  Tile(color c, String name){
    this.c = c;
    this.name = name;
  }
  
  void draw(float x, float y, float len, float hei){
    fill(c);
    rect(x,y,len,hei);
  }
  
  Tile copy(){
    return new Tile(c,name); 
  }
  
  boolean equals(Tile tile){
    if (tile == null)
      return false;
    return tile.c == c && tile.name == name;  
  }
  
  String toString(){
   return name; 
  }
}
