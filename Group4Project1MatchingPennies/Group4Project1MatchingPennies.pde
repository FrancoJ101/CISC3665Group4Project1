/*  //<>//
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

color backgroundColor = color(0);             // Initializes backgroundColor to black
Card[] cards = new Card[9];                   // 9 cards to be arranged into a 3x3 grid                       
boolean gameState = true, roundState = true;  // Keeps track of both game and round states  
Player player1, player2;                      // Creates two player objects                             

void setup() {
  size(800, 600);
  //fullScreen();
  //background(backgroundColor);
  player1 = new Player();  
  player2 = new Player();
  generateCards();
  //printRules();
  //printScore(player1, player2);
  player1.turn = true;
}

void draw() {
  background(backgroundColor);
  printRules();
  if (gameState == true) {
    if (player1.getPoints() == 0 || player2.getPoints() == 0) {
      gameState=false;
    }
    if (roundState == true) {
      createGrid();
      printScore(player1, player2);
      if (player1.turn == false && player2.turn == false) {
        roundState = false;
        if (player1.getPoints() == 0 || player2.getPoints() == 0) {
          gameState=false;
        }
      }
    } else {
      roundResult(player1, player2);
      printScore(player1, player2);
      //textAlign(CENTER);
      //text("Press ENTER to continue", width/2, height - 75);
    }
  } else {
    clear();
    if (player1.points > player2.points)
    {
      textAlign(CENTER);
      text("Player 1 Wins with " + player1.points + " points!", width/2, height/2);
    } else if (player1.points < player2.points)
    {
      textAlign(CENTER);
      text("Player 2 Wins with " + player2.points + " points!", width/2, height/2);
    } else
    {
      textAlign(CENTER);
      text("It's a draw!", width/2, height/2);
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    gameReset();
  } else if (key == ENTER)
  {
    roundReset();
  }
}

void mouseClicked() {
  for (int i = 0; i < cards.length; i++) {
    if (dist(mouseX, mouseY, cards[i].x, cards[i].y) < 35)
    {
      if (cards[i].getClicked() == false)
      {
        cards[i].setClicked();
        if (player1.turn == true) {
          player1.setCoin(cards[i].coin);
          player1.turn = false;
          player2.turn = true;
        } else {
          player2.setCoin(cards[i].coin);
          player2.turn = false;
        }
      }
    }
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

void printRules() {  // Prints basic rules of the game to screen
  textAlign(CENTER);
  text("Both players have a penny and choose either heads or tails.", width/2, height/8);
  text("If they're both heads, Player 1 wins. If they're both tails, Player 2 wins. Otherwise, it's a draw.", width/2, height/6);
  textAlign(CENTER);
  text("Press space to reset", width/2, height - 50);
}

void printScore(Player p1, Player p2) {
  textAlign(CENTER);
  text("Player 1", width/6, height/2);
  text("Points: " + p1.getPoints(), width/6, height/2 + 25);
  textAlign(CENTER);
  text("Player 2", 5 * width/6, height/2);
  text("Points: " + p2.getPoints(), 5 * width/6, height/2 + 25);
}

void roundResult (Player p1, Player p2) {
  if ((p1.getCoin() == "heads" && p2.getCoin() == "heads")||(p1.getCoin() == "tails" && p2.getCoin() == "tails"))
  {
    //p1.setPoints(p1.getPoints() + 250);
    //p2.setPoints(p2.getPoints() - 250);
    p1.gainPoints(250);
    p2.losePoints(250);
    //textAlign(CENTER);
    //text("Player 1 wins this round!", width/2, height - 100);
    player1.turn=true;
    roundState = true;
  } else if ((p1.getCoin() == "heads" && p2.getCoin() == "tails")||(p1.getCoin() == "tails" && p2.getCoin() == "heads"))
  {
    //p1.setPoints(p2.getPoints() + 250);
    //p2.setPoints(p1.getPoints() - 250);
    p1.losePoints(250);
    p2.gainPoints(250);
    //textAlign(CENTER);
    //text("Player 2 wins this round!", width/2, height - 100);
    player1.turn=true;
    roundState = true;
  } else if (p1.getCoin() != " " && p2.getCoin() != " ")
  {
    //textAlign(CENTER);
    //text("This round ended in a draw!", width/2, height - 100);
    player1.turn=true;
    roundState = true;
  }
}

void roundReset() {
  player1.reset();
  player2.reset();
  roundState = true;
  setup();
}

void gameReset() {
  roundReset();
  player1.setPoints(500);
  player2.setPoints(500);
  gameState = true;
  setup();
}
