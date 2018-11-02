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
