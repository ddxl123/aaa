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

const oEmptyMergeOperator = '??';

const oEmptyMergeOperatorRegExp = r'\?\?';

/// 不包含 [oEmptyMergeOperator]
List<String> get allOperator => const [
      ...oLogicalOperator,
      ...oRelationalOperator,
    ];

/// 不包含 [oEmptyMergeOperatorRegExp]
List<String> get allOperatorRegExp => const [
      ...oLogicalOperatorRegExp,
      ...oRelationalOperatorRegExp,
    ];
