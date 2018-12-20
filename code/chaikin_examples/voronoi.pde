import megamu.mesh.*;

MPolygon[] voronoi(ArrayList<PVector> points) {
  float[][] fpoints;
  fpoints = new float[points.size()][2];
  for (int i = 0; i < points.size(); i++) {
    fpoints[i][0] = points.get(i).x;
    fpoints[i][1] = points.get(i).y;
  }
  Voronoi myVoronoi = new Voronoi(fpoints);
  MPolygon[] regions = myVoronoi.getRegions();
  return regions;
  //for (int i = 0; i < regions.length; i++) {
  //  color c = getColor(regions[i]);
  //  out.fill(c);
  //  out.stroke(c);
  //  regions[i].draw(out); // draw this shape
  //}
}
