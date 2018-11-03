class Player {
  char coin;      // Player coin face selection; "heads" or "tails" or "wildcard"
  boolean turn;   // Whether player made selection or not
  int points;

  Player() {
    coin = ' ';
    turn = false;
    points = 500;
  }

  void setCoin(char chosen) {
    coin = chosen;
  }

  void setTurn(boolean selected) {
    turn = selected;
  }

  void setPoints(int changed) {
    points = changed;
  }

  char getCoin() {
    return coin;
  }

  boolean getTurn() {
    return turn;
  }

  int getPoints() {
    return points;
  }
}
