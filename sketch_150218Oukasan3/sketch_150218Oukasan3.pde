
int numspot = 50;
spot [] s = new spot[numspot];
float k = 2.5;
 
void setup() {
  size(600, 600);
  noStroke();
  fill(255, 190);
  frameRate(30);
  for (int i = 0; i < numspot; i++) {
    s[i] = new spot(PI*2, 0, (i+5)*height/2/numspot);
  }
}

void draw() {
  background(0);

  noStroke();
  s[0].update();
  s[0].display(0);
  for (int i = 1; i < numspot; i++) {
    s[i].update();
    s[i].display(i);
    //stroke(127);
    //line(s[i-1].tipx, s[i-1].tipy, s[i].tipx, s[i].tipy);
    fill(0,0,127,63);
    triangle(width/2,height/2,s[i-1].tipx, s[i-1].tipy, s[i].tipx, s[i].tipy);
  }
}

class spot {
  float theta, thetadot, thetadotdot, length;
  float radius = 10;
  float pinx, piny;
  float tipx, tipy;
      
  //constructa
  spot(float _theta, float _thetadot, float _length) {
    theta = _theta;
    thetadot = _thetadot;
    length = _length;
  }

  //calc
  void update() {  
    thetadotdot = - k / length * sin(radians(theta));
    thetadot += thetadotdot;
    theta += thetadot;
  }

  //display
  void display(float number) {
    pinx = mouseX;
    piny = mouseY;
    tipx = length*sin(theta) + pinx;
    tipy = -length*cos(theta) + piny;
    
//    //string
//    stroke(127);
//    line(0,0, tipx, tipy);
    
//    //tips of pendulam
//    noStroke();
//    ellipse(tipx, tipy,radius*2,radius*2);
  }
}

