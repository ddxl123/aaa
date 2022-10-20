part of algorithm_parser;

class AlgorithmParser<CS extends ClassificationState> with Explain {
  AlgorithmParser({this.isDebugPrint = true});

  /// 空赋值：name-计算表达式
  // final _emptyMergeVariables = <String, String>{};

  final ContextModel cm = ContextModel();

  bool _isParsed = false;

  late final CS state;

  static const nullTag = '_tag_null_tag_';

  bool isDebugPrint;

  StringBuffer debugPrintStringBuffer = StringBuffer();

  String? throwMessage;

  void debugPrint({required String content, StackTrace? st}) {
    if (isDebugPrint) {
      final currentSt = RegExper.consolePrint.allMatches(StackTrace.current.toString()).first.group(0);
      debugPrintStringBuffer.write('\n>>>\n$content\n${currentSt?.substring(2, currentSt.length - 2).trim()}\n');
      if (st != null) {
        debugPrintStringBuffer.write('\nthrow:\n$st\n');
        throwMessage = content;
      }
    }
  }

  /// 计算
  double calculate(String content) {
    try {
      return Parser().parse(content).evaluate(EvaluationType.REAL, cm);
    } catch (e, st) {
      throw '解析失败：$content\n$e';
    }
  }

  Future<AlgorithmParser<CS>> parse({required CS state}) async {
    try {
      if (_isParsed) throw '每个 AlgorithmParser 实例只能使用一次 parse！若想多次使用，则需要创建多个 AlgorithmParser 实例。';
      _isParsed = true;
      if (InternalVariableConstant.getAllKV.isEmpty) throw '请先初始化内置变量！';

      this.state = state;

      debugPrint(content: '【开始解析 ${state.getStateType}...】');

      String content = state.content;
      content = _clearAnnotated(content);
      content = content.toLowerCase();

      // 分离变量定义与 if-use-else 语句。
      final ifIndex = content.indexOf('if:');
      if (ifIndex == -1) throw '缺少 "if:" 语句！';
      // 变量定义部分。
      final definitionPart = content.substring(0, ifIndex);
      // if-use-else 语句部分。
      final ifUseElsePart = content.substring(ifIndex);
      debugPrint(content: '- 自定义变量的定义部分：\n$definitionPart\n- if-use-else 语句部分: \n$ifUseElsePart');

      content = _definitionVariablesBindAndObtain(definitionPart: definitionPart, ifUseElsePart: ifUseElsePart);
      content = await _internalVariablesBindAndObtain(content: content);
      content = _emptyMergeEval(content: content);

      _ifUseElseParse(content: ifUseElsePart);
    } catch (e, st) {
      debugPrint(content: '$e\n已绑定 cm：${cm.variables.keys.toString()}', st: st);
    }
    logger.i(debugPrintStringBuffer);
    return this;
  }

  /// 去掉全部注释
  String _clearAnnotated(String content) {
    debugPrint(content: '正在清除注释...');
    final result = content.replaceAll(RegExper.annotation, '');
    debugPrint(content: '清除注释成功，清除后：\n$result');
    return result;
  }

  /// 空合并评估
  String _emptyMergeEval({required String content}) {
    debugPrint(content: '正在评估空合并运算符...');
    final result = EmptyMergeParser().parse(content: content);
    debugPrint(content: '空合并评估成功！');
    return result;
  }

  /// 扫描使用到的内置变量，获取内置变量的值，替换结果值。
  Future<String> _internalVariablesBindAndObtain({required String content}) async {
    debugPrint(content: '正在评估内置变量...');
    if (InternalVariableConstant.getAllNames.isEmpty) throw '初始内置变量为 empty！';

    // 内置变量：对应的结果值
    final internalVariable2Results = <String, num?>{};

    for (var match in RegExper.ivcOrNSuffix.allMatches(content)) {
      final fullName = match.group(0)!;
      String simplifyName = fullName;
      NTypeNumber? nTypeNumber;
      debugPrint(content: '解析出变量：$fullName');
      final nMatch = RegExper.nSuffix.firstMatch(fullName);
      if (nMatch != null) {
        final nMatchStr = nMatch.group(0)!;
        simplifyName = fullName.substring(0, nMatch.start);
        final nTypeMatch = RegExper.nTypeNames.firstMatch(nMatchStr);
        final nType = NType.values.where((element) => element.name.split(',').last == nTypeMatch!.group(0)!).first;
        final number = int.parse(nMatchStr.substring(nType.name.split('.').last.length + 1, nMatchStr.length));
        nTypeNumber = NTypeNumber(nType: nType, suffixNumber: number);
      }
      Future<num?> getResult() async => await state.internalVariablesResultHandler(
            InternalVariableAtom(
              internalVariableConst: InternalVariableConstant.getConstByName(simplifyName),
              nTypeNumber: nTypeNumber,
            ),
          );
      // 相同的变量名值只绑定一次。
      if (internalVariable2Results.containsKey(fullName)) {
        if (internalVariable2Results[fullName] == null) {
          internalVariable2Results[fullName] = await getResult();
        }
      } else {
        internalVariable2Results.addAll({fullName: await getResult()});
      }
      debugPrint(content: '获取内置变量结果值：$fullName = ${internalVariable2Results[fullName]}');
    }
    final replaceResult = content.replaceAllMapped(
      RegExper.ivcOrNSuffix,
      (match) {
        final result = internalVariable2Results[match.group(0)!];
        return result != null ? result.toString() : nullTag;
      },
    );
    debugPrint(content: '内置变量结果值替换结果：$replaceResult');
    debugPrint(content: '评估内置变量成功！');
    return replaceResult;
  }

