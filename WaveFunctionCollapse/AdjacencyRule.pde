public class AdjacencyRule { 
  Tile current;
  Tile next;
  Direction direction;
  
  AdjacencyRule(Tile current, Tile next, Direction direction){
    this.current = current;
    this.next = next;
    this.direction = direction;
  }
  
  boolean equals(AdjacencyRule rule){
    boolean cur = current.equals(rule.current);
    boolean nex = next.equals(rule.next);
    boolean dir = direction.equals(rule.direction);
    return cur && nex && dir; 
  }  
  
  String toString(){
    return current.toString() + " " + direction.toString() + " " + next.toString(); 
  }
}

public enum Direction {
  up,
  down,
  left, 
  right
}
