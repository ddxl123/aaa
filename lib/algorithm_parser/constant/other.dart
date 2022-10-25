part of algorithm_parser;

const oEmptyMergeOperator = '??';

const oEmptyMergeOperatorRegExp = r'\?\?';

const lineComment = r'\\';

const lineCommentExp = r'\\\\';

const leftBlockComment = '/*';

const leftBlockCommentExp = r'\/\*';

const rightBlockComment = '*/';

const rightBlockCommentExp = r'\*\/';

Set<String> get comments => <String>{
      lineComment,
      leftBlockComment,
      rightBlockComment,
    };
