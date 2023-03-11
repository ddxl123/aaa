library algorithm_parser;

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:aaa/algorithm_parser/AlgorithmException.dart';
import 'package:aaa/page/edit/MemoryModelGizomoEditPage/MemoryModelGizmoEditPageAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:tools/tools.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

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

part 'DefaultAlgorithmContent.dart';

part 'enums.dart';

part 'explain.dart';

part 'algorithm_wrapper/AlgorithmWrapper.dart';

part 'algorithm_wrapper/Ifer.dart';

part 'algorithm_wrapper/Elser.dart';

part 'algorithm_wrapper/IfElseUseWrapper.dart';

part 'algorithm_wrapper/CustomVariabler.dart';

part 'name_convention.dart';
