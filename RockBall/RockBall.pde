import java.util.*;
ArrayList<LivingRock> livingRocks = new ArrayList<LivingRock>();


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
  
  abstract void changeColor(boolean change);
  
  boolean isTouching(Thing other) {
    if (dist(x, y, other.xcorCenter(), other.ycorCenter()) <= 50) {
      return true;
    }
    return false;
  }
  float xcorCenter() {
    return x + 25;
  }
  float ycorCenter() {
    return y + 25;
  }
}

class Rock extends Thing implements Collideable {
  Random rand = new Random(); 
  int type; // type of rock 
  float[] Xnum;
  float[] Ynum;
  PImage rock = loadImage("Rock.png"); // rock image
  PImage rock2 = loadImage("Rock2.png");
  
  void changeColor(boolean change){
  }
  
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
      image(rock, x, y, 50,50);
    }
    if (type == 1) {
      image(rock2, x, y, 50, 50);
    }
  }
  
   // preliminary code (will add code for overlap based on size of the rock)
  boolean isTouching(Thing other){
    // if rock and ball coordinates overlap, return true; else, return false
    if (other.x >= this.x - 50 && other.x <= this.x + 50
     && other.y >= this.y - 50 && other.y <= this.y + 50){
      other.changeColor(true);
      
      return true;
    }
    other.changeColor(false);
    return false;
  }
  
}


public class LivingRock extends Rock implements Moveable {
  Random rand1 = new Random();
  int path; // type of path 
  float xSpeed;
  float ySpeed;
  int xMult;
  int yMult;
  
  LivingRock(float x, float y) {
    super(x, y);
    path = Math.abs(rand1.nextInt()) % 3; // 0, 1, or 2
    xSpeed = random(0, 2);
    ySpeed = random(0, 2);
    xMult = (int) random(-1, 2);
    yMult = (int) random(-1, 2);
  }
  void move() {  
    if (x < 50) xMult = 1;
    if (x > 950) xMult = -1;
    if (y < 50) yMult = 1;
    if (y > 750) yMult = -1;
    x += xSpeed * xMult;
    y += ySpeed * yMult;
    int switchy = (int) random(0, 25);
    if (switchy == 0) {
      int switcher = (int) random(0, 2);
      ySpeed = random(0, 2);
      xSpeed = random(0, 2);
      if (switcher == 0) xMult = (int) random(-1, 2);
      if (switcher == 1) yMult = (int) random(-1, 2);
    }
    for (LivingRock c : livingRocks) {
      if (c.isTouching(this) && c != this) {
        this.xMult *= -1;
        this.yMult *= -1;
        c.xMult *= -1;
        c.yMult *= -1;
      }
    }
  }
  
  void display() {
    super.display();
    fill(255, 255, 255);
    if (type == 0) {
      ellipse(x + 35, y + 15, 10, 5);
      ellipse(x + 15, y + 15, 10, 5);
    }
    if (type == 1) {
      ellipse(x + 35, y + 15, 10, 5);
      ellipse(x + 15, y + 15, 10, 5);
    }
    
    
 
  } 
  
  
}

class Ball extends Thing implements Moveable {
  Random rand = new Random();
  Random rand1 = new Random();
  int type;
  int path; 
  PImage img = loadImage("SoccerBall.png");
  // current colors
  int color1; 
  int color2;
  int color3;
  // original colors 
  int OGcolor1;
  int OGcolor2; 
  int OGcolor3; 
  // collision colors
  int Ccolor1; 
  int Ccolor2; 
  int Ccolor3; 
  
  boolean colorChange;
  
  float beginX;
  float beginY;
  
  Ball(float x, float y) {
    super(x, y);
    beginX = x;
    beginY = y;
    // type and path of ball 
    type = Math.abs(rand.nextInt() % 2) + 1;
    path = Math.abs(rand1.nextInt() % 2) + 1;
  
    // color (rgb values)
    color1 = Math.abs(rand.nextInt() % 256);
    color2 = Math.abs(rand.nextInt() % 256);
    color3 = Math.abs(rand.nextInt() % 256);
    // original colors
    OGcolor1 = color1; 
    OGcolor2 = color2; 
    OGcolor3 = color3; 
    // collision colors
    int Ccolor1 = 255;
    int Ccolor2 = 0; 
    int Ccolor3 = 0;
    // change colors?
    colorChange = false;
  }
  
