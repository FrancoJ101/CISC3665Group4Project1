  void printRules() {  // Prints the basic rules of the game to screen
    textAlign(CENTER);
    textSize(22);
    fill(255);
    text("Matching Pennies", width/2, height / 14);
    textSize(18);
    text("Both players must place a bet before picking a card.", width/2, height/8);
    text("If both cards match, Player 1 wins. Otherwise, Player 2 wins. In the chance both cards are Wildcards, a mini-game begins.", width/2, height/6);
    // Indicates which player's turn it is
    if (player1.getTurn() && !player2.getTurn()) {
      fill(255, 0, 0);
      text("Player 1's turn to pick a card", width/6, height/2+50);
    } else {
      fill(0, 0, 255);
      text("Player 2's turn to pick a card", 5*width/6, height/2+50);
    }
  }

  void printScore(Player p1, Player p2) {  // Prints the current score for each player
    fill(255, 0, 0);
    textSize(20);
    text("Player 1", width/6, height/2);
    textSize(18);
    text("Points: " + p1.getPoints(), width/6, height/2 + 25);
    fill(0, 0, 255);
    textSize(20);
    text("Player 2", 5 * width/6, height/2);
    textSize(18);
    text("Points: " + p2.getPoints(), 5 * width/6, height/2 + 25);
  }
