part of algorithm_parser;

/// [conditionUse] 和 [ifElseUseWrapper] 二选一。
@JsonSerializable()
class Ifer {
  Ifer({
    required this.condition,
    required this.use,
    required this.ifElseUseWrapper,
    required this.explain,
  });

  final String condition;
  final String? use;
  final IfElseUseWrapper? ifElseUseWrapper;
  final String? explain;

  factory Ifer.fromJson(Map<String, dynamic> json) => Ifer(
        condition: json["condition"] as String,
        use: json["use"] as String?,
        ifElseUseWrapper: json["if_else_use_wrapper"] == null ? null : IfElseUseWrapper.fromJson(json["if_else_use_wrapper"]),
        explain: json["explain"] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "condition": this.condition,
        "use": this.use,
        "if_else_use_wrapper": this.ifElseUseWrapper,
        "explain": this.explain,
      };

  Future<bool> handle({
    required Future<bool> Function(String condition) conditionChecker,
    required Future<void> Function(String use) useChecker,
  }) async {
    final isTrue = await conditionChecker(condition);
    if (isTrue) {
      if (use != null) {
        await useChecker(use!);
      } else {
        final childrenIfer = ifElseUseWrapper!.ifers;
        for (int i = 0; i < childrenIfer.length; i++) {
          final childrenIferResult = await childrenIfer[i].handle(conditionChecker: conditionChecker, useChecker: useChecker);
          if (childrenIferResult) {
            return childrenIferResult;
          }
        }
        return await ifElseUseWrapper!.elser.handle(conditionChecker: conditionChecker, useChecker: useChecker);
      }
    }

    return isTrue;
  }
}

/// [use] 和 [ifElseUseWrapper] 二选一。
@JsonSerializable()
class Elser {
  Elser({
    required this.use,
    required this.ifElseUseWrapper,
    required this.explain,
  });

  final String? use;
  final IfElseUseWrapper? ifElseUseWrapper;
  final String? explain;

  factory Elser.fromJson(Map<String, dynamic> json) => Elser(
        use: json["use"] as String?,
        ifElseUseWrapper: json["if_else_use_wrapper"] == null ? null : IfElseUseWrapper.fromJson(json["if_else_use_wrapper"]),
        explain: json["explain"] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "use": this.use,
        "if_else_use_wrapper": this.ifElseUseWrapper,
        "explain": this.explain,
      };

  Future<bool> handle({
    required Future<bool> Function(String condition) conditionChecker,
    required Future<void> Function(String use) useChecker,
  }) async {
    if (use != null) {
      await useChecker(use!);
      return true;
    } else {
      final childrenIfer = ifElseUseWrapper!.ifers;
      for (int i = 0; i < childrenIfer.length; i++) {
        final childrenIferResult = await childrenIfer[i].handle(conditionChecker: conditionChecker, useChecker: useChecker);
        if (childrenIferResult) {
          return childrenIferResult;
        }
      }
      return ifElseUseWrapper!.elser.handle(conditionChecker: conditionChecker, useChecker: useChecker);
    }
  }
}

@JsonSerializable()
class IfElseUseWrapper {
  IfElseUseWrapper({
    required this.ifers,
    required this.elser,
  });

  final List<Ifer> ifers;
  final Elser elser;

  factory IfElseUseWrapper.fromJson(Map<String, dynamic> json) => IfElseUseWrapper(
        ifers: (json["ifers"] as List<dynamic>).map((e) => Ifer.fromJson(e as Map<String, dynamic>)).toList(),
        elser: Elser.fromJson(json["elser"]),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "ifers": this.ifers,
        "elser": this.elser,
      };

  Future<void> handle({
    required Future<bool> Function(String condition) conditionChecker,
    required Future<void> Function(String use) useChecker,
  }) async {
    for (int i = 0; i < ifers.length; i++) {
      final iferResult = await ifers[i].handle(conditionChecker: conditionChecker, useChecker: useChecker);
      if (iferResult) {
        return;
      }
    }
    await elser.handle(conditionChecker: conditionChecker, useChecker: useChecker);
  }
}

@JsonSerializable()
class CustomVariable {
  CustomVariable({
    required this.name,
    required this.content,
    required this.explain,
  });

  final String name;
  final String content;
  final String? explain;

  factory CustomVariable.fromJson(Map<String, dynamic> json) => CustomVariable(
        name: json["name"],
        content: json["content"],
        explain: json["explain"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": this.name,
        "content": this.content,
        "explain": this.explain,
      };
}

@JsonSerializable()
class AlgorithmWrapper {
  AlgorithmWrapper({
    required this.customVariables,
    required this.ifElseUseWrapper,
  });

  final List<CustomVariable> customVariables;
  final IfElseUseWrapper ifElseUseWrapper;

  final customVariablesMap = <String, String>{};

  factory AlgorithmWrapper.fromJson(Map<String, dynamic> json) => AlgorithmWrapper(
        customVariables: (json["custom_variables"] as List<dynamic>).map((e) => CustomVariable.fromJson(e as Map<String, dynamic>)).toList(),
        ifElseUseWrapper: IfElseUseWrapper.fromJson(json["if_else_use_wrapper"]),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "custom_variables": this.customVariables,
        "if_else_use_wrapper": this.ifElseUseWrapper,
      };

  static fromJsonString(String content) => AlgorithmWrapper.fromJson(jsonDecode(content));

  String toJsonString() => jsonEncode(toJson());

  AlgorithmWrapper copy() => AlgorithmWrapper.fromJson(this.toJson());
}
