/* @pjs preload="jazz.mp3, chaching.mp3"; */
import processing.sound.*;
SoundFile music, flip, chaching;

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
boolean pregameState, // Keeps track of game, round and roundResult states                             
  gameState = false, 
  roundState = false, 
  roundResultState = false;    
Player player1, player2;                                                  // Initializes two player objects    
String playerBet = new String("");                                        // Initializes an empty string to store playerBet amount
int player2turnCheck = 0;

void setup() {
  //fullScreen();
  size(displayWidth, displayHeight);
  background(backgroundColor);
  textSize(18);
  player1 = new Player();
  player2 = new Player();
  pregameState = true;
  generateCards();
  //player1.setTurn(true);

  music = new SoundFile(this, "jazz.mp3");
  flip = new SoundFile(this, "flip.mp3");
  chaching = new SoundFile(this, "chaching.mp3");
  music.loop(1, 0.1);
}

void draw() {
  background(backgroundColor);
  if  (pregameState == true) {
    showMenu();
  } else {
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
      chaching.play();
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


  void showMenu() {
    text("Matching 'Pennies'", width/2, height/4);
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
    // gameState = true;
    music.stop();
    setup();
  }
