extension Percent on num {
  double percentOf(num n) => (this * n) / 100;
}

void main() {
  // ignore: avoid_print
  print(10.percentOf(235));
}
