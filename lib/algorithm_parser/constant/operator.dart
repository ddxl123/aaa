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

Set<String> get allOperator => const {
      ...oLogicalOperator,
      ...oRelationalOperator,
    };

Set<String> get allOperatorRegExp => const {
      ...oLogicalOperatorRegExp,
      ...oRelationalOperatorRegExp,
    };
