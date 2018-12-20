ArrayList<PVector> rpoly(float x, float y, float r, int nsides) {
  ArrayList<PVector> points = new ArrayList<PVector>();
  float sx, sy;
  float angle = TWO_PI / nsides;

  /* Iterate over edges in a pairwise fashion. */
  for (float a = 0; a < TWO_PI; a += angle) {
    sx = x + cos(a) * r;
    sy = y + sin(a) * r;
    points.add(new PVector(sx, sy));
  }
  return points;
}

ArrayList<PVector> deform(ArrayList<PVector> points, int depth,
                            float variance, float vdiv) {

  float sx1, sy1, sx2 = 0, sy2 = 0;
  ArrayList<PVector> new_points = new ArrayList<PVector>();

  if (points.size() == 0)
    return new_points;

  /* Iterate over existing edges in a pairwise fashion. */
  for (int i = 0; i < points.size(); i++) {
    sx1 = points.get(i).x;
    sy1 = points.get(i).y;
    sx2 = points.get((i + 1) % points.size()).x;
    sy2 = points.get((i + 1) % points.size()).y;

    new_points.add(new PVector(sx1, sy1));
    subdivide(new_points, sx1, sy1, sx2, sy2,
                depth, variance, vdiv);
  }

  return new_points;
}

/*
 * Recursively subdivide a line from (x1, y1) to (x2, y2) to a
 * given depth using a specified variance.
 */
void subdivide(ArrayList<PVector> new_points,
                 float x1, float y1, float x2, float y2,
                 int depth, float variance, float vdiv) {
  float midx, midy;
  float nx, ny;

  if (depth >= 0) {
    /* Find the midpoint of the two points comprising the edge */
    midx = (x1 + x2) / 2;
    midy = (y1 + y2) / 2;

    /* Move the midpoint by a Gaussian variance */
    nx = midx + random(-1, 1) * variance;
    ny = midy + random(-1, 1) * variance;

    /* Add two new edges which are recursively subdivided */
    subdivide(new_points, x1, y1, nx, ny,
                depth - 1, variance/vdiv, vdiv);
    new_points.add(new PVector(nx, ny));
    subdivide(new_points, nx, ny, x2, y2,
                depth - 1, variance/vdiv, vdiv);
  }
}
