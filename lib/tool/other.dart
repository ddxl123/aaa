String formatNumber(int number) {
  if (number >= 1000) {
    double result = number / 1000;
    return "${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}k";
  } else {
    return number.toString();
  }
}