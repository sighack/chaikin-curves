void example1() {
  int RADIUS = 50;
  ArrayList<PVector> plist;
  background(255);
  smooth();
  randomSeed(0);
  
  noFill();
  plist = poissonDiskSampling(RADIUS, 30);
  MPolygon[] regions = voronoi(plist);
  
  
  stroke(0, 100);
  strokeWeight(2);
  for (int i = 0; i < regions.length; i++) {
    float[][] poly_points = regions[i].getCoords();
    PShape s = createShape();
    s.beginShape();
    for (int k = 0; k < poly_points.length; k++) {
      s.vertex(poly_points[k][0], poly_points[k][1]);
    }
    s.endShape();
    shape(chaikin_shape(s, 0.8, 5), 0, 0);
  }
  
  // Draw the original voronoi diagram for comparison
  stroke(255, 0, 0, 100);
  strokeWeight(1);
  for (int i = 0; i < regions.length; i++) {
    regions[i].draw(this); // draw this shape
  }
}

void example2() {
  background(255); 
  float r = 25;
  for (float x = width/8; x <= 7*width/8; x += width/8) {
  for (float y = height/8; y <= 7*height/8; y += height/8) {
  float step = 20;
  float scale = r * 1;
  float v = 5;
  
  strokeWeight(1);
  noStroke();
  fill(0, 180);
  ArrayList<PVector> poly = rpoly(x, y, r, 10);
  //poly = deform(poly, 1, r/5, 2);
  PShape s = createShape();
  //PShape s2 = createShape();
  noStroke();
  fill(0, 180);
  s.beginShape();
  for (int i = 0; i < poly.size(); i++)
    s.vertex(poly.get(i).x + random(-v, v), poly.get(i).y + random(-v, v));
  s.endShape(CLOSE);
  shape(chaikin_shape(s, 0.75, 5), 0, 0);
  }
  }
}

void example2_1() {
  background(255); 
  float r = 200;
  float x = width/2;
  float y = height/2;
  float v = 50;
  
  strokeWeight(1);
  noStroke();
  fill(0, 180);
  ArrayList<PVector> poly = rpoly(x, y, r, 10);
  //poly = deform(poly, 1, r/5, 2);
  PShape s = createShape();
  //PShape s2 = createShape();
  noStroke();
  fill(0, 180);
  s.beginShape();
  for (int i = 0; i < poly.size(); i++)
    s.vertex(poly.get(i).x + random(-v, v), poly.get(i).y + random(-v, v));
  s.endShape(CLOSE);
  shape(chaikin_shape(s, 0.75, 5), 0, 0);
}

void example3() {
  background(255); 
  float r = 150;
  //for (float x = width/8; x <= 7*width/8; x += width/8) {
  for (int k = 0; k < 100; k++) {
  float x = width /2;
  float y = height /2;
  float step = 20;
  float scale = r * 1;
  float v = 50;
  
  strokeWeight(1);
  noStroke();
  fill(0, 20);

  ArrayList<PVector> poly = rpoly(x, y, r, 10);
  //poly = deform(poly, 1, r/5, 2);
  PShape s = createShape();
  //PShape s2 = createShape();
  noStroke();
  fill(0, 5);
  s.beginShape();
  for (int i = 0; i < poly.size(); i++)
    s.vertex(poly.get(i).x + random(-v, v), poly.get(i).y + random(-v, v));
  s.endShape(CLOSE);
  shape(chaikin_shape(s, 0.75, 5), 0, 0);

  }
}

void example4() {
  smooth();
  background(255);
  stroke(0, 200);
  strokeWeight(0.5);
  PShape s = createShape();
  float x = random(width);
  float y = random(height);
  float j = 100;
  s.beginShape();
  for (int i = 0; i < 10000; i++) {
    s.vertex(x, y);
    x += random(-j, j);
    y += random(-j, j);
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }
  s.endShape();
  shape(chaikin_curve(s, 0.8, 3), 0, 0);
}

void example5() {
  smooth();
  
  int N = 1000;
  float[][] points = new float[N][2];
  int n = 1;
  points[0][0] = random(width);
  points[0][1] = random(height);
  println(points[0][0] + " " + points[0][1]);
  float j = 100;
  for (int i = 1; i < N; i++) {
    points[i][0] = points[i - 1][0] + random(-j, j);
    points[i][1] = points[i - 1][1] + random(-j, j);
    
    points[i][0] = constrain(points[i][0], 0, width);
    points[i][1] = constrain(points[i][1], 0, height);
    //println(points[i][0] + " " + points[i][1]);
  }
  
  background(255);
  stroke(0, 10);
  noFill();
  strokeWeight(0.5);
  for (int k = 0; k < 50; k++) {
    PShape s = createShape();
    s.beginShape();
    for (int i = 0; i < N; i++) {
      j = random(5, 10);
      float nx = constrain(points[i][0] + random(-j, j), 0, width);
      j = random(5, 10);
      float ny = constrain(points[i][1] + random(-j, j), 0, height);
      s.vertex(nx, ny);
    }
    s.endShape();
    shape(chaikin_curve(s, 0.8, 3), 0, 0);
  }
}

void setup() {
  size(500, 500);
  gen();
}

void gen() {example2_1();}

void draw() {}

void mouseClicked() { gen(); }
void keyPressed() { if (key == 's') saveFrame("example.png"); }
