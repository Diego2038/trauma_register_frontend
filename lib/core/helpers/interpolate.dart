class Interpolate {
  static double interpolate({
    required double xMin,
    required double xMax,
    required double yMin,
    required double yMax,
    required double x,
  }) {
    if (x <= xMin) return yMin;
    if (x >= xMax) return yMax;

    final ratio = (x - xMin) / (xMax - xMin);
    return yMin + (yMax - yMin) * ratio;
  }
}
