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
int player1 = 0;  // Player 1 coin choice
int player2 = 0;  // Player 2 coin choice
boolean p1Selection = false;  // Player 1's turn end
boolean p2Selection = false;  // Player 2's turn end
color backgroundColor = color(0);  // Black
PImage heads, tails;

void setup() {
  size(600, 600);
  background(backgroundColor);

  heads = loadImage("heads.png");  
  imageMode(CENTER);
  //image(heads, width/4, height/2);
  tails = loadImage("tails.png");
  //image(tails, width - width/4, height/2);

  textAlign(CENTER);
  text("Both players have a penny and choose either heads or tails.", width/2, height/5);
  text("If they match, Player 1 wins. If not, Player 2 wins.", width/2, height/4);
  //ellipse(width/4, height/2, 100, 100);
  //ellipse(width - width/4, height/2, 100, 100);
  textAlign(RIGHT);
  text("Player 1 press 'Q' for heads and 'W' for tails", width/2 - 20, height/3 + 20);
  textAlign(LEFT);
  text("Player 2 press 'O' for heads and 'P' for tails", width/2 + 30, height/3 + 20);
  textAlign(CENTER);
  text("Press space to reset", width/2, height - 50);
}

void draw() {
  if (p1Selection && p2Selection) {
    if (player1 == player2 ) {
      if (player1 == 1 && player2 == 1) {
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
      if (player1 == 1 && player2 == 2) {
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
  if (key == 'Q' || key == 'q' && p1Selection == false) {
    player1 = 1;
    p1Selection = true;
  }

  if (key == 'W' || key == 'w' && p1Selection == false) {
    player1 = 2;
    p1Selection = true;
  }

  if (key == 'O' || key == 'o' && p2Selection == false) {
    player2 = 1;
    p2Selection = true;
  }

  if (key == 'P' || key == 'p' && p2Selection == false) {
    player2 = 2;
    p2Selection = true;
  }

  if (key == ' ') {
    reset();
  }
}

void reset() {
  player1 = 0;
  player2 = 0;
  p1Selection = false;
  p2Selection = false;
  setup();
}
