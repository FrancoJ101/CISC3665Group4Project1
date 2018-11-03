void createGrid() { // Creates a grid based on rows and columns
  int num = 0;
  for (int i = 2; i <= 4; i++) {                             // Rows
    for (int j = 2; j <= 4; j++) {                           // Columns
      cards[num].x = i*width/6;                              // Set X-coord of card
      cards[num].y = j*height/6;                             // Set Y-coord of card
      image(cards[num].getImage(), i*width/6, j*height/6);   // Display cards
      num++;
    }
  }
}
