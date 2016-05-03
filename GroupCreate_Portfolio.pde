//GLOBAL VARIABLE

void setup() {
  size(400, 400);
  background(255);
  smooth();
}

void draw() {
  stroke(0);
  strokeWeight(abs(mouseX-pmouseX));
  line(pmouseX, pmouseY, mouseX, mouseY);
}