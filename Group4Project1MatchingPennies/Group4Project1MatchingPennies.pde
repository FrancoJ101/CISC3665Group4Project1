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
<<<<<<< HEAD
color backgroundColor = color(0);                    // Black
int w = width, h = height;                           // Width and Height
Card[] cards = new Card[9];                          // 9 cards to be arranged into a 3x3 grid
String[] values = {"heads", "tails", "wildcard"};    // Values used when generating each of the 9 cards
int headsCount = 0;                                  // Tracks number of 'heads' cards generated
int tailsCount = 0;                                  // Tracks number of 'tails' cards generated
int wildcardCount = 0;                               // Tracks number of 'wildcard' cards generated
boolean gameState = false;
Player player1;
Player player2;
=======

color backgroundColor = color(0);  // Black
int w = width, h = height;  // Width and Height
PImage[] images = new PImage[4];  // 0 - heads, 1 - tails, 2 - draw, 3 - card
boolean gameState = false;  // Initializes game state 
Player player1, player2;  // Creates two player objects
>>>>>>> a5aa32a95da89d4dd9e5f362d8fd337e1a5b7c78

void setup() {
  size(800, 650);
  background(backgroundColor);

<<<<<<< HEAD
  generateCards();
=======
  for (int i=0; i < images.length; i++) {  // Loads images into array
    imageMode(CENTER);
    images[i] = loadImage( i + ".png");
    images[i].resize(100, 100);
  }
>>>>>>> a5aa32a95da89d4dd9e5f362d8fd337e1a5b7c78

  player1 = new Player();
  player2 = new Player();

  createGrid();
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
}

void keyPressed() {
  if (key == ' ') {
    reset();
  }
}

void generateCards() {
  int num = 0;
  for (int i = 0; i < 9; i++) {
    num = (int) random(0,3);
    cards[i] = new Card(values[num]);
  }
}

void reset() {
  setup();
}
