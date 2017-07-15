import processing.video.*;

class Particle {
  float x;
  float y;
  
  float vx;
  float vy;

  Particle() {
    x = width/2;
    y = height/2;
    float a = random(TWO_PI);
    float speed = random(1,40);
    vx = cos(a)*speed;
    vy = sin(a)*speed;
  }

  void display() {
    noStroke();
    color c = video.get(int(x),int(y));
    fill(c,25);
    ellipse(x, y, 12, 12);
  }

  void move() {
    x = x + vx;//random(-5, 5);
    y = y + vy;//random(-5, 5);
    if (y < 0) {
      y = height;
    } 

    if (y > height) {
      y = 0;
    }
    if (x < 0) {
      x = width;
    } 

    if (x > width) {
      x = 0;
    }
  }
}


Particle[] particles;
Capture video;


void setup() {
  size(600, 400);
  
  video = new Capture(this, 640, 480, 30);
  video.start();
  
  particles = new Particle[100];
  for (int x = 0; x < particles.length; x++) {
    particles[x] = new Particle();
  }
  background(0);
}

void captureEvent(Capture capture) {
  video.read(); 
}

void draw() {
  captureEvent(video);
  for (int x = 0; x < particles.length; x++) {
    particles[x].display();
    particles[x].move();
  }
}