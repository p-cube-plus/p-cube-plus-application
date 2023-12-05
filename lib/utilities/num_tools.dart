class DoubleToInt {
  static String autoFix(double d) {
    if (d.toInt() == d)
      return d.toInt().toString();
    else
      return d.toString();
  }
}
