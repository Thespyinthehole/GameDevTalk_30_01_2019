class TerrainData {
  Tile[][] terrain;
  int wid;
  int hei;
  
  TerrainData(int wid, int hei, FrequencySet frequency){
    this.wid = wid;
    this.hei = hei;
    terrain = new Tile[wid][hei];
    for(int x = 0; x < wid; x++){
      for(int y = 0; y < hei; y++){
        terrain[x][y] = new UnknownTile(frequency);     
      }
    } 
  } 
  
  TerrainData(int wid, int hei, Tile base){
    this.wid = wid;
    this.hei = hei;
    terrain = new Tile[wid][hei];
    for(int x = 0; x < wid; x++){
      for(int y = 0; y < hei; y++){
        terrain[x][y] = base.copy();     
      }
    } 
  }
  
  void draw(float _x, float _y, float len, float heig){
    float xScale = len / wid;
    float yScale = heig / hei;

    for(int x = 0; x < wid; x++){
      for(int y = 0; y < hei; y++){
        terrain[x][y].draw(x * xScale + _x, y * yScale + _y, xScale, yScale);     
      }
    }
  }
 
  FrequencySet generateFrequency(){
    FrequencySet frequency = new FrequencySet();
    for(int x = 0; x < wid; x++){
      for(int y = 0; y < hei; y++){
        frequency.addTile(terrain[x][y]);     
      }
    }
    return frequency;
  }
  
  AdjacencyRuleSet generateRules(){
    AdjacencyRuleSet rules = new AdjacencyRuleSet();
    for(int x = 0; x < wid; x++){
      for(int y = 0; y < hei; y++){
        Tile current = terrain[x][y];
        if (x != 0){
          Tile left = terrain[x-1][y];
          AdjacencyRule rule = new AdjacencyRule(current,left,Direction.left);
          rules.addRule(rule);
        }
        if (y != 0){
          Tile up = terrain[x][y-1];
          AdjacencyRule rule = new AdjacencyRule(current,up,Direction.up);
          rules.addRule(rule);
        }
        if (x != wid-1){
          Tile right = terrain[x+1][y];
          AdjacencyRule rule = new AdjacencyRule(current,right,Direction.right);
          rules.addRule(rule);
        }
        if (y != hei-1){
          Tile down = terrain[x][y+1];
          AdjacencyRule rule = new AdjacencyRule(current,down,Direction.down);
          rules.addRule(rule);
        }
      }
    }
    return rules;
  }
  
  void runRule(AdjacencyRuleSet rules, FrequencySet frequency){
    PVector pos = getLowestEntropy();
    UnknownTile u = (UnknownTile)getTile(pos);
    Tile selection = u.pickTile(frequency);
    ArrayList<AdjacencyRule> newRules = rules.getRules(selection);
    if(selection != null)
      setTile(selection,pos);
    
    
      
    for(AdjacencyRule r : newRules){
      Direction dir = r.direction;
      PVector shiftedPos = pos.copy();
      
      switch(dir){
        case up:
          shiftedPos.add(new PVector(0,-1));
          break;
        case down:
          shiftedPos.add(new PVector(0,1));        
          break;
        case right:
          shiftedPos.add(new PVector(1,0));        
          break;
        case left:
          shiftedPos.add(new PVector(-1,0)); 
          break;
      }
      
      Tile _t = getTile(shiftedPos);
      if (!(_t instanceof UnknownTile))
        continue;
      UnknownTile _u = (UnknownTile)_t;
      if (!_u.contains(r.next))
        _u.addNewPossible(r.next);
    }
    Tile t = getTile(pos.add(new PVector(0,-1)));
    if (t instanceof UnknownTile)
      ((UnknownTile)t).updatePossible();
      
    t = getTile(pos.add(new PVector(0,1)));
    if (t instanceof UnknownTile)
      ((UnknownTile)t).updatePossible();
      
    t = getTile(pos.add(new PVector(1,0)));
    if (t instanceof UnknownTile)
      ((UnknownTile)t).updatePossible();
      
    t = getTile(pos.add(new PVector(-1,0)));
    if (t instanceof UnknownTile)
      ((UnknownTile)t).updatePossible();
  }
  
  Tile getTile(PVector pos){
    if (pos.x < 0 || pos.x >= wid)
      return null;
    if (pos.y < 0 || pos.y >= hei)
      return null;
    return terrain[(int)pos.x][(int)pos.y];
  }
  
  void setTile(Tile t, PVector pos){
    if (pos.x < 0 || pos.x >= wid)
      return;
    if (pos.y < 0 || pos.y >= hei)
      return;
    terrain[(int)pos.x][(int)pos.y] = t;
  }
  
  PVector getLowestEntropy(){
    ArrayList<PVector> possible = new ArrayList<PVector>();
    float min = Float.POSITIVE_INFINITY;
    for(int x = 0; x < wid; x++){
      for(int y = 0; y < hei; y++){
        Tile t = terrain[x][y];
        if (!(t instanceof UnknownTile))
          continue;
        UnknownTile u = (UnknownTile)t;
        if (u.entropy < min){
          min = u.entropy;
          possible = new ArrayList<PVector>();
        }
        
        if (u.entropy == min){
          possible.add(new PVector(x,y)); 
        }
      }
    }   
    
    return possible.get((int)random(0,possible.size()));
  }
  
  void addTile(Tile tile, int x, int y){
    if (x > wid || x < 0)
      return;
    if (y > hei || y < 0)
      return;
      
    terrain[x][y] = tile.copy();
  }
}
