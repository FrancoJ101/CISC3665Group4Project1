class Button {  // Button class for creating menu buttons
  color col;
  boolean isClicked, mouseOver;
  int xPos, yPos, buttonWidth, buttonHeight;
  String buttonName;

  Button(int x, int y, String txt) {  // Constructor - takes in x and y with string for button name
    col = color(255);
    isClicked = false;
    buttonWidth = 250;
    buttonHeight = 50;
    xPos = x;
    yPos = y;
    buttonName = txt;
  }

  void setup() {  // Draws button onto screen
    fill(col);
    rectMode(CENTER);
    rect(this.xPos, this.yPos, buttonWidth, buttonHeight, 20);
    fill(255, 0, 255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text(buttonName, this.xPos, this.yPos);
    mouseClicked();
  }

  void mouseClicked() {
    if (mouseX > this.xPos - buttonWidth/2 && mouseX < this.xPos + buttonWidth/2)
    {   
      if (mouseY > this.yPos - buttonHeight/2 && mouseY < this.yPos + buttonHeight/2) {
        isClicked = true;  // Potential bug
      }
    }
  }
}
