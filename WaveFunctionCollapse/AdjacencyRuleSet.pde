public class AdjacencyRuleSet {
  ArrayList<AdjacencyRule> rules = new ArrayList<AdjacencyRule>();
  
  void addRule(AdjacencyRule rule){
    if(inRules(rule))
      return;
    rules.add(rule);
  }
  
  boolean inRules(AdjacencyRule rule){
    for(AdjacencyRule r : rules){
      if (r.equals(rule))
        return true;
    }
    return false;
  }
  
  String toString(){
    String s = "";
    for(AdjacencyRule r : rules){
      s += r.toString() + "\n";
    }
    return s;
  }
  
  ArrayList<AdjacencyRule> getRules(Tile t){
    ArrayList<AdjacencyRule> selectRules = new ArrayList<AdjacencyRule>();
    for(AdjacencyRule r : rules){
      if (r.current.equals(t))
        selectRules.add(r);
    }
    return selectRules;
  }
}
