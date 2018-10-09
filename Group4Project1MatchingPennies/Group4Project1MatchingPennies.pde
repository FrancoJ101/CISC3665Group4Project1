// CISC 3665 Game Design Group Project 1 Fall 2018
// Matching Pennies Group 4
// Huoliang Chen
// Joel Franco
// Abdullah Gulfam
// Benjamin Kats
// Ahmad Raza
int player1 = 0;
int player2 = 0;
boolean p1Selection = false;
boolean p2Selection = false;

void setup(){
  size(600,600);
  background(#000000);
  text("Both players have a penny and choose heads or tails. If they match, Player 1 wins. If not, Player 2 wins", 10,50);
  ellipse(150,300,100,100);
  ellipse(450,300,100,100);
  text("Player 1 press 'Q' for heads and 'W' for tails", 50, 150);
  text("Player 2 press 'O' for heads and 'P' for tails",350, 150);
  text("Press 0 to reset", 225,550);
}

void draw(){
   if (p1Selection && p2Selection){
    if(player1 == player2 ){
      fill(#000000);
      if(player1 == 1 && player2 == 1){
        text("Heads", 150,300);
        text("Heads", 450,300);
      }
      else{
        text("Tails", 150,300);
        text("Tails", 450,300);
      }
      fill(#FFFFFF);
      text("The pennies match. Player 1 wins",100,500);
    }
    
    else{
      fill(#000000);
      if(player1 == 1 && player2 == 2){
        text("Heads", 150,300);
        text("Tails", 450,300);
      }
      else{
        text("Tails", 150,300);
        text("Heads", 450,300);
      }
      fill(#FFFFFF);
      text("The pennies do not match. Player 2 wins", 100, 500);
    }
  }
}

void keyPressed(){
  if(key == 'Q' || key == 'q' && p1Selection == false){
    player1 = 1;
    p1Selection = true;
  }
  
  if(key == 'W' || key == 'w' && p1Selection == false){
    player1 = 2;
    p1Selection = true;
  }
  
  if(key == 'O' || key == 'o' && p2Selection == false){
    player2 = 1;
    p2Selection = true;
  }
  
  if(key == 'P' || key == 'p' && p2Selection == false){
    player2 = 2;
    p2Selection = true;
  }
  
  if(key == '0'){
    reset();
  }
}

void reset(){
  player1 = 0;
  player2 = 0;
  p1Selection = false;
  p2Selection = false;
  background(#000000);
  text("Both players have a penny and choose heads or tails. If they match, Player 1 wins. If not, Player 2 wins", 10,50);
  ellipse(150,300,100,100);
  ellipse(450,300,100,100);
  text("Player 1 press 'Q' for heads and 'W' for tails", 50, 150);
  text("Player 2 press 'O' for heads and 'P' for tails",350, 150);
  text("Press 0 to reset", 225,550);
}
