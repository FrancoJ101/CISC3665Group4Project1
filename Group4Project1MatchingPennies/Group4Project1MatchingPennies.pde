import java.util.Random; //<>//

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

color backgroundColor = color(0);                      // Black
Card[] cards = new Card[9];                            // 9 cards to be arranged into a 3x3 grid
//String[] values = {"wildcard", "heads", "tails"};    // Values used when generating each of the 9 cards
//int headsCount, tailsCount, wildcardCount;           // Tracks number of 'heads', 'tails', and 'wildcard' generated                           
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
  //textAlign(RIGHT);
  //text("Player 1 press 'Q' for heads or 'W' for tails", width/2 - 20, height/3 + 20);
  //textAlign(LEFT);
  //text("Player 2 press 'O' for heads or 'P' for tails", width/2 + 30, height/3 + 20);
  textAlign(CENTER);
  text("Press space to reset", width/2, height - 50);
}

void draw() {
    createGrid();
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

/*void generateCards() {
  int num = 0, wildcardCount = 0, headsCount = 0, tailsCount = 0;
  ArrayList<String> cardValues = new ArrayList();
  cardValues.add("wildcard");  // Wildcard
  cardValues.add("heads");     // Heads
  cardValues.add("tails");     // Tails
  Random random = new Random();

  for (int i = 0; i < 9; i++) {
    num = random.nextInt(cardValues.size());
    if (num == 0) {
      if (wildcardCount == 1) {
        num = random.nextInt(cardValues.size());
      } else {
        wildcardCount++;
      }
    } else if (num == 1) {
      if (headsCount == 4) {
        num = random.nextInt(cardValues.size());
      } else {
        headsCount++;
      }
    } else if (num == 2) {
      if (tailsCount == 4) {
        num = random.nextInt(cardValues.size());
      } else {
        tailsCount++;
      }
    }
    cards[i] = new Card(cardValues.get(num));
  }
}*/

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
