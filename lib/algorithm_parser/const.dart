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

List<String> get allOperator => const [
      ...oLogicalOperator,
      ...oRelationalOperator,
    ];

List<String> get allOperatorRegExp => const [
      ...oLogicalOperatorRegExp,
      ...oRelationalOperatorRegExp,
    ];
