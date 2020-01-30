Tile water = new Tile(color(0,0,255), "water");
Tile grass = new Tile(color(0,255,0), "grass");
Tile mountain = new Tile(color(180), "mountain");

TerrainData data;
TerrainData ruleSet = new TerrainData(7,7,water);
AdjacencyRuleSet rules;
FrequencySet frequency;

void setup(){
  size(400,400);
  ruleSet.addTile(mountain,3,3);
  ruleSet.addTile(grass,4,3);
  ruleSet.addTile(grass,3,4);
  ruleSet.addTile(grass,2,3);
  ruleSet.addTile(grass,3,2);
  ruleSet.addTile(grass,2,2);
  ruleSet.addTile(grass,4,4);
  ruleSet.addTile(grass,4,2);
  ruleSet.addTile(grass,2,4);
  ruleSet.addTile(grass,3,1);
  ruleSet.addTile(grass,3,5);
  ruleSet.addTile(grass,1,3);
  ruleSet.addTile(grass,5,3);
  rules = ruleSet.generateRules();
  frequency = ruleSet.generateFrequency();
  data = new TerrainData(10,10,frequency);
}

void draw(){
  data.draw(0,0,width,height);
  //noLoop();
}

void mousePressed(){
  data.runRule(rules, frequency);
}