  float getX(){
    return super.x;
  }
  float getY(){
    return super.y;
  }
  void setColor(int r, int g, int b){
    color1 = r;
    color2 = g;
    color3 = b;
  }
  
  // see if ball is touching rock or living rock, then change color of ball while touching 
  void testCollide(){
    for(int i = 0; i < ListOfCollideables.size(); i++) {
     if ( ListOfCollideables.get(i).isTouching( (Thing)this)){
        fill(0,0,255);
        rect( this.x, this.y, 10, 10);  
        changeColor(true);
        setColor(Ccolor1, Ccolor2, Ccolor3);
        this.x_speed *= -1;
        this.y_speed *= -1;
   
       }
     else{
        setColor(OGcolor1, OGcolor2, OGcolor3); 
     }
  }
  }
  void display() {
    testCollide();

    // type 1: make a football
    if (type == 1){
      if (!colorChange){

        fill(color1,0,0);
        
      }
      if (colorChange){
       // System.out.println("color change = true");
        fill(255,0,0);
      }
      ellipseMode(CENTER);
      // ball silhouette
      ellipse(x, y, 25, 50); 
      
      if (!colorChange){
        fill(color1,0,0);
      }
      if (colorChange){
        fill(0,color2,0);
      }
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
    if (colorChange){
     // System.out.println("color change = true");
      tint(255,0,0);
      
    }
    if (! colorChange){
     // System.out.println("color change = false");
      tint(color1, color2, color3);
    }
    }
  }
  // change color to red?
  void changeColor(boolean change){
    colorChange = change;
  }
  
  int x_direction = Math.abs( rand1.nextInt()) % 2;
  int y_direction = Math.abs( rand1.nextInt()) % 2;
  int x_speed = Math.abs( rand1.nextInt() % 5) + 1;
  int y_speed =  Math.abs( rand1.nextInt() % 5) + 1;
  
  float increment = 0.1;
  float power = 4;
  float endX = width - 50; 
  float endY = height - 50; 
  int direction = 1; 
  
  void move() {
    
    // bounce ball if it passes boundaries
    if ( (int)x <= 100 || (int)x >= width - 100 || (int)y <= 100 || (int)y >= height - 100){
      bounce();
    }
    
   /* if (path == 0){
        x += Math.abs( rand1.nextInt() % 2) + 5;
        y += Math.abs( rand1.nextInt() % 2) + 10;
    } */ 
    
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
    
    // path 2: move along parabolas
    
    if (path == 2 && increment < 1 && increment > 0){
      x = beginX + (increment *( endX - beginX)); 
      y = beginY + ((pow(increment, power) * (endY - beginY)));
      increment += direction*0.01; 
      
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
    super.Ccolor1 = 0;
    super.Ccolor2 = 255;
    super.Ccolor3 = 0;
  }
}

class BallB extends Ball{
  public BallB(float x, float y){
    super(x,y); 
    super.type = 2; 
    super.path = 2;
    super.Ccolor1 = 0;
    super.Ccolor2 = 0;
    super.Ccolor3 = 255;
  }
  
  void testCollide(){
    for(int i = 0; i < ListOfCollideables.size(); i++) {
     if ( ListOfCollideables.get(i).isTouching( (Thing)this)){
        fill(0,0,255);
        rect( this.x, this.y, 10, 10);  
        changeColor(true);
        setColor(Ccolor1, Ccolor2, Ccolor3);
        // bounce back in reverse parabola 
        super.increment *= -1; 
 
       }
     else{
        setColor(OGcolor1, OGcolor2, OGcolor3); 
     }
  }
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
  
  for (int i = 0; i < 10; i++) {
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
 
  for (int i = 0; i < thingsToDisplay.size(); i++) {
    thingsToDisplay.get(i).display();
       // testing Collideable
  
  }

  for (Moveable thing : thingsToMove) {
    thing.move();
  }
  }
 
