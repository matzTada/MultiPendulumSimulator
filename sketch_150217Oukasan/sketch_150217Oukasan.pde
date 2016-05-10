int numspot = 40;
spot [] s = new spot[numspot];

void setup(){
  size(400,400);
  smooth();
  fill(0);
  for(int i = 0; i < numspot; i++){
    s[i] = new spot(PI/4, 0, (i+1)*height/numspot);
  }
}

void draw(){
  fill(0,15);
  rect(0,0,width,height);
  fill(255);
  for(int i = 0; i < numspot; i++){
    s[i].update();
    s[i].display();
  }  
}

class spot{
  float theta,thetadot,thetadotdot,length;
  float radius = 10;
  float k = 0.001;
  
  //constructa
  spot(float _theta, float _thetadot, float _length){
    theta = _theta;
    thetadot = _thetadot;
    length = _length;
  }
  
  //calc
  void update(){  
    thetadotdot = - k * length * sin(radians(theta));
    thetadot += thetadotdot;
    theta += thetadot;
  }
  
  //display
  void display(){ 
    noStroke();
    ellipse(width/2+length*sin(theta),length*cos(theta),radius*2,radius*2);
    stroke(255);
  }
}

