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
  float w,l;

  // original colors 
  int OGcolor1;
  int OGcolor2; 
  int OGcolor3; 
  // current colors
  int color1;
  int color2;
  int color3;
  
  boolean colorChange;
  
  float beginX;
  float beginY;
  
  Ball(float x, float y) {
    super(x, y);
    beginX = x;
    beginY = y;
    // type and path of ball 
   // type = Math.abs(rand.nextInt() % 2) + 1;
    type = 2;
    if (type == 1){
      w = 25; 
      l = 50;
    }
    if (type == 2){
      w = 50;
      l = 50;
    }
    
    path = 1;
 //   path = Math.abs(rand1.nextInt() % 2) + 1;
  
    // color (rgb values)
    color1 = Math.abs(rand.nextInt() % 256);
    color2 = Math.abs(rand.nextInt() % 256);
    color3 = Math.abs(rand.nextInt() % 256);
    
    // original colors
    OGcolor1 = color1; 
    OGcolor2 = color2; 
    OGcolor3 = color3; 

  }
  boolean isTouching(Thing other){
    if (other instanceof Rock){
      Rock r = (Rock)other;
      if ( (this.x >= r.x && this.x <= r.x + r.w || this.x + this.w >= r.x && this.x + this.w <= r.x + r.w)
        && (this.y >= r.y && this.y <= r.y + r.l || this.y + this.l >= r.y && this.y + this.w <= r.y + r.l) )
      return true;
    }
    return false;
  }
  
  float getX(){
    return super.x;
  }
  float getY(){
    return super.y;
  }
  void setColor(String setColorTo){
    if (setColorTo.equals("RED")){
    color1 = 255;
    color2 = 0;
    color3 = 0;
    }
    else if (setColorTo.equals("ORIGINAL")){
      color1 = 0;
      color2 = 0;
      color3 = 255;
    }
  }
  
  void display() {
     
    // type 1: make a football
    if (type == 1){
  
      fill(color1,0,0);
       
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
  int x_speed = 1;
  int y_speed =  1;
  
  float increment = 0.1;
  float power = 4;
  float endX = width - 50; 
  float endY = height - 50; 
  int direction = 1; 
  
  void move() {
     float startTint = millis();
     for(int i = 0; i < ListOfCollideables.size(); i++) {
     if (ListOfCollideables.get(i) instanceof Rock){
        
        Rock r = (Rock)ListOfCollideables.get(i);
        if ( this.isTouching(r) ){
        startTint = millis();
        tint(255,0,0);
        System.out.println("Ball is touching rock");
        //fill(0,0,255);
        rect( this.x, this.y, 10, 10);  
        this.setColor("RED");
         System.out.println("set color = red");
        }
        else{
         if (millis() - startTint > 2000){
           setColor("ORIGINAL");
         }
         System.out.println("set color = original");
        }
       }
     }
    // bounce ball if it passes boundaries
    if ( (int)x <= 0 || (int)x >= width  || (int)y <= 0 || (int)y >= height){
      bounce();
    }

    // path 1: set direction and speed
    if (path == 1){
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
    
    // path 2: move along parabolas
    
    if (path == 2 && increment < 1 && increment > 0){
      x = beginX + (increment *( endX - beginX)); 
      y = beginY + ((pow(increment, power) * (endY - beginY)));
      increment += direction*0.01; 
      
    }
   
    
  }
  
  void bounce(){ 
    if (path == 1){
        x_speed *= -1;
        y_speed *= -1;
    }
    
    if (path == 2){
      System.out.println("power: "+ power + "increment: "+increment);
      float oldX = beginX; 
      float oldY = beginY; 
      beginX = x;
      beginY = y; 
      endX = oldX;
      endY = oldY;
      direction *= -1; 
    }
    
  }
  
}

class BallA extends Ball{
  public BallA(float x, float y){
    super(x,y); 
    super.type = 1; 
    super.path = 1;
    super.color1 = 0;
    super.color2 = 255;
    super.color3 = 0;
  }
}

class BallB extends Ball{
  public BallB(float x, float y){
    super(x,y); 
    super.type = 2; 
    super.path = 2;
    super.color1 = 0;
    super.color2 = 0;
    super.color3 = 255;
  }

}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> ListOfCollideables;
ArrayList<Ball> ListOfBalls;
Ball b;
void setup() {
  size(1000, 800);
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListOfBalls = new ArrayList<Ball>();
  ListOfCollideables = new ArrayList<Collideable>();
  
   b = new Ball(0,0);
   thingsToDisplay.add(b);
   
   
  for (int i = 0; i < 2; i++) {
    Ball a = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(a);
    thingsToMove.add(a);
    ListOfBalls.add(a);
    ListOfCollideables.add(a);
  }
 /* for (int i = 0; i < 10; i++) {
    Ball a = new BallA(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(a);
    thingsToMove.add(a);
    ListOfBalls.add(a);
  }
  for (int i = 0; i < 10; i++) {
    BallB b = new BallB(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    ListOfBalls.add(b);
  }*/
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
  
  if (frameCount % 120 == 40){
  b.setColor("RED");
  }
  else{
  b.setColor("ORIGINAL");
  }
  
  }
 
