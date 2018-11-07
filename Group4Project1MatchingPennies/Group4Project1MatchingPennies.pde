/* @pjs preload="default.png, heads.png, tails.png, wildcard.png"; */

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


import processing.sound.*;
SoundFile music, flip, chaching;

color backgroundColor = color(0);                   // Initializes backgroundColor to black
Card[] cards = new Card[9];                         // 9 cards to be arranged into a 3x3 grid                       
boolean gameState, roundState, roundResultState, instructionState;    // Keeps track of game, round and roundResult states  
Player player1, player2;                            // Initializes two player objects    
String playerBet = new String("");                  // Initializes an empty string to store playerBet amount
int player2turnCheck = 0;

void setup() {
  fullScreen();
  background(backgroundColor);
  textSize(18);
  player1 = new Player();
  player2 = new Player();
  generateCards();
  gameState = true;
  roundState = true;
  roundResultState = false;
  instructionState = false;
  player1.turn = true;
  // Music + Sounds
  music = new SoundFile(this, "jazz.mp3");
  flip = new SoundFile(this, "flip.mp3");
  chaching = new SoundFile(this, "chaching.mp3");
  music.loop(1, 0.1);
}

void draw() {
  background(backgroundColor);
  if (gameState) {  // Initialize game
    createGrid();
    printScore(player1, player2);
    fill(255);
    textAlign(CENTER);
    textSize(72);
    text("Matching Pennies", width/2, height/8);
    textSize(24);
    text("Press 'I' to view instructions.", width/2, height/8 + 100);
    cardSelected();
    if (player1.points == 0 || player2.points == 0) {  // If a player's points hit 0, end the game
      gameState=false;
    }
    if (roundState) {  // Setup round config
      if (instructionState) {
        clear();
        printRules();
      } else {
        printScore(player1, player2);
        enterBet();
        if (player1.turn == false && player2.turn == false) {
          roundState = false;
          roundResultState = true;
          if (player1.points == 0 || player2.points == 0) {
            gameState=false;
          }
        }
      }
    } else {  // Print results of round
      roundResult(player1, player2);
    }
  } else {  // Display end game results
    clear();
    if (player1.points > player2.points)
    {
      fill(255, 0, 0);
      text("Player 1 wins with " + player1.points + " points!", width/2, height/2);
    } else if (player1.points < player2.points) {
      fill(46, 177, 255);
      text("Player 2 wins with " + player2.points + " points!", width/2, height/2);
    } else {
      fill(255, 0, 255);
      text("It's a draw!", width/2, height/2);
    }
    fill(255);
    text("Press SPACE to reset game.", width/2, height - 50);
  }
}
