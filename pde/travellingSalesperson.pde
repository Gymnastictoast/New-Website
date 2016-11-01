ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<PVector> bestPath = new ArrayList<PVector>();

int shortestPath;
int numberOfPoints;
boolean pause = false;
PVector defaults = new PVector(0,0);


void setup(){
  size(400,400);
  stroke(255);
  numberOfPoints = 7;
  drawPoints(numberOfPoints);
  shortestPath = 1000000;
  for(int i = 0; i < numberOfPoints; i++){
  bestPath.add(defaults);
  }
}


void draw(){
  if(!pause){
  background(0);
  shuffleArray();
  checkPath();
  }
}

void drawPoints(int numPoints){
  for(int i = 0; i < numPoints; i++){
    points.add(new PVector(random(width),random(60, height)));
    PVector point = points.get(i);
    strokeWeight(15);
    fill(0);
    ellipse(point.x,point.y,5,5);
    noFill();
    strokeWeight(2);
  }
}

void checkPath(){

  for(int i = 0; i < numberOfPoints; i++){
    PVector point = new PVector(0,0);
  }
  PVector point1 = new PVector(0,0);
  PVector point2 = new PVector(0,0);
  PVector point3 = new PVector(0,0);
  PVector point4 = new PVector(0,0);
  PVector point5 = new PVector(0,0);
  PVector point6 = new PVector(0,0);
  PVector point7 = new PVector(0,0);

  beginShape();
  for(int i = 0; i < points.size(); i++){
    PVector point = points.get(i);

    vertex(point.x, point.y);
    if(i == 0)
    point1 = new PVector(point.x,point.y);
    if(i == 1)
    point2 = new PVector(point.x,point.y);
    if(i == 2)
    point3 = new PVector(point.x,point.y);
    if(i == 3)
    point4 = new PVector(point.x,point.y);
    if(i == 4)
    point5 = new PVector(point.x,point.y);
    if(i == 5)
    point6 = new PVector(point.x,point.y);
    if(i == 6)
    point7 = new PVector(point.x,point.y);
}
  endShape();
  int dist1 = int(dist(point1.x,point1.y,point2.x,point2.y));
  int dist2 = int(dist(point2.x,point2.y,point3.x,point3.y));
  int dist3 = int(dist(point3.x,point3.y,point4.x,point4.y));
  int dist4 = int(dist(point4.x,point4.y,point5.x,point5.y));
  int dist5 = int(dist(point5.x,point5.y,point6.x,point6.y));
  int dist6 = int(dist(point6.x,point6.y,point7.x,point7.y));
  int totalDistance = dist1 + dist2 + dist3 + dist4 + dist5 +  dist6;

  if(totalDistance < shortestPath){
    shortestPath = totalDistance;
    bestPath.set(0, point1);
    bestPath.set(1, point2);
    bestPath.set(2, point3);
    if(numberOfPoints >= 4)
    bestPath.set(3, point4);
    if(numberOfPoints >= 5)
    bestPath.set(4, point5);
    if(numberOfPoints >= 6)
    bestPath.set(5, point6);
    if(numberOfPoints >= 7)
    bestPath.set(6, point7);
}
  stroke(255,0,0);
  strokeWeight(5);
  beginShape();
  for(int i = 0; i < points.size(); i++){
    PVector point = bestPath.get(i);
    vertex(point.x, point.y);
    if(i == 0)
    point1 = new PVector(point.x,point.y);
    if(i == 1)
    point2 = new PVector(point.x,point.y);
    if(i == 2)
    point3 = new PVector(point.x,point.y);
    if(i == 3)
    point4 = new PVector(point.x,point.y);
    if(i == 4)
    point5 = new PVector(point.x,point.y);
    if(i == 5)
    point6 = new PVector(point.x,point.y);
    if(i == 6)
    point7 = new PVector(point.x,point.y);

}
  endShape();
  stroke(255);
  strokeWeight(1);
  fill(255,0,0);
  textSize(15);
  text("Shortest Path (Outlined in Red):  " + shortestPath + " Pixels",10,50);
  noFill();
}


void shuffleArray(){
  int point1 = int(random(points.size()));
  int point2 = int(random(points.size()));
  if (point2 == point1){
    point2 = int(random(points.size()));
  }
  PVector point1Loc = points.get(point1);
  PVector point2Loc = points.get(point2);
  points.set(point1, point2Loc);
  points.set(point2, point1Loc);
}


void keyPressed() {
  if(pause == false){
    pause = true;
  } else {
    pause = false;
  }
}
