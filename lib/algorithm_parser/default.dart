/// 碎片展示时，将按照以下顺序执行算法：
/// 1. 根据熟悉度算法，得到 show_familiar
/// 2. 根据按钮数值算法，得到每个按钮的数值
/// 3. 根据下一次展示时间点算法，得到 next_show_time
///
/// 1-0.56*(t^0.06)
const String default1 = '''

if: true 
use: 1-0.56*(t^0.06)

''';
