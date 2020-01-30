class UnknownTile extends Tile {
  ArrayList<Tile> possibleTiles = new ArrayList<Tile>();
  ArrayList<Tile> nextPossibleTiles = new ArrayList<Tile>();
  float entropy;
  
  UnknownTile(FrequencySet frequency){
    super(color(255),"");
    for(TileCount t : frequency.tiles){
      possibleTiles.add(t.tile); 
    }
    calculateEntropy(frequency);
  }
  
  //needs to take into account rules
  void calculateEntropy(FrequencySet frequency){
    entropy = 0;
    for(Tile _t : possibleTiles){
      float prob = frequency.getProbability(_t);
      entropy -= prob * log(prob);
    }
  }
  
  Tile pickTile(FrequencySet frequency){
     int total = 0;
     for (Tile t : possibleTiles){
       total += frequency.getFrequency(t); 
     }
     int number = round(random(0,total));
     int count = 0;
     for (Tile t : possibleTiles){
       int c = frequency.getFrequency(t);
       if (count + c > number)
         return t;
       count += c; 
     }
     return null;
  }
  
  boolean contains(Tile t){
    for(Tile _t : possibleTiles){
      if (t.equals(_t))
        return true;
    }
    return false;
  }
  
  void addNewPossible(Tile t){
    if (!contains(t))
      return;
    nextPossibleTiles.add(t);
  }
  
  void updatePossible(){
     possibleTiles = nextPossibleTiles;
     nextPossibleTiles = new ArrayList<Tile>();
  }
}
