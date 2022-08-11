class Check {
  final bool isOk;
  final String notMessage;

  Check({required this.isOk, required this.notMessage});

  bool get isNotOk => !isOk;
}

class Checks {
  final List<Check> checks;
  late final String notMessage;

  Checks(this.checks);

  bool get isAllOk {
    for (var value in checks) {
      if (!value.isOk) {
        notMessage = value.notMessage;
        return false;
      }
    }
    return true;
  }
}
