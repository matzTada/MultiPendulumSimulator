import processing.opengl.*;

int numspot = 20;
spot [] s = new spot[numspot];

int simulationflag = 0;

void setup() {
  size(600, 600, OPENGL);
  noStroke();
  fill(255, 190);
  frameRate(30);
  for (int i = 0; i < numspot; i++) {
    s[i] = new spot(PI/4, 0, (i+5)*height/4/numspot);
  }
}

void draw() {
  background(0);

  ambientLight(63, 31, 31);
  directionalLight(255, 255, 255, 0, 0, 1);
  pointLight(63, 127, 255, mouseX, mouseY, 200);
  spotLight(100, 100, 100, mouseX, mouseY, 200, 0, 0, -1, PI, 2);

  //camera
  float eyepointx = 200 * cos(radians(((float)width-mouseX)/(float)width * 180));
  float eyepointz = -200 * sin(radians(((float)width-mouseX)/(float)width * 180));
  float eyepointy = 200 * sin(radians(((float)height/2-mouseY)/(float)height * 180));
  camera(eyepointx, eyepointy, eyepointz, 0, 0, 0, 0, -1, 0);

  stroke(255, 0, 0);//Red X axis
  line(0, 0, 0, 100, 0, 0);
  stroke(0, 255, 0);//Green Y axis
  line(0, 0, 0, 0, 100, 0);
  stroke(0, 0, 255);//Blue Z axis
  line(0, 0, 0, 0, 0, 100);

  noStroke();
  for (int i = 0; i < numspot; i++) {
    if(simulationflag == 1) s[i].update();
    s[i].display(i);
  }
  
  //keyboard direction
  if(keyPressed){
    if(key == 's'){
      simulationflag = (simulationflag == 0) ? 1 : 0;
    }
  }
}

class spot {
  float theta, thetadot, thetadotdot, length;
  float k = 20.0;
  float rtheta;

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
    float pinx, piny, pinz;
    pinx = 0;
    piny = 100;
    pinz = -number*2;
    float tipx, tipy, tipz;
    tipx = length*sin(theta) + pinx;
    tipy = -length*cos(theta) + piny;
    tipz = pinz;
    
    //string
    stroke(127);
    line(pinx, piny, pinz, tipx, tipy, tipz);
    
    //pin
    pushMatrix();
    translate(pinx,piny,pinz);
    sphere(2);
    popMatrix();
    
    //tips of pendulam
    noStroke();
    pushMatrix();
    translate(tipx, tipy, tipz);
//    rtheta+=2;
//    rotateX(radians(rtheta));
//    rotateY(radians(rtheta));
//    rotateZ(radians(rtheta));
//    box(8, 8, 8);
    sphere(6);
    popMatrix();
  }
}

