import java.util.*;

interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collideable {
  boolean isTouching(Thing other);
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


public class LivingRock extends Rock implements Moveable, Collideable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    /* ONE PERSON WRITE THIS */
  }
  
  void display() {
    super.display();
  } 
  
  // preliminary code (will add code for overlap based on size of the rock)
  boolean isTouching(Thing other){
    // if rock and ball coordinates overlap, return true; else, return false
    if (x == other.x && y == other.y){
      return true;
    }
    return false;
  }
  
}

class Ball extends Thing implements Moveable {
  Random rand = new Random();
  Random rand1 = new Random();
  int type;
  int path; 
  PImage img = loadImage("SoccerBall.png");
  Ball(float x, float y) {
    super(x, y);
    type = Math.abs(rand.nextInt() % 3);
    path = Math.abs(rand1.nextInt() % 3);
    
  }
  
  void display() {
   // System.out.println(type);
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
      // fill(255);
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
    image(img,  x, y,50,50);
    
    }
  }
  
  int x_direction = Math.abs( rand1.nextInt()) % 2;
  int y_direction = Math.abs( rand1.nextInt()) % 2;
  int x_speed = Math.abs( rand1.nextInt() % 10) + 1;
  int y_speed =  Math.abs( rand1.nextInt() % 10) + 1;
  void move() {
    System.out.println( path );
    // path 0: random movement
    if (path == 0){
      System.out.println("zero");
        x += rand1.nextInt() % 10;
        y += rand1.nextInt() % 20;
    }  
    // path 1: set direction and speed
    else if (path == 1){
    if (x_direction == 0){
      x += x_speed;
    }
    else if (x_direction == 1){
      x -= x_speed;
    }
    if (y_direction == 0){
      y += y_speed;
    }
    else if (y_direction == 1){
      y -= y_speed;
    }
    }
    // path 2: move along ellipses
    float t = millis()/1000.0;
    float r1Factor = Math.abs( rand1.nextInt() % 20) + 1;
    float r2Factor = Math.abs( rand1.nextInt() % 20) + 1;
    if (path == 2){
      x = (int)(x + (height / r1Factor)*cos(t));
      y = (int)(y + (height / r2Factor)*sin(t));
    }
    
    // transport ball to center of the screen if it passes the boundaries
    if ( (int)x <= 0 || (int)x >= width || (int)y <= 0 || (int)y >= height){
      x = width / 2;
      y = height / 2;
    }
    
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
