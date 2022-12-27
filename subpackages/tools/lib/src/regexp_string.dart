extension StringRegExp on String {
  bool isEmail() {
    if (!trim().contains('@')) {
      return false;
    }
    return true;
  }

  bool isPhone() {
    if (trim() == '' || trim().length < 5) {
      return false;
    }
    return true;
  }
}
