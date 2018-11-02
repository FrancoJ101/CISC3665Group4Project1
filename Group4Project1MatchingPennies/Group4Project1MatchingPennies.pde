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
  size(600, 600);
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
    if (player1.getCoin() == player2.getCoin()) {
      if (player1.getCoin() == 'h') {
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
      if (player1.getCoin() == 'h') {
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
    player1.setCoin('h');
    player1.setTurn(true);
  }

  if (key == 'W' || key == 'w' && !player1.getTurn()) {
    player1.setCoin('t');
    player1.setTurn(true);
  }

  if (key == 'O' || key == 'o' && !player2.getTurn()) {
    player2.setCoin('h');
    player2.setTurn(true);
  }

  if (key == 'P' || key == 'p' && !player2.getTurn()) {
    player2.setCoin('t');
    player2.setTurn(true);
  }

  if (key == ' ') {
    reset();
  }
}

void reset() {
  setup();
}

class Player {
  char coin;    //Player coin face selection; "heads" or "tails"
  boolean turn;   //Whether player made selection or not
  int points;
  
  Player() {
    coin = ' ';
    turn = false;
    points = 500;
  }
  
  void setCoin(char chosen) {
    coin = chosen;
  }
  
  void setTurn(boolean selected) {
    turn = selected;
  }
  
  void setPoints(int changed) {
    points = changed;
  }
  
  char getCoin() {
    return coin;
  }
  
  boolean getTurn() {
    return turn;
  }
  
  int getPoints() {
    return points;
  }
}

class Card {
  char coin;
  boolean clicked;
  PImage cardImage;
  PImage cardImageFlipped;
  
  Card(char value) {
    coin = value;
    clicked = false;
    //assign card image to cardImage
    
    if (coin == 'h') {
      //assign heads image to cardImageFlipped
    } else if (coin == 't') {
      //assign tails image to cardImageFlipped
    } else {
      //assign wildcard image to cardImageFlipped
    }
  }
  
  void setClicked() { 
    clicked = true;
  }
 
  PImage getImage() {
    return cardImage;
  }
  
  PImage getImageFlipped() {
    return cardImageFlipped;
  }
}
