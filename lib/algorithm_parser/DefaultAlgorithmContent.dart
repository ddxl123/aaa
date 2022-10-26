part of algorithm_parser;

/// TODO: 对算法内容添加函数功能，例如 max(a,b,c)，if_else(a,b,c,d)

/// 碎片展示时，将按照以下顺序执行算法：
/// 1. 根据熟悉度算法，得到 show_familiar
/// 2. 根据按钮数值算法，得到每个按钮的数值
/// 3. 根据下一次展示时间点算法，得到 next_show_time
///
/// 艾宾浩斯记忆曲线：1-0.56*(t^0.06)
/// t 单位：分钟

class DefaultAlgorithmContent {
  /// [FamiliarityState]
  final String defaultFamiliarContent = '''
if: true
use: times-1
else: throw defaultFamiliarContent 执行了throw
''';

  /// [ButtonDataState]
  final String defaultButtonDataContent = '''
if: true
<--1-熟悉 0-陌生-->
use: 1,0
else: throw defaultButtonDataContent 执行了throw
''';

  /// [NextShowTimeState]
  final String defaultNextShowTimeContent = '''
if: true
use: ${InternalVariableConstant.clickValueConst.name}
else: throw defaultNextShowTimeContent 执行了throw
''';
}
