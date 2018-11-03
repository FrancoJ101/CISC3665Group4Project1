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

color backgroundColor = color(0);  // Initializes backgroundColor to black
Card[] cards = new Card[9];        // 9 cards to be arranged into a 3x3 grid                       
boolean gameState = false;  
Player player1, player2;                             

void setup() {
  size(800, 600);
  background(backgroundColor);

  generateCards();
  player1 = new Player();
  player2 = new Player();

  textAlign(CENTER);
  text("Both players have a penny and choose either heads or tails.", width/2, height/8);
  text("If they match, Player 1 wins. If not, Player 2 wins.", width/2, height/6);
  textAlign(CENTER);
  text("Press space to reset", width/2, height - 50);
}

void draw() {
  if (gameState == true)
  {
    createGrid();
  } else {                                  // End game result gets printed to screen
    if (player1.points > player2.points)
    {
      textAlign(CENTER);
      text("Player 1 Wins!", width/2, height/2);
    }
    if (player1.points < player2.points)
    {
      textAlign(CENTER);
      text("Player 2 Wins!", width/2, height/2);
    } else
    {
      textAlign(CENTER);
      text("It's a draw!", width/2, height/2);
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    reset();
  }
}

void mouseClicked() {
  for (int i = 0; i < cards.length; i++) {
    if (dist(mouseX, mouseY, cards[i].x, cards[i].y) < 35)
      cards[i].setClicked();
  }
}

void reset() {
  //gameState = false;
  setup();
}

void generateCards() {
  int num = 0, wildcardCount = 0, headsCount = 0, tailsCount = 0, totalCount = 0;
  String[] cardValues = {"wildcard","heads","tails"};
  
  while (totalCount < 9) {
    num = (int) random(0,3);
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
