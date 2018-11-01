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
color backgroundColor = color(0);  // Black
PImage heads, tails;
Player player1;
Player player2;

void setup() {
  size(800, 650);
  background(backgroundColor);

  heads = loadImage("heads.png");  
  imageMode(CENTER);
  //image(heads, width/4, height/2);
  tails = loadImage("tails.png");
  //image(tails, width - width/4, height/2);

  player1 = new Player();
  player2 = new Player();

  textAlign(CENTER);
  text("Both players have a penny and choose either heads or tails.", width/2, height/5);
  text("If they match, Player 1 wins. If not, Player 2 wins.", width/2, height/4);
  //ellipse(width/4, height/2, 100, 100);
  //ellipse(width - width/4, height/2, 100, 100);
  textAlign(RIGHT);
  text("Player 1 press 'Q' for heads or 'W' for tails", width/2 - 20, height/3 + 20);
  textAlign(LEFT);
  text("Player 2 press 'O' for heads or 'P' for tails", width/2 + 30, height/3 + 20);
  textAlign(CENTER);
  text("Press space to reset", width/2, height - 50);
}

void draw() {
  if (player1.getTurn() && player2.getTurn()) {
    if (player1.getCoin().equalsIgnoreCase(player2.getCoin())) {
      if (player1.getCoin().equalsIgnoreCase("heads")) {
        image(heads, width/4, height/2);
        image(heads, width - width/4, height/2);
        text("Heads", width/4, height - height/3);
        text("Heads", width - width/4, height - height/3);
      } else {
        image(tails, width/4, height/2);
        image(tails, width - width/4, height/2);
        text("Tails", width/4, height - height/3);
        text("Tails", width - width/4, height - height/3);
      }
      text("The pennies match. Player 1 wins!", width/2, height - 150);
    } else {
      if (player1.getCoin().equalsIgnoreCase("heads")) {
        image(heads, width/4, height/2);
        image(tails, width - width/4, height/2);
        text("Heads", width/4, height - height/3);
        text("Tails", width - width/4, height - height/3);
      } else {
        image(tails, width/4, height/2);
        image(heads, width - width/4, height/2);
        text("Tails", width/4, height - height/3);
        text("Heads", width - width/4, height - height/3);
      }
      text("The pennies do not match. Player 2 wins!", width/2, height - 150);
    }
  }
}

void keyPressed() {
  if (key == 'Q' || key == 'q' && !player1.getTurn()) {
    player1.setCoin("heads");
    player1.setTurn(true);
  }

  if (key == 'W' || key == 'w' && !player1.getTurn()) {
    player1.setCoin("tails");
    player1.setTurn(true);
  }

  if (key == 'O' || key == 'o' && !player2.getTurn()) {
    player2.setCoin("heads");
    player2.setTurn(true);
  }

  if (key == 'P' || key == 'p' && !player2.getTurn()) {
    player2.setCoin("tails");
    player2.setTurn(true);
  }

  if (key == ' ') {
    reset();
  }
}

void reset() {
  setup();
}

void createGrid(int rows, int columns) { // Creates a grid based on rows and columns 
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; i < columns; j++)
    {
    }
  }
}

class Player {
  String coin;
  boolean turn;

  Player() {
    coin = " ";
    turn = false;
  }

  void setCoin(String chosen) {
    coin = chosen;
  }

  void setTurn(boolean selected) {
    turn = selected;
  }

  String getCoin() {
    return coin;
  }

  boolean getTurn() {
    return turn;
  }
}
