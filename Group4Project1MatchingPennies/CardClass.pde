class Card {
  String coin;
  boolean clicked;
  PImage cardImage;
  PImage cardImageFlipped;
  int x, y;
  
  Card(String value) {
    coin = value;
    clicked = false;
    imageMode(CENTER);
    cardImage = loadImage( "default.png" );
    cardImage.resize(80, 80);
    cardImageFlipped = loadImage(value + ".png");
    cardImageFlipped.resize(80, 80);
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
