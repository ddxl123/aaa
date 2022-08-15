
void main()async {
  for (var element in [0, 1, 2]) {
    await Future.delayed(Duration(seconds: 3));
    print(element);
  }
}
