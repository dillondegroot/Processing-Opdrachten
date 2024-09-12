float cijfer = 5.7;
boolean diploma = false;
boolean vrijstelling = false;

if(cijfer >= 5.5) {
  double random = Math.random();
  if(random <= 0.5) {
    diploma = true;
  } else {
    vrijstelling = true;
  }
}

if(diploma) {
  println("Gefeliciteerd met je diploma!");
}

if(vrijstelling) {
  println("Gefeliciteerd, je hebt vrijstelling gekregen!");
}
