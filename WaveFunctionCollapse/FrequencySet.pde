public class FrequencySet {
  ArrayList<TileCount> tiles = new ArrayList<TileCount>();
  int total = 0;
  void addTile(Tile t){
    for(TileCount _t : tiles){
      if(_t.tile.equals(t)){
        _t.count++;
        total++;
        return;  
      }
    }
    total++;    
    tiles.add(new TileCount(t)); 
  }
  
  String toString(){
    String s = "";
    for(TileCount t : tiles){
      s += t.toString() + "\n"; 
    }
    return s;
  }
  
  float getProbability(Tile t){
    for(TileCount _t : tiles){
      if(_t.tile.equals(t)){
        return _t.count / (float)total; 
      }
    }
    return 0;
  }
  
  int getFrequency(Tile t){
     for(TileCount _t : tiles){
      if(_t.tile.equals(t)){
        return _t.count; 
      }
    }
    return -1;
  }
}
