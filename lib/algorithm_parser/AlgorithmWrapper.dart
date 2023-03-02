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

  factory AlgorithmWrapper.fromJson(Map<String, dynamic> json) => AlgorithmWrapper(
        customVariables: (json["custom_variables"] as List<dynamic>).map((e) => CustomVariable.fromJson(e as Map<String, dynamic>)).toList(),
        ifElseUseWrapper: IfElseUseWrapper.fromJson(json["if_else_use_wrapper"]),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "custom_variables": this.customVariables,
        "if_else_use_wrapper": this.ifElseUseWrapper,
      };

  AlgorithmWrapper copy() => AlgorithmWrapper.fromJson(this.toJson());
}
