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

class Rock extends Thing implements Collideable {
  Random rand = new Random(); 
  int type; // type of rock 
  float[] Xnum;
  float[] Ynum;
  float w;
  float l;
  PImage rock = loadImage("Rock.png"); // rock image
  PImage rock2 = loadImage("Rock2.png");

  Rock(float x, float y) {
    super(x, y);
    w = 50;
    l = 50;
    type = Math.abs(rand.nextInt()) % 2; // 0 or 1
  }

   void display() {
   noTint();
   if (type == 0) {
      w = 50;
      l = 50;
      image(rock, x, y, 50,50);
    }
    if (type == 1) {
      w = 50;
      l = 50;
      image(rock2, x, y, 50, 50);
    }
   
  }
  
   // preliminary code (will add code for overlap based on size of the rock)
  boolean isTouching(Thing other){
    // if rock and ball coordinates overlap, return true; else, return false
    if (other.x >= this.x - 50 && other.x <= this.x + 50
     && other.y >= this.y - 50 && other.y <= this.y + 50){
      
      return true;
    }
    return false;
  }
  
}


public class LivingRock extends Rock implements Moveable {
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
  /*  if (type == 0) {
      ellipse(x + 35, y + 15, 10, 5);
      ellipse(x + 15, y + 15, 10, 5);
    }
    if (type == 1) {
      ellipse(x + 35, y + 15, 10, 5);
      ellipse(x + 15, y + 15, 10, 5);
    }*/
 
  } 
  
  
}

class Ball extends Thing implements Moveable, Collideable{
  Random rand = new Random();
  Random rand1 = new Random();
  int type;
  int path; 
  
  PImage img = loadImage("SoccerBall.png");
  PImage img2 = loadImage("Baseball.png");
  float w,l;

  // original colors 
  int OGcolor1;
  int OGcolor2; 
  int OGcolor3; 
  
  // current colors
  int color1;
  int color2;
  int color3;
 
  // for path 2
  float beginX;
  float beginY;
  float factorA;
  float factorB;
  float factorC;
  int x_dir;
  
  // collide color
  String colorIs;
  String collideColor;
  
  Ball(float x, float y) {
    super(x, y);
    w = 50;
    l = 50;
    // beginning coordinates 
    beginX = x;
    beginY = y;
   
    // type and path of ball 
    type = Math.abs(rand.nextInt() % 2) + 1;
    path = Math.abs(rand1.nextInt() % 2) + 1;
    
    colorIs = "ORIGINAL";
    collideColor = "RED";

    // color (rgb values)
    color1 = Math.abs(rand.nextInt() % 256);
    color2 = Math.abs(rand.nextInt() % 256);
    color3 = Math.abs(rand.nextInt() % 256);
    
    // original colors
    OGcolor1 = color1; 
    OGcolor2 = color2; 
    OGcolor3 = color3;   
        
    // factors for path 2
    if (path == 2){
      x_dir = 1;
      factorA = 200;
      factorB = 0.05;
      factorC = 0;
      collideColor = "GREEN";
    }
    
  }
  
  // check if ball is touching rouch
  boolean isTouching(Thing other){
    if (other instanceof Rock){
      Rock r = (Rock)other;
      if ( (this.x >= r.x && this.x <= r.x + r.w || this.x + this.w >= r.x && this.x + this.w <= r.x + r.w)
        && (this.y >= r.y && this.y <= r.y + r.l || this.y + this.l >= r.y && this.y + this.w <= r.y + r.l) ){
      return true;
        }
    }
    return false;
  }
  
  float getX(){
    return super.x;
  }
  float getY(){
    return super.y;
  }
  
  // set color to specified 
  void setColor(String setColorTo){
    if (setColorTo.equals(collideColor)){
    colorIs = collideColor;
    if (collideColor == "RED"){
    color1 = 255;
    color2 = 0;
    color3 = 0;
    }
    if (collideColor == "GREEN"){
      color1 = 0;
      color2 = 255;
      color3 = 0;
    }
    
    }
    else if (setColorTo.equals("ORIGINAL")){
      colorIs = "ORIGINAL";
      color1 = OGcolor1;
      color2 = OGcolor2;
      color3 = OGcolor3;
    }
  }
  
  String getColor(){
    return colorIs;
  }
  
