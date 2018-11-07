// Grid Function //
void createGrid() { // Creates a grid based on rows and columns
  int num = 0;
  for (int i = 2; i <= 4; i++) {                             // Rows
    for (int j = 2; j <= 4; j++) {                           // Columns
      cards[num].x = i*width/6;                              // Set X-coord of card
      cards[num].y = j*height/6;      // Set Y-coord of card
      image(cards[num].getImage(), i*width/6, j*height/6);   // Display cardsgetCLlickee}
      num++;
    }
  }
}

// User Input Functions //
void keyPressed() {
  if (key == ' ') {
    if (gameState == false) {
      gameReset();
    }
  } else if (key == ENTER) {
    if (roundState == false) {  // Allows advancement to next round only if current round is over
      roundReset();
    }
  } else if (key == 'i' || key == 'I') {
    instructionState = !instructionState;
  } else if (key == '0' || key == '1' || key == '2' || key == '3' || key == '4' ||
    key == '5' || key == '6' || key == '7' || key == '8' || key == '9') {
    if (!instructionState) {
      playerBet += (key - 48);
    }
  } else if (key == 45 || key == BACKSPACE) {
    if (playerBet.length() > 0 && !instructionState) {
      playerBet = playerBet.substring(0, playerBet.length()-1);
    }
  }
}

void mouseClicked() {
  for (int i = 0; i < cards.length; i++) {  // Assigns a card's value to the player who clicks on it
    if (dist(mouseX, mouseY, cards[i].x, cards[i].y) < 35) {
      if (cards[i].getClicked() == false) {
        if (player1.turn == true && player1.wager != 0) { // Bets are set to 0 when there's an invalid bet
          flip.play();
          player1.coin = (cards[i].coin); 
          player1.turn = false;
          player1.x = cards[i].x;
          player1.y = cards[i].y;
          player2.turn = true;
          cards[i].setClicked();
        } else if (player2.turn == true && player2.wager != 0) {
          flip.play();
          player2.coin = cards[i].coin;
          player2.turn = false;
          player2.x = cards[i].x;
          player2.y = cards[i].y;          
          cards[i].setClicked();
        }
      }
    }
  }
}

// Card Functions //
void cardSelected() {
  if (player1.x != 0) {
    noFill();
    stroke(255, 0, 0);
    rect(player1.x - 30, player1.y - 40, 60, 80);
  }
  if (player2.x != 0) {
    noFill();
    stroke(46, 177, 255);
    rect(player2.x - 30, player2.y - 40, 60, 80);
  }
}

void generateCards() {  // Generates the cards array with randomly sorted cards
  int num = 0, wildcardCount = 0, headsCount = 0, tailsCount = 0, totalCount = 0;
  String[] cardValues = {"wildcard", "heads", "tails"};

  while (totalCount < 9) {
    num = (int) random(0, 3);
    if (num == 0) {
      if (wildcardCount < 1) {
        cards[totalCount] = new Card(cardValues[num]);
        wildcardCount++;
        totalCount++;
      }
    } else if (num == 1) {
      if (headsCount < 4) {
        cards[totalCount] = new Card(cardValues[num]);
        headsCount++;
        totalCount++;
      }
    } else if (num == 2) {
      if (tailsCount < 4) {
        cards[totalCount] = new Card(cardValues[num]);
        tailsCount++;
        totalCount++;
      }
    }
  }
}

// Print Functions //
void printRules() {  // Prints the basic rules of the game to screen
  textSize(32);
  text("Instructions:", width/2, width/8);
  text("There are three types of cards: Heads, Tails, and Wildcard.", width/2, height/4 + 50);
  text("Both players must place a bet before picking a card.", width/2, height/4 + 100);
  text("If both cards match, Player 1 wins. If both cards do not match, Player 2 wins.", width/2, height/4 + 150);
  text("If Wildcard has been selected by any player, the round ends in a draw.", width/2, height/4 + 200);
  text("To pick a card on your turn, first type in your bet using '0' through '9'. Use '-' or BACKSPACE to change your bet.", width/2, height/4 + 250);
  text("Select a card after you have decided on your bet.", width/2, height/4 + 300);
  text("Press 'I' to go back to the game", width/2, 3 * height/4);
}

void printScore(Player p1, Player p2) {  // Prints the current score for each player
  fill(255, 0, 0);
  textSize(20);
  text("Player 1", width/6, height/2);
  textSize(18);
  text("Points: " + p1.points, width/6, height/2 + 25);
  fill(46, 177, 255);
  textSize(20);
  text("Player 2", 5 * width/6, height/2);
  textSize(18);
  text("Points: " + p2.points, 5 * width/6, height/2 + 25);
}

void roundResult (Player p1, Player p2) {
  fill(255);
  text("Press ENTER to continue", width/2, height-75);
  if (roundResultState == true) {
    if ( (p1.coin == "heads" && p2.coin == "heads") || (p1.coin == "tails" && p2.coin == "tails") ) {
      p1.gainPoints();
      p2.losePoints();
      chaching.play();
      roundResultState = false;
    } else if ( (p1.coin == "heads" && p2.coin == "tails") || (p1.coin == "tails" && p2.coin == "heads") ) {
      p1.losePoints();
      p2.gainPoints();  
      chaching.play();
      roundResultState = false;
    } else if (p1.coin != " " && p2.coin != " ") {
      roundResultState = false;
    }
  }

  if ((p1.coin == "heads" && p2.coin == "heads") || (p1.coin == "tails" && p2.coin == "tails")) {
    fill(255, 0, 0);
    text("Player 1 wins the round!", width/2, height-100);
  } else if ((p1.coin == "heads" && p2.coin == "tails") || (p1.coin == "tails" && p2.coin == "heads")) {
    fill(46, 177, 255);
    text("Player 2 wins the round!", width/2, height-100);
  } else {
    fill(255, 0, 255);
    text("It's a draw!", width/2, height-100);
  }
}

// Bet Functions //
void enterBet() {
  if (player1.points <= 50) {
    player1.wager = player1.points;
  } else if (player2.points <= 50) {
    player2.wager = player2.points;
  }  
  if (player1.turn) {
    fill(255, 0, 0);
    text(" Player 1, make your bet. ", width/6, height/2+200);
    if (checkBetInput() == true) {
      player1.wager = parseInt(playerBet);
    } else if (checkBetInput() == false) {
      player1.wager = 0;
    }
    text(playerBet, width/2, 7*height/8);
  } else if (!player1.turn) {
    fill(46, 177, 255);
    text(" Player 2, make your bet. ", 5 * width/6, height/2+200);
    if (player2turnCheck == 0) {
      playerBet = "";
      player2turnCheck++;
    }
    if (checkBetInput() == true) {
      player2.wager = parseInt(playerBet);
    } else if (checkBetInput() == false) {
      player2.wager = 0;
    }
    text(playerBet, width/2, 7*height/8);
  }
  fill(255, 0, 0);
  text("Bet amount: " + player1.wager, width/6, height/2+275);
  fill(46, 177, 255);
  text("Bet amount: " + player2.wager, 5 * width/6, height/2+275);
  fill(255);
  //text(playerBet, width/2, 7*height/8);
}

boolean checkBetInput() {  // Checks whether user inputted proper betting amount }
  if (playerBet.length() == 0) { // Limited the bets like this because parseI
    if (player1.turn) {
      text("Enter a valid bet, Player 1.", width/2, 13*height/16);
    } else if (player2.turn) {
      text("Enter a valid bet, Player 2.", width/2, 13*height/16);
    }
    return false;
  } else {
    if ((parseInt(playerBet) > player2.points && player2.turn && !player1.turn) || (parseInt(playerBet) > player1.points && player1.turn && !player2.turn)) {
      text("  You do not have enough points for this bet. ", width/2, 13*height/16);
      return false;
    } else if (parseInt(playerBet) < 50 && (player1.points >= 50 && player1.turn || player2.points >= 50 && player2.turn)) {
      text(" You must bet a minimum of 50 points. ", width/2, 13*height/16);
      return false;
    } else {
      if (player1.turn) {
        text("Enter a valid bet, Player 1.", width/2, 13*height/16);
      } else if (player2.turn) {
        text("Enter a valid bet, Player 2.", width/2, 13*height/16);
      }
      return true;
    }
  }
}

void roundReset() {
  roundState = true;
  generateCards();
  playerBet = "";
  player1.wager = 0;
  player2.wager = 0;
  player1.turn = true;
  player2turnCheck = 0;
  player1.x = 0;
  player1.y = 0;
  player2.x = 0;
  player2.y = 0;
}

void gameReset() {
  roundReset();
  player1.points = 500;
  player2.points = 500;
  gameState = true;
  music.pause();
  setup();
}
