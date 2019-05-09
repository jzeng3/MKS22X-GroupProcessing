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
  Random rand = new Random(); 
  int type; // type of rock 
  float[] Xnum;
  float[] Ynum;
  PImage rock = loadImage("Rock.png"); // rock image
  PImage rock2 = loadImage("Rock2.png");
  
  
  Rock(float x, float y) {
    super(x, y);
    type = Math.abs(rand.nextInt()) % 2; // 0 or 1
    /*
    Xnum = new float[] {x-25, random(x-1, x-25), x, random(x+1, x+25), x+25, random(x+1, x+25), x, random(x-1, x-25)};
    Ynum = new float[] {y, random(y-10, y-25), y-25, random(y-10, y-25), y, random(y+10, y+25), y+25, random(y+10, y+25)};
    */
  }

   void display() {
    /* ONE PERSON WRITE THIS */
    /*
    if (type == 0) {rect(x,y,50,50);}
    if (type == 1) {
      beginShape();
      for (int i = 0; i < 5; i++) {
        vertex(Xnum[i],Ynum[i]);
      }
      endShape(CLOSE);
    }
    */
    if (type == 0) {
      image(rock, x, y, 80,50);
    }
    if (type == 1) {
      image(rock2, x, y, 50, 50);
    }
  }
}


public class LivingRock extends Rock implements Moveable, Collideable {
  int xinc;
  int yinc;
  Random rand1 = new Random();
  int path; // type of path 
  
  LivingRock(float x, float y) {
    super(x, y);
    path = Math.abs(rand1.nextInt()) % 3; // 0, 1, or 2
    xinc = (int) random(-1, 2);
    yinc = (int) random(-1, 2);
  }
  void move() {
    /* ONE PERSON WRITE THIS */
    if (x < 0) xinc = 1;
    if (x > 1000) xinc = -1;
    if (y < 0) yinc = 1;
    if (y > 800) yinc = -1;
    x += xinc;
    y += yinc;
    int switchy = (int) random(0, 25);
    if (switchy == 0) {
      int switcher = (int) random(0, 2);
      if (switcher == 0) xinc = (int) random(-1, 2);
      if (switcher == 1) yinc = (int) random(-1, 2);
    }
  }
  
  void display() {
    super.display();
    fill(255, 255, 255);
    if (type == 0) {
      ellipse(x + 50, y + 15, 10, 5);
      ellipse(x + 30, y + 15, 10, 5);
    }
    if (type == 1) {
      ellipse(x + 35, y + 15, 10, 5);
      ellipse(x + 15, y + 15, 10, 5);
    }
    
    
 
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
  int color1; 
  int color2;
  int color3; 
  Ball(float x, float y) {
    super(x, y);
    type = Math.abs(rand.nextInt() % 3);
    //path = Math.abs(rand1.nextInt() % 3);
    path = 1;
    color1 = Math.abs(rand.nextInt() % 256);
    color2 = Math.abs(rand.nextInt() % 256);
    color3 = Math.abs(rand.nextInt() % 256);
  }
  
  void display() {
   // System.out.println(type);
    // type 0: make a simple circle
    if (type == 0){
      fill(color1, color2, color3);
      ellipseMode(CENTER);
      ellipse(x, y, 50,50); 
      
    }
    // type 1: make a football
    if (type == 1){
       fill(color1);
      ellipseMode(CENTER);
      // ball silhouette
      ellipse(x, y, 25, 50); 
      
      fill(color2);
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
    image(img,  x, y,50,50);
    tint(color1, color2, color3);
    }
  }
  
  int x_direction = Math.abs( rand1.nextInt()) % 2;
  int y_direction = Math.abs( rand1.nextInt()) % 2;
  int x_speed = Math.abs( rand1.nextInt() % 10) + 1;
  int y_speed =  Math.abs( rand1.nextInt() % 10) + 1;
  
  void move() {
    // System.out.println( path );
    // path 0: random movement
    // transport ball to center of the screen if it passes the boundaries
    if ( (int)x <= 0 || (int)x >= width || (int)y <= 0 || (int)y >= height){
      bounce();
    }
    
    if (path == 0){
        x += Math.abs( rand1.nextInt() % 2) + 5;
        y += Math.abs( rand1.nextInt() % 2) + 10;
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
    float r1Factor = Math.abs( rand1.nextInt() % 5) + 1;
    float r2Factor = Math.abs( rand1.nextInt() % 5) + 1;
    if (path == 2){
      System.out.println("path = 2");
      x = (int)(x + (height / r1Factor)*cos(t));
      y = (int)(y + (height / r2Factor)*sin(t));
    }
   
    
  }
  
  void bounce(){
    int bound = 100; 
    int x_bound1 = bound;
    int x_bound2 = width - bound;
    int y_bound1 = bound;
    int y_bound2 = height - bound;
    
    if (path == 1){
        x_speed *= -1;
        y_speed *= -1;
    }
  }
  
}


/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
//ArrayList<Collideable> ListOfCollideables;

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
  //  ListOfCollideables.add(m);
  }
  
  // testing Collideable
  /*ListOfCollideables = new ArrayList<Collideable>();
  Ball b = new Ball(100,100);
  for( Collideable c : ListOfCollideables) {
     if ( c.isTouching(b)){
        System.out.println("touching!");
      }
  }*/
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
