part of algorithm_parser;

class IfUseElseWrapper {
  IfUseElseWrapper({
    required this.ifers,
    required this.elser,
  });

  final List<Ifer> ifers;
  final Elser elser;

  factory IfUseElseWrapper.fromJson(Map<String, dynamic> json) => IfUseElseWrapper(
        ifers: (json["ifers"] as List<dynamic>).map((e) => Ifer.fromJson(e as Map<String, dynamic>)).toList(),
        elser: Elser.fromJson(json["elser"]),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "ifers": this.ifers.map((e) => e.toJson()).toList(),
        "elser": this.elser.toJson(),
      };

  static IfUseElseWrapper emptyIfUseElseWrapper = IfUseElseWrapper(ifers: [Ifer.emptyIfer], elser: Elser.emptyElser);

  static IfUseElseWrapper emptyIfUseElseWrapperWithInit(Ifer ifer) => IfUseElseWrapper(ifers: [ifer], elser: Elser.emptyElser);

  void cancelAllException() {
    ifers.forEach((element) {
      element.cancelAllException();
    });
    elser.cancelAllException();
  }

  Future<void> handle({
    required Future<bool> Function(Ifer ifer, String condition) conditionChecker,
    required Future<void> Function(Ifer ifer, String use) useChecker,
    required Future<void> Function(Elser elser, String use) elseChecker,
  }) async {
    for (int i = 0; i < ifers.length; i++) {
      final iferResult = await ifers[i].handle(conditionChecker: conditionChecker, useChecker: useChecker, elseChecker: elseChecker);
      if (iferResult) {
        return;
      }
    }
    await elser.handle(conditionChecker: conditionChecker, useChecker: useChecker, elseChecker: elseChecker);
  }

  List<Widget> toWidget({required AlgorithmWrapper algorithmWrapper}) {
    return [
      for (int i = 0; i < ifers.length; i++) ifers[i].toWidget(isElseIf: i != 0, father: this, algorithmWrapper: algorithmWrapper),
      elser.toWidget(father: this, algorithmWrapper: algorithmWrapper),
    ];
  }

  void remove({required Ifer ifer}) {
    ifers.remove(ifer);
    if (ifers.isEmpty) {
      ifers.add(Ifer.emptyIfer);
    }
  }
}
