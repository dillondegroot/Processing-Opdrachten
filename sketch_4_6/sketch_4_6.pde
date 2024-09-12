float[] grades = new float[3];

void setup() {
  grades[0] = 7.5;
  grades[1] = 4.7;
  grades[2] = 8.5;
  
  print(average(grades));
}

float average(float[] numbers) {
  float result = 0;
  for(int i = 0; i <= numbers.length - 1; i++) {
    result += numbers[i];
  }
  return result / numbers.length;
}
