public class TileCount {
  Tile tile;
  int count;
  
  TileCount(Tile tile){
    this.tile = tile;
    count = 1;
  }
  
  String toString(){
    return tile.toString() + " : " + count; 
  }
}
