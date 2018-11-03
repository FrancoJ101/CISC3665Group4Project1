void createGrid() { // Creates a grid based on rows and columns
  /*
   image(images[3], 2*width/6, 2*height/6);
   image(images[3], 3*width/6, 2*height/6);
   image(images[3], 4*width/6, 2*height/6);
   image(images[3], 2*width/6, 3*height/6);
   image(images[3], 3*width/6, 3*height/6);
   image(images[3], 4*width/6, 3*height/6);
   image(images[3], 2*width/6, 4*height/6);
   image(images[3], 3*width/6, 4*height/6);
   image(images[3], 4*width/6, 4*height/6);
   */
  int num = 0;
  for (int i = 2; i <= 4; i++) {  // Rows
    for (int j = 2; j <= 4; j++) {  // Columns
      image(cards[num].getImage(), i*width/6, j*height/6);
      num++;
    }
  }
}
