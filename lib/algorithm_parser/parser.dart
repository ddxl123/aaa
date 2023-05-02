library algorithm_parser;

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:aaa/algorithm_parser/AlgorithmException.dart';
import 'package:aaa/page/edit/MemoryModelGizomoEditPage/MemoryModelGizmoEditPageAbController.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

part 'constant/keyword.dart';

part 'constant/operator.dart';

part 'constant/other.dart';

part 'internal_variable/InternalVariableStorage.dart';

part 'internal_variable/InternalVariableConstant.dart';

part 'parser/AlgorithmParser.dart';

part 'parser/EmptyMergeParser.dart';

part 'parser/IfExprParse.dart';

part 'parser/RegExper.dart';

part 'state/abstract.dart';

part 'state/ButtonDataState.dart';

part 'state/FamiliarityState.dart';

part 'state/NextShowTimeState.dart';

part 'enums.dart';

part 'explain.dart';

part 'algorithm_wrapper/AlgorithmBidirectionalParsing.dart';

part 'algorithm_wrapper/AlgorithmWrapper.dart';

part 'algorithm_wrapper/Ifer.dart';

part 'algorithm_wrapper/Elser.dart';

part 'algorithm_wrapper/IfElseUseWrapper.dart';

part 'algorithm_wrapper/CustomVariabler.dart';

part 'name_convention.dart';

/// TODO: 对算法内容添加函数功能，例如 max(a,b,c)，if_else(a,b,c,d)
