interface Displayable {
  void display(int type);
}

interface Moveable {
  void move();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display(int type);
}

class Rock extends Thing {
  Rock(float x, float y) {
    super(x, y);
  }

  void display(int type) {
    /* ONE PERSON WRITE THIS */
    
    if (type == 0) {
      //Simple shape
      circle(x, y, 50);
    }
    if (type == 1) {
      //Complex Shape
    }
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    /* ONE PERSON WRITE THIS */
  }
  /*
  void display(int type) {
    super.display(type);
  } */
}

class Ball extends Thing implements Moveable {
  Ball(float x, float y) {

    super(x, y);
  }

  void display(int type) {
    // type 0: make a simple circle
    if (type == 0){
      fill(100);
      ellipseMode(CENTER);
      ellipse(50, 50, 25,25); 
      
    }
    // type 1: make a football
    if (type == 1){
       fill(100);
      ellipseMode(CENTER);
      // ball silhouette
      ellipse(50, 50, 25, 60); 
      
      fill(200);
      rectMode(CENTER);
      // vertical stripe
      rect(50, 50, 5, 30); 
      // horizontal lines
      rect(50, 25, 12, 5,8); 
      rect(50, 75, 12, 5,8); 
      //eyes
      fill(255);
      ellipseMode(CENTER);
      ellipse(45,50,7,10);
      ellipse(55,50,7,10);
      fill(0);
      ellipseMode(CENTER);
      ellipse(45,50,3,3);
      ellipse(55,50,3,3);
      
    }
    if (type == 2){
    PImage img = loadImage("SoccerBall.png");
    image(img, 0,0);
    img.resize(50, 0);
    }
  }

  void move() {
    /* ONE PERSON WRITE THIS */
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
  }
}
void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display(1);
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}