  /// 绑定并获取自定义变量值。
  ///
  /// 因为内置变量已经被空赋值了，因此自定义变量始终不为 null，即自定义变量无需空赋值。
  String _definitionVariablesBindAndObtain({required String definitionPart, required String ifUseElsePart}) {
    debugPrint(content: '正在评估自定义变量...');
    final name2Value = <String, String>{};
    final semicolonSplit = definitionPart.trim().split(';');
    for (var assign in semicolonSplit) {
      // 最后一个';'会出现空字符，同时也可以解决连续分号 ';;;' 的问题。
      final assignTrim = assign.trim();
      if (assignTrim == '') continue;
      final eSep = assignTrim.split('=');
      if (eSep.length != 2) {
        if (eSep.isEmpty || eSep.length == 1) {
          throw '需要对自定义变量进行赋值：$assignTrim';
        } else {
          throw '多个自定义变量间需要使用";"隔开：$assignTrim';
        }
      }

      final name = checkNameConvent(name: eSep.first.trim());
      final value = eSep.last.trim().replaceAllMapped(RegExp(name2Value.keys.toList().map((e) => '($e)').join('|')), (match) {
        debugPrint(content: 'match: ${RegExp(['1'].toList().map((e) => '($e)').join('|')).pattern}');
        debugPrint(content: 'match: ${name2Value}');
        debugPrint(content: 'match: ${match.group(0)}');
        return name2Value[match.group(0)!]!;
      });
      if (name2Value.containsKey(name)) {
        throw '自定义变量名不能重复：$name';
      }
      name2Value.addAll({name: value});
    }
    final result = ifUseElsePart.replaceAllMapped(RegExp(name2Value.keys.map((e) => '($e)').join('|')), (match) => '(${name2Value[match.group(0)!]!})');
    debugPrint(content: '评估自定义变量结果：\n$result');
    debugPrint(content: '评估自定义变量成功！');
    return result;
  }

  /// if-use-else 语句解析。
  void _ifUseElseParse({required String content}) {
    debugPrint(content: '正在评估 if-use-else 语句...');
    final elseMatches = RegExper.elseKeyword.allMatches(content);
    if (elseMatches.isEmpty) throw '缺少 "else:" 语句！若不想使用 "else:" 语句，请使用 "else: throw 说明" 来进行异常处理！（程序会解析"说明"信息并展示给用户查看）';
    final elseMatch = elseMatches.first;
    final elseContent = content.substring(elseMatch.end, content.length).trim();
    if (elseContent == '') throw '"else:" 语句不能为空！';
    debugPrint(content: 'else 内容：\n$elseContent');
    final ifUseContent = content.substring(0, elseMatch.start).trim();
    debugPrint(content: 'if-use 内容：\n$ifUseContent');
    final ifUses = ifUseContent.split('if:');
    if (ifUses.length == 1) throw '缺少 "if:" 语句！';
    // 去掉第一个 'if:' 前的空白。
    ifUses.removeAt(0);
    for (var iu in ifUses) {
      debugPrint(content: '解析出 -use:- 内容：\n$iu');
      final iuTrim = iu.trim();
      if (iuTrim == '') throw '不规范使用 if-use 语句！';
      if (!iuTrim.contains('use:')) throw '缺少 "use:" 语句：$iuTrim';
      final i2u = iuTrim.split('use:');
      if (i2u.length != 2) throw '不规范使用 if 语句：$iuTrim';
      final i = i2u.first.trim();
      debugPrint(content: '解析出 if 内容：\n$i');
      if (i == '') throw '"if:" 语句内容不能为空：$iuTrim';
      final u = i2u.last.trim();
      debugPrint(content: '解析出 use 内容：\n$u');
      if (u == '') throw '"use:" 语句内容不能为空：$iuTrim';
      if (_ifParse(content: i)) {
        _useParse(content: u);
        debugPrint(content: '所使用的 use 语句：$u\n计算结果：${state.toStringResult()}');
        return;
      }
    }
    if (elseContent.contains('throw')) throw elseContent.substring(elseContent.indexOf('throw') + 5, elseContent.length);
    debugPrint(content: '所有 if 语句都不匹配，已执行 else 语句：$elseContent');
    _useParse(content: elseContent);
    debugPrint(content: 'else 语句计算结果：${state.toStringResult()}');
  }

  /// 解析 if 语句。
  bool _ifParse({required String content}) {
    return IfExprParse().parse(content: content, algorithmParser: this);
  }

  /// 解析 use 语句。
  void _useParse({required String content}) {
    state.parse(content: content, algorithmParser: this);
  }
}
