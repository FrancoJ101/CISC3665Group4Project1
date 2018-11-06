void keyPressed() {
  if (key == ' ') {
    if (gameState == false) {
      gameReset();
    }
  } else if (key == ENTER) {
    if (roundState == false) {  // Allows advancement to next round only if current round is over
      roundReset();
    }
  } else if (key == '0' || key == '1' || key == '2' || key == '3' || key == '4' ||
    key == '5' || key == '6' || key == '7' || key == '8' || key == '9') {
    playerBet = playerBet + key;
  } else if (key == BACKSPACE) {
    if (playerBet.length() > 0) {
      playerBet=playerBet.substring(0, playerBet.length()-1);
    }
  } else if (key == 'm' || key == 'M') {
    if (pregameState) {
      if (musicToggle) {
        music.pause();
      } else {
        //music.pause();
        music.loop(1, 0.1);
      }
    }
  }
}

void mouseClicked() {
  for (int i = 0; i < cards.length; i++) {  // Assigns a card's value to the player who clicks on it
    if (dist(mouseX, mouseY, cards[i].x, cards[i].y) < 35) {
      if (cards[i].getClicked() == false) {
        if (player1.getTurn() == true && player1.getWager() != 0) { // Bets are set to 0 when there's an invalid bet
          player1.setCoin(cards[i].getCoin()); 
          player1.setTurn(false);
          player1.setCoordinates(cards[i].x, cards[i].y);
          player2.setTurn(true);
          cards[i].setClicked();
          flip.play();
        } else if (player2.getTurn() == true && player2.getWager() != 0) {
          player2.setCoin(cards[i].getCoin());
          player2.setTurn(false);
          player2.setCoordinates(cards[i].x, cards[i].y);
          cards[i].setClicked();
          flip.play();
        }
      }
    }
  }
}
