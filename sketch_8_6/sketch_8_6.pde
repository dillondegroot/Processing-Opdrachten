size(500, 500);
background(240, 240, 240);

int size = 460;

for(int i = 0; i < 5; i++) {
  ellipse(500 - size/2, 250, size, size);
  size -= 90;
}
