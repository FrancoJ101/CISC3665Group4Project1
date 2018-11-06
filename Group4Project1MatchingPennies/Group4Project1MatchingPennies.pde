/* 
 CISC 3665 (Game Design, Fall '18) - Project 1
 Group 4
 Game: Matching Pennies
 Team:
 - Abdullah Gulfam
 - Ahmad Raza
 - Benjamin Kats
 - Huoliang Chen
 - Joel Franco
 */

color backgroundColor = color(0);                                         // Initializes backgroundColor to black
Card[] cards = new Card[9];                                               // 9 cards to be arranged into a 3x3 grid                       
boolean gameState = true, roundState = true, roundResultState = false;    // Keeps track of game, round and roundResult states  
Player player1, player2;                                                  // Initializes two player objects    
String playerBet = new String("");                                        // Initializes an empty string to store playerBet amount
int player2turnCheck = 0;
int OFFSET = 48;

void setup() {
  //fullScreen();
  size(2000, 1000);
  background(backgroundColor);
  textSize(18);
  player1 = new Player();
  player2 = new Player();
  generateCards();
  player1.setTurn(true);
}

void draw() {
  background(backgroundColor);
  if (gameState == true) {
    createGrid();
    printRules();
    printScore(player1, player2);
    cardSelected();
    if (player1.getPoints() == 0 || player2.getPoints() == 0) {
      gameState=false;
    }
    if (roundState == true) {
      printScore(player1, player2);
      enterBet();
      if (player1.getTurn() == false && player2.getTurn() == false) {
        roundState = false;
        roundResultState = true;
        if (player1.getPoints() == 0 || player2.getPoints() == 0) {
          gameState=false;
        }
      }
    } else {
      roundResult(player1, player2);
    }
  } else {
    clear();
    if (player1.getPoints() > player2.getPoints())
    {
      fill(255, 0, 0);
      text("Player 1 wins with " + player1.getPoints() + " points!", width/2, height/2);
    } else if (player1.getPoints() < player2.getPoints()) {
      fill(0, 0, 255);
      text("Player 2 wins with " + player2.getPoints() + " points!", width/2, height/2);
    } else {
      fill(255, 0, 255);
      text("It's a draw!", width/2, height/2);
    }
    fill(255);
    text("Press SPACE to reset game", width/2, height - 50);
  }
}

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
    playerBet += (key - 48);
  } else if (key == 45) {
    if (playerBet.length() > 0) {
      playerBet = playerBet.substring(0, playerBet.length()-1);
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
        } else if (player2.getTurn() == true && player2.getWager() != 0) {
          player2.setCoin(cards[i].getCoin());
          player2.setTurn(false);
          player2.setCoordinates(cards[i].x, cards[i].y);
          cards[i].setClicked();
        }
      }
    }
  }
}

void cardSelected() {
  if (player1.getCoordinateX() != 0) {
    noFill();
    stroke(255, 0, 0);
    rect(player1.getCoordinateX() - 30, player1.getCoordinateY() - 40, 60, 80);
  }
  if (player2.getCoordinateX() != 0) {
    noFill();
    stroke(0, 0, 255);
    rect(player2.getCoordinateX() - 30, player2.getCoordinateY() - 40, 60, 80);
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

void printRules() {  // Prints the basic rules of the game to screen
  textAlign(CENTER);
  textSize(22);
  fill(255);
  text("Matching Pennies", width/2, height/12);
  textSize(18);
  text("There are three types of cards: Heads, Tails, and Wildcard", width/2, height/7);
  text("Both players must place a bet before picking a card.", width/2, height/6);
  text("If both cards match, Player 1 wins. If both cards do not match, Player 2 wins. If Wildcard has been selected by any player, the round ends in a draw.", width/2, height/5.25);  
  text("To pick a card on your turn, first type in your bet using '0' through '9'. Use '-' to change your bet. Select a card after you have decided on your bet.", width/2, height/4.75);
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

void roundResult (Player p1, Player p2) {
  fill(255);
  text("Press ENTER to continue", width/2, height-75);
  if (roundResultState == true) {
    if ( (p1.getCoin() == "heads" && p2.getCoin() == "heads") || (p1.getCoin() == "tails" && p2.getCoin() == "tails") ) {
      p1.gainPoints();
      p2.losePoints();
      roundResultState = false;
    } else if ( (p1.getCoin() == "heads" && p2.getCoin() == "tails") || (p1.getCoin() == "tails" && p2.getCoin() == "heads") ) {
      p1.losePoints();
      p2.gainPoints();  
      roundResultState = false;
    } else if (p1.getCoin() != " " && p2.getCoin() != " ") {
      roundResultState = false;
    }
  }

  if ((p1.getCoin() == "heads" && p2.getCoin() == "heads") || (p1.getCoin() == "tails" && p2.getCoin() == "tails")) {
    fill(255, 0, 0);
    text("Player 1 wins the round!", width/2, height-100);
  } else if ((p1.getCoin() == "heads" && p2.getCoin() == "tails") || (p1.getCoin() == "tails" && p2.getCoin() == "heads")) {
    fill(0, 0, 255);
    text("Player 2 wins the round!", width/2, height-100);
  } else {
    fill(255, 0, 255);
    text("It's a draw!", width/2, height-100);
  }
}

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
      player1.setWager(parseInt(playerBet));
    } else if (checkBetInput() == false) {
      player1.setWager(0);
    }
    text(playerBet, width/6, height/2+250);
  } else if (player1.getTurn() == false) {
    fill(0, 0, 255);
    text(" Player 2, make your bet. ", 5 * width/6, height/2+200);
    if (player2turnCheck == 0) {
      playerBet = "";
      player2turnCheck++;
    }
    if (checkBetInput() == true) {
      player2.setWager(parseInt(playerBet));
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
  if (playerBet.length() > 6 || playerBet.length() <= 0) { // Limited the bets like this because parseInt
    fill(255);
    text("Enter a valid bet", width/2, 13*height/16);   // Number cannot be greater than 2 billion or be a null input
    return false;
  } else if (playerBet.length() <= 6 && playerBet.length() > 0) { //Needed to re-check lengths for possible crash with parseInt
    if ((parseInt(playerBet) > player2.getPoints() && player2.getTurn() && !player1.getTurn()) || (parseInt(playerBet) > player1.getPoints() && player1.getTurn() && !player2.getTurn())) {
      text("  You do not have enough points for this bet. ", width/2, 13*height/16);
      return false;
    } else if (parseInt(playerBet) < 50) {
      text(" You must bet a minimum of 50 points. ", width/2, 13*height/16);
      return false;
    } else {
      return true;
    }
  } else { 
    return true;
  }
}

void roundReset() {
  roundState = true;
  generateCards();
  playerBet = "";
  player1.setWager(0);
  player2.setWager(0);
  player1.setTurn(true);
  player2turnCheck = 0;
  player1.setCoordinates(0, 0);
  player2.setCoordinates(0, 0);
  //setup();
}

void gameReset() {
  roundReset();
  player1.setPoints(500);
  player2.setPoints(500);
  gameState = true;
  setup();
}
