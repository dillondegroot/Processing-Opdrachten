size(500, 500);
background(24, 24, 24);

int xWaarde = 70;
int yWaarde = 70;

for(int i = 0; i < 5; i++){
  for(int j = 0; j < 2; j++){
    fill(200, 200, 200);
    rect(xWaarde, yWaarde, 70, 70);
    yWaarde += 70;
  }
  yWaarde = 70;
  xWaarde += 70;
}