  void display() {
    // type 1: make a football
    if (type == 1){
     tint(color1, color2, color3);
    image(img2, x, y,50,50);
  
  /*    fill(color1,0,0);
       
     ellipseMode(CORNER);
      // ball silhouette
      ellipse(x, y, 25, 50); 
      
      fill(0,color2,0);
      // vertical stripe
      rect(x - 1, y - 8, 5, 20); 
      
      // horizontal lines
      rect(x -5, y - 20, 12, 5,8); 
      rect(x-5 , y + 15, 12, 5,8); 
      
      //eyes
      fill(255);
     ellipseMode(CORNER);
      ellipse(x - 5,y,7,10);
      ellipse(x + 5,y,7,10);
      fill(0);
      
     ellipseMode(CORNER);
      ellipse(x - 5,y,3,3);
      ellipse(x + 5,y,3,3);*/
      
    }
    
    // type 2: soccer ball image
    if (type == 2){
    tint(color1, color2, color3);
    image(img,  x, y,50,50);
    }
    
  }
  
  
  int x_direction = Math.abs( rand1.nextInt()) % 2;
  int y_direction = Math.abs( rand1.nextInt()) % 2;
  int x_speed = (int)(PI*Math.random() * 5);
  int y_speed = (int)(PI*Math.random() * 8);
  
  void move() {
  
    // bounce ball if it passes boundaries
    if (path == 1){
      bounce();
    }
    
    // loop through collideables
    for(int i = 0; i < ListOfCollideables.size(); i++) {
     if (ListOfCollideables.get(i) instanceof Rock){
       
       // if ball is touching rock, change color to red 
        Rock r = (Rock)ListOfCollideables.get(i);
        if ( this.isTouching(r) ){
        this.setColor(collideColor);
       // bounce the ball away based on the path type 
       
       // path 1: reverse x and/or y direction
      if (path == 1){
        if ( (x_speed > 0 && this.x + this.w <= r.x + (r.w / 2) )
        || ( x_speed < 0 && this.x >= r.x + (r.w / 2) ) ){
          x_speed *= -1;
        }
        if ( (y_speed > 0 && this.y + this.l <= r.y + (r.l / 2) )
        || ( y_speed < 0 && this.y >= r.y + (r.l / 2) ) ){
          y_speed *= -1;
       } 
      }
      
       // path 2: slow down the ball by increasing the period of the function
       if (path == 2 && frameCount % 60 == 5){
         factorB *= 0.85;
       }
     }    
     }
     
     // change back to original color after a second has passed
     if (this.getColor().equals(collideColor) && frameCount % 60 == 4){
           setColor("ORIGINAL");
      }
    }

    // path 1: set direction and speed
    if (path == 1){
      x += x_speed;
      y += y_speed;
    }
    
    // path 2: change x-direction, and factorA in the sine function as needed
    if (path == 2){
           
     if (x < 25 || x > width - 50){
       x_dir *= -1;
     }
     if (y < 0 && frameCount % 30 == 10){ 
       y += factorA;
      factorA *= 0.85;
      
     }
     else if (y >= height && frameCount % 30 == 10){
       y -= factorA;
       factorA *= 0.85; 
     }
     
    if (x >= 0 && x <= width && y >= 0 && y < height){
        x += x_dir;
        y = factorA*sin(factorB*x) + beginY;
     }
    }
  }
  
  // bounce ball if reached edge of screen
  void bounce(){ 
    if (path == 1){
      if (x < 0 || x > width - 50){
        x -= x_speed;
        x_speed *= -1;
    }
    if (y < 0  || y > height) {
        y -= y_speed;
        y_speed *= -1;
    }
   }
  }
  
}

// type1, path1 ball, collide color is red
class BallA extends Ball{
  public BallA(float x, float y){
    super(x,y); 
    super.type = 1; 
    super.path = 1;
  }
}

// type2, path2 ball, collide color is green
class BallB extends Ball{
  public BallB(float x, float y){
    super(x,y); 
    super.type = 2; 
    super.path = 2;

      super.x_dir = 1;
      super.factorA = 200;
      super.factorB = 0.05;
      super.factorC = 0;
      super.collideColor = "GREEN";

  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> ListOfCollideables;
ArrayList<Ball> ListOfBalls;

void setup() {
  size(1000, 800);
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListOfBalls = new ArrayList<Ball>();
  ListOfCollideables = new ArrayList<Collideable>();
 
/*  for (int i = 0; i < 30; i++) {
    Ball a = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(a);
    thingsToMove.add(a);
    ListOfBalls.add(a);
    ListOfCollideables.add(a);
  }*/
for (int i = 0; i < 10; i++) {
    Ball a = new BallA(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(a);
    thingsToMove.add(a);
    ListOfBalls.add(a);
    
    Ball b = new BallB(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    ListOfBalls.add(b);
  }
  
  for (int i = 0; i < 10; i++){
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
    ListOfCollideables.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
    ListOfCollideables.add(m);
  }
 
}
void draw() {
  background(255);
 
 
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
  for (int i = 0; i < thingsToDisplay.size(); i++) {
    thingsToDisplay.get(i).display();
  }
  
  }
 
