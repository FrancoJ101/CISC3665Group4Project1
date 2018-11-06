class Player {
  String coin;      // Player coin face selection; "heads" or "tails" or "wildcard"
  boolean turn;   // Whether player made selection or not
  int points;
  int wager;
  int x,y;
  Player() {
    coin = " ";
    turn = false;
    points = 500;
  }

  void losePoints(int value) {
    points-=value;
  }

  void gainPoints(int value) {
    points+=value;
  }

  void setCoin(String value) {
    coin = value;
  }

  void setTurn(boolean selected) {
    turn = selected;
  }

  void setPoints(int changed) {
    points = changed;
  }
  void setWager(int value) {
    wager = value;
  }
  void setCoordinates(int cardX, int cardY){
    x = cardX;
    y = cardY;
  }

  int getCoordinateX(){
    return x;
  }
  int getCoordinateY(){
    return y;
  }
  String getCoin() {
    return coin;
  }

  boolean getTurn() {
    return turn;
  }

  int getPoints() {
    return points;
  }

  int getWager() {
    return wager;
  }

  void reset()
  {
    coin = " ";
    turn = false;
  }
}