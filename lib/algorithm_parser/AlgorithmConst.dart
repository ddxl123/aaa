part of algorithm_parser;

class AlgorithmConst {
  AlgorithmConst._();

  static const logicalOperator = [
    '|',
    '&',
  ];
  static const relationalOperator = [
    '==',
    '!=',
    '<=',
    '>=',
    '<',
    '>',
  ];

  static const logicalOperatorRegExp = [
    '\\|',
    '&',
  ];
  static const relationalOperatorRegExp = [
    '==',
    '!=',
    '<=',
    '>=',
    '<',
    '>',
  ];

  static List<String> get allOperator => const [
        ...logicalOperator,
        ...relationalOperator,
      ];

  static List<String> get allOperatorRegExp => const [
        ...logicalOperatorRegExp,
        ...relationalOperatorRegExp,
      ];
}
