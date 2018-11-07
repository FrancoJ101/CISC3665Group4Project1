class Player {
  String coin;      // Player coin face selection; "heads" or "tails" or "wildcard"
  boolean turn;   // Whether player made selection or not
  int points;
  int wager;
  int x, y;
  Player() {
    coin = " ";
    turn = false;
    points = 500;
  }

  void losePoints() {
    points-=wager;
  }

  void gainPoints() {
    points+=wager;
  }

  void reset()
  {
    coin = " ";
    turn = false;
  }
}
