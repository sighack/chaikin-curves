PShape curve;
PShape tmp;

void makeCurve() {
  curve = createShape();
  curve.beginShape();
  curve.vertex(20, 20);
  curve.vertex(180, 180);
  curve.vertex(320, 100);
  curve.vertex(480, 230);
  curve.endShape();
}

void makeShape() {
  curve = createShape();
  curve.beginShape();
  curve.vertex(20, 20);
  curve.vertex(180, 180);
  curve.vertex(480, 230);
  curve.vertex(400, 50);
  curve.endShape(CLOSE);
}

void setup() {
  size(500, 250);
  background(255);
  
  noFill();
  smooth();
  stroke(0);
  strokeWeight(1);
  tmp = curve;
  
  //for (int i = 0; i < 3; i++) {
  //  tmp = chaikin_open(tmp, 0.75, 1);
  //  plist.add(tmp);
  //}
  
  start = millis();
}

int start;
int delay = 1000;
int k = 1;
int MAX = 4;
int reduce = 60;
int drawn = 0;

void draw() {
  if (millis() - start >= delay) {
    start = millis();
    k++;
  }
  
  if (k >= MAX)
    noLoop();
  
  println("Drawing till " + k);
  background(255);
  float opacity = 255 - k*reduce;
  println(opacity);
  stroke(255, 0, 0, opacity);
  noFill();
  //makeCurve();
  makeShape();
  tmp = curve;
  for (int i = 1; i <= k; i++) {
    opacity = map(i, 1, k, 100, 255);
    opacity = 255 - k*reduce + i * reduce;
    println(opacity);
    stroke(255, 0, 0, opacity);
    noFill();
    shape(tmp);
    tmp = chaikin_close(tmp, 0.75, 1);
    //tmp = chaikin_open(tmp, 0.75, 1);
  }
  
  if (drawn < k) {
    saveFrame("####.png");
    drawn++;
  }
}
