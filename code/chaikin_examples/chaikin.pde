ArrayList<PVector> chaikins_break(PVector a, PVector b, float ratio) {
  ArrayList<PVector> n = new ArrayList<PVector>();

  float x, y;
  x = lerp(b.x, a.x, ratio);
  y = lerp(b.y, a.y, ratio);
  n.add(new PVector(x, y));
  x = lerp(a.x, b.x, ratio);
  y = lerp(a.y, b.y, ratio);
  n.add(new PVector(x, y));
  return n;
}

PShape chaikin(PShape original, float ratio, int iterations, boolean close) {
  PShape s;
  
  if (iterations == 0)
    return original;
  
  s = createShape();
  s.beginShape();
  int max = close ? original.getVertexCount() : original.getVertexCount() - 1;
  for (int i = 0; i < max; i++) {
    PVector a = original.getVertex(i);
    PVector b = original.getVertex((i + 1) % original.getVertexCount());
    ArrayList<PVector> n = chaikins_break(a, b, ratio);
    //println(a.x + "," + a.y + " & " + b.x + "," + b.y + " --> " + n.get(0).x + "," + n.get(0).y + " & " + n.get(1).x + "," + n.get(1).y); 
    s.vertex(n.get(0).x, n.get(0).y);
    s.vertex(n.get(1).x, n.get(1).y);
  }
  if (close)
    s.endShape(CLOSE);
  else
    s.endShape();
  
  return chaikin(s, ratio, iterations - 1, close);
}

PShape chaikin_shape(PShape original, float ratio, int iterations) {
  return chaikin(original, ratio, iterations, true);
}

PShape chaikin_curve(PShape original, float ratio, int iterations) {
  return chaikin(original, ratio, iterations, false);
}
