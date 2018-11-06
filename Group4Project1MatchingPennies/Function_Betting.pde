void enterBet() {
  if (player1.getPoints() <= 50) {
    fill(255, 0, 0);
    text(" Player 1 must bet all points. ", width/6, height/2+220);
    player2.setWager(player1.getPoints());
    player1.setWager(player1.getPoints());
  } else if (player2.getPoints() <= 50) {
    fill(0, 0, 255);
    text(" Player 2 must bet all points. ", 5 * width/6, height/2+220);
    player2.setWager(player2.getPoints());
    player1.setWager(player2.getPoints());
  }  

  if (player1.getTurn() == true) {
    fill(255, 0, 0);
    text(" Player 1, make your bet. ", width/6, height/2+200);
    if (checkBetInput() == true) {
      player1.setWager(Integer.parseInt(playerBet));
    } else if (checkBetInput() == false) {
      player1.setWager(0);
    }
    text(playerBet, width/6, height/2+250);
  } else if (player1.getTurn() == false) {
    fill(0, 0, 255);
    text(" Player 2, make your bet. ", 5 * width/6, height/2+200);
    if (player2.getTurn()) {
      playerBet = "";
    }
    if (checkBetInput() == true) {
      player2.setWager(Integer.parseInt(playerBet));
    } else if (checkBetInput() == false) {
      player2.setWager(0);
    }
    text(playerBet, 5 * width/6, height/2+250);
  }
  fill(255, 0, 0);
  text("Bet amount: " + player1.getWager(), width/6, height/2+275);
  fill(0, 0, 255);
  text("Bet amount: " + player2.getWager(), 5 * width/6, height/2+275);
}

boolean checkBetInput() {  // Checks whether user inputted proper betting amount
  if (playerBet.length() > 6 || playerBet.length() <= 0) { // Limited the bets like this because Integer.parseInt
    fill(255);
    text("Enter a valid bet", width/2, 13*height/16);   // Number cannot be greater than 2 billion or be a null input
    return false;
  } else if (playerBet.length() <= 6 && playerBet.length() > 0) { //Needed to re-check lengths for possible crash with parseInt
    if ((Integer.parseInt(playerBet) > player2.getPoints() && player2.getTurn() && !player1.getTurn()) || (Integer.parseInt(playerBet) > player1.getPoints() && player1.getTurn() && !player2.getTurn())) {
      text("  You do not have enough points for this bet. ", width/2, 13*height/16);
      return false;
    } else if (Integer.parseInt(playerBet) < 50) {
      text(" You must bet a minimum of 50 points. ", width/2, 13*height/16);
      return false;
    } else {
      return true;
    }
  } else { 
    return true;
  }
}
