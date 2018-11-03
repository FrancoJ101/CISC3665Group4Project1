class Card {
  String coin;
  boolean clicked;
  PImage cardImage;
  PImage cardImageFlipped;

  Card(String value) {
    coin = value;
    clicked = false;
    imageMode(CENTER);
    cardImage = loadImage( "default.png" );
    cardImage.resize(100, 100);
    cardImageFlipped = loadImage(value + ".png");
    cardImageFlipped.resize(100, 100);
  }

  void setClicked() { 
    clicked = true;
  }

  PImage getImage() {
    if (clicked == false) {
      return cardImage;
    } else {    
      return cardImageFlipped;
    }
  }
}
