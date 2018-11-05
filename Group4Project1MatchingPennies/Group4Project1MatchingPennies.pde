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

color backgroundColor = color(0);             // Initializes backgroundColor to black
Card[] cards = new Card[9];                   // 9 cards to be arranged into a 3x3 grid                       
boolean gameState = true, roundState = true;  // Keeps track of both game and round states  
Player player1, player2;                      // Creates two player objects    
String playerBet = new String("");

void setup() {
  //size(800, 600);
  fullScreen();
  //background(backgroundColor);
  textSize(20);
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
  enterBet();
}

void keyPressed() {
  if (key == ' ') {
    gameReset();
  } else if (key == ENTER)
  {
    roundReset();
  }
  
  if(key == '0' || key == '1' || key == '2' || key == '3' || key == '4' ||
     key == '5' || key == '6' || key == '7' || key == '8' || key == '9'){
    playerBet = playerBet + key;
  }
  else if(key == BACKSPACE){
    if(playerBet.length() > 0){
       playerBet=playerBet.substring(0, playerBet.length()-1);
    }
  }
  
}

void mouseClicked() {
  for (int i = 0; i < cards.length; i++) {
    if (dist(mouseX, mouseY, cards[i].x, cards[i].y) < 35)
    {
      if (cards[i].getClicked() == false)
      {
        
        if (player1.turn == true && player1.getWager() != 0) { // Set wagers to 0 when there's an invalid bet
          player1.setCoin(cards[i].coin); 
          player1.turn = false;
          player2.turn = true;
          cards[i].setClicked();
        } else if(player2.turn == true && player2.getWager() != 0) {
          player2.setCoin(cards[i].coin);
          player2.turn = false;
          cards[i].setClicked();
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
  text("Both players must place a bet before picking a card.", width/2, height/8);
  text("If they're both match, Player 1 wins. If they don't match, Player 2 wins. Otherwise, it's a draw.", width/2, height/6);
  if (player1.turn && !player2.turn) {
    textAlign(CENTER);
    text("Player1's turn to pick a card", width/6, height/2+50);
  } 
  if (player2.turn && !player1.turn) {
    textAlign(CENTER);
    text("Player2's turn to pick a card", 5*width/6, height/2+50);
  }
  textAlign(CENTER);
  text("Press enter to Shuffle card.", width/2, height-75);
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
  if ( (p1.getCoin() == "heads" && p2.getCoin() == "heads") || (p1.getCoin() == "tails" && p2.getCoin() == "tails") )
  {
    //p1.setPoints(p1.getPoints() + 250);
    //p2.setPoints(p2.getPoints() - 250);
    p1.gainPoints(player1.getWager());
    p2.losePoints(player1.getWager());
    //textAlign(CENTER);
    //text("Player 1 wins this round!", width/2, height - 100);
    player1.turn=true;
    roundState = true;
    roundReset();
  } else if ( (p1.getCoin() == "heads" && p2.getCoin() == "tails") || (p1.getCoin() == "tails" && p2.getCoin() == "heads") )
  {
    //p1.setPoints(p2.getPoints() + 250);
    //p2.setPoints(p1.getPoints() - 250);
    p1.losePoints(player2.getWager());
    p2.gainPoints(player2.getWager());
    //textAlign(CENTER);
    //text("Player 2 wins this round!", width/2, height - 100);
    player1.turn=true;
    roundState = true;
    roundReset();
  } else if (p1.getCoin() != " " && p2.getCoin() != " ")
  {
    //textAlign(CENTER);
    //text("This round ended in a draw!", width/2, height - 100);
    player1.turn=true;
    roundState = true;
    roundReset();
  }
}

void enterBet(){
  if(gameState == true ){
    if(player1.points <= 50){ 
      text(" Player 1 must bet all points. ", width/6, height/2+220);
      player2.setWager(player1.getPoints());
      player1.setWager(player1.getPoints());
    }
    else if(player2.points <= 50){
      text(" Player 2 must bet all points. ", 5 * width/6, height/2+220);
      player2.setWager(player2.getPoints());
      player1.setWager(player2.getPoints());
    }
    else if(player1.turn == true){
      text(" Player one make your bet. ", width/6, height/2+200);
      if(checkBetInput() == true){
        player1.setWager(Integer.parseInt(playerBet));
      }
      else if(checkBetInput() == false){
        player1.setWager(0);
      }
      text(playerBet, width/6, height/2+250);
    }
    else if(player1.turn == false){
      text(" Player two make your bet. ", 5 * width/6, height/2+200);
      if(checkBetInput() == true){
        player2.setWager(Integer.parseInt(playerBet));
      }
      else if(checkBetInput() == false){
        player2.setWager(0); 
      }
      text(playerBet, 5 * width/6, height/2+250);
    }
    text("Player 1 bet: " + player1.getWager(), width/6, height/2+275);
    text("Player 2 bet: " + player2.getWager(), 5 * width/6, height/2+275);
  }
}

boolean checkBetInput(){ 
  if(playerBet.length() > 6 || playerBet.length() <= 0){ // Limited the bets like this because Integer.parseInt
    text("Enter a valid bet.", width/2, height/2+225);   // cannot take a number higher than 2bill or null input
    return false;
  }
  else if(playerBet.length() <= 6 && playerBet.length() > 0){ //Needed to re-check lengths for possible crash with parseInt
      if(Integer.parseInt(playerBet) > player2.points || Integer.parseInt(playerBet) > player1.points){
        text(" Players don't have enough money for this bet. ", width/2, height/2+225);
        return false;
      }
      else if(Integer.parseInt(playerBet) < 50){
        text(" You must bet a minimum of 50 points. ", width/2, height/2+225);
        return false;
      }
      else
        return true;
    }
  else 
    return true;
}

void roundReset() {
  roundState = true;
  generateCards();
  player1.setWager(0);
  player2.setWager(0);
  playerBet = "";
  player1.turn = true;
  //setup();
}

void gameReset() {
  roundReset();
  player1.setPoints(500);
  player2.setPoints(500);
  gameState = true;
  setup();
}