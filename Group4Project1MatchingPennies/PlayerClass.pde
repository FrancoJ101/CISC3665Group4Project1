class Player {
  String coin;
  boolean turn;

  Player() {
    coin = " ";
    turn = false;
  }

  void setCoin(String chosen) {
    coin = chosen;
  }

  void setTurn(boolean selected) {
    turn = selected;
  }

  String getCoin() {
    return coin;
  }

  boolean getTurn() {
    return turn;
  }
}
