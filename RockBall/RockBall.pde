import java.util.*;

interface Displayable {
  void display();
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
  abstract void display();
}

class Rock extends Thing {
  Rock(float x, float y) {
    super(x, y);
  }

   void display() {
    /* ONE PERSON WRITE THIS */
    
   /* if (type == 0) {
      //Simple shape
      circle(x, y, 50);
    }
    if (type == 1) {
      //Complex Shape
    }*/
  }
}


public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    /* ONE PERSON WRITE THIS */
  }
  
  void display() {
    super.display();
  } 
}

class Ball extends Thing implements Moveable {
  Ball(float x, float y) {

    super(x, y);
    
  }

  Random rand = new Random();
  int type = Math.abs(rand.nextInt() % 3);
  
  void display() {
    System.out.println(type);
    // type 0: make a simple circle
    if (type == 0){
      fill(100);
      ellipseMode(CENTER);
      ellipse(x, y, 50,50); 
      
    }
    // type 1: make a football
    if (type == 1){
       fill(100);
      ellipseMode(CENTER);
      // ball silhouette
      ellipse(x, y, 25, 50); 
      
      fill(200);
      rectMode(CENTER);
      // vertical stripe
      rect(x, y, 5, 20); 
      
      // horizontal lines
      rect(x, y - 20, 12, 5,8); 
      rect(x, y + 20, 12, 5,8); 
      
      //eyes
      fill(255);
      ellipseMode(CENTER);
      ellipse(x - 5,y,7,10);
      ellipse(x + 5,y,7,10);
      fill(0);
      ellipseMode(CENTER);
      ellipse(x - 5,y,3,3);
      ellipse(x + 5,y,3,3);
      
    }
    // type 2: soccer ball image
    if (type == 2){
    PImage img = loadImage("SoccerBall.png");
    image(img,  x, y,50,50);
    
    }
  }

  void move() {
    x += rand.nextInt() % 10;
    y += rand.nextInt() % 20;
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
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}
