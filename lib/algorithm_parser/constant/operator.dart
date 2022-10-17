part of algorithm_parser;

const oLogicalOperator = [
  '|',
  '&',
];
const oRelationalOperator = [
  '==',
  '!=',
  '<=',
  '>=',
  '<',
  '>',
];

const oLogicalOperatorRegExp = [
  '\\|',
  '&',
];
const oRelationalOperatorRegExp = [
  '==',
  '!=',
  '<=',
  '>=',
  '<',
  '>',
];

const emptyMergeOperator = '??';

const emptyMergeOperatorRegExp = r'\?\?';

/// 不包含 [emptyMergeOperator]
List<String> get allOperator => const [
      ...oLogicalOperator,
      ...oRelationalOperator,
    ];

/// 不包含 [emptyMergeOperatorRegExp]
List<String> get allOperatorRegExp => const [
      ...oLogicalOperatorRegExp,
      ...oRelationalOperatorRegExp,
    ];
