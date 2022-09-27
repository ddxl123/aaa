part of algorithm_parser;

///
/// [分段变量]：
///
/// 每次点击按钮后，都会将 [分段常量] 设置为新值，之后将会根据新的数学函数进行熟悉度的曲线计算。
/// 注意，算法结构并不会发生改变，只是刷新了 [分段常量] 的值。
///
/// <在刚展示时获取>
/// count_all：当前记忆组碎片数量
/// count_new：本次展示前，当前记忆组剩余的新碎片数量
/// start_time：记忆组启动的时间点
///   - 数值类型：以秒为单位的时间戳
/// times：本次是第几次展示。
///   - 单位：次数
///   - 数值类型：正整数（1，2，3...）
///   - 获取方式：检索指定的 [FragmentMemoryInfos] 的数量。
/// actual_show_time：本次实际展示的时间点
///   - 数值类型：以秒为单位的时间戳
///   - 获取方式：[FragmentMemoryInfos.actualShowTime]。
/// planed_show_time：本次原本计划展示的时间点
///   - 数值类型：以秒为单位的时间戳
///   - 获取方式：[FragmentMemoryInfos.planedShowTime]。
/// click_familiar：本次刚展示时的熟悉度。
///   - 初始值：默认为0，用户可能会手动分配初始值。
///   - 数值类型：任意实数
///   - 获取方式：[FragmentMemoryInfos.clickFamiliarity]。
///
/// <在点击按钮时获取>
/// click_time：本次点击按钮时的时间点
///   - 数值类型：以秒为单位的时间戳
///   - 获取方式：[FragmentMemoryInfos.clickTime]。
/// click_value：本次点击按钮的按钮数值
///   - 数值类型：任意实数
///   - 获取方式：[FragmentMemoryInfos.clickValue]。
///
/// 获取第n次展示的某个变量数据：
///   - 第n次的变量名：当前变量名加上'_n'后缀
///     - 例如：第一次 click_value_1，第二次 click_value_2，第n次 click_value_n...
///     - 简写：第一次 c_v，第二次 c_v_1，上n次 c_v_n...
///   - 若第n次恰好是本次点击按钮后的次数，则第n次等价于本次。
///     - 例如：本次是第3次，那么 click_value_3 等价于本次。
///   - 若第n次不存在，则可用 [n??数值] 来充当不存在的值。
///     - 例如，click_value_2??123 的含义为：当 click_value_2 不存在时，将使用 123 进行代替。
///     - ??后的数值类型必须与??前的数值类型相同。
/// 获取上n次点击按钮后的某个变量：
///   - 上n次的变量名：当前变量名加上'_recentn'后缀。
///     - 例如：本次 click_value，上一次 click_value_recent1，上两次 click_value_recent2，上n次 click_value_recentn...
///     - 简写：本次 c_v，上一次 c_v_r1，上两次 c_v_r2，上n次 c_v_rn...
///   - 若上n次不存在，则可用 [n??数值] 来充当不存在的值。
///     - 例如，click_value_recent3??123 的含义为：当 click_value_recent3 不存在时，将使用 123 进行代替。
/// 注意：
///   1. 使用第n次/上n次的数据时，
///       - <在刚展示时获取>：第n次/上n次会为空
///       - <在点击按钮时获取>：第n次/上n次不会为空
///   2. 前缀为 global 的变量无法使用 '_n' 后缀。
///
/// <自定义变量>
///
/// 用户可以自定义变量，自定义变量可以嵌入其他任意变量，也可嵌入其他自定义变量。
/// - 注意：
///   1. 自定义变量的名称不能与已存在变量的名称相同。
///   2. 自定义A变量嵌入自定义B变量时，B变量必须在A变量定义之前进行定义。
/// - 例如：
///     - 现有自定义变量 time_interval，
///     - 可令 time_interval = click_time(内置变量) - click_time_recent1(内置变量)
///       - 那么，该 time_interval 变量的含义为：本次点击按钮后的时间点与上一次点击按钮后的时间点的时间差。
///     - 又或者令 ti = time_interval(自定义变量)，令 ct = click_time(内置变量)
///       - 这样可以将长单词进行简写。
/// - 自定义变量名命名规范：
///   1. 不能与已有变量名相同。
///   2. 可以使用任意汉字、字母、符号等来命名，其中符号不能为等于号'='。
///
/// <常量>
///
/// pi：3.1415926
/// e：2.7182818
///
///
/// 说明：
///   1. [自定义变量语句] 放在上方，[if-use语句] 放在下方。
///       - 不能更换顺序，也不能混杂。
///   2. [自定义变量语句] 书写规范：
///       - 每个 [自定义变量语句] 的结尾必须加上 ";"。
///           - 正确示范1：custom_value = 666;custom_value = 123;（可以放在同一行上，也可以将两个定义放在不同行上）
///           - 错误示范1：custom = 123；(分号必须是小写的";"，而不是"；")
///       - 变量名只能使用字母、数字、-、_、$来命名。
///           - 正确示范1：if_custom_value = 666;
///           - 正确示范2：123custom = 666;
///       - 不能直接命名为 "if"、"use"等内置关键字。
///           - 错误示范2：if = 666;
///           - 正确示范1：custom_if = 666;
///       - 变量名不能使用已存在的变量名（无论是内置的还是自定义过的）
///       - 可以在变量名的前后位置添加空格，但不能让变量名的字符之间含有空格。
///           - 正确示范1：custom_value = -6666.6;
///           - 正确示范2：   custom_value   =-66666;
///           - 正确示范3：custom_value = - 66 6  6.6;
///           - 错误示范1：custom val   ue = 123;
///       - 自定义变量的值可以引用其他变量（无论是内置的还是自定义过的）。
///           - 正确示范1：custom_1 = 666;
///                      custom_2 = click_value;（click_value为系统变量）
///                      custom_3 = custom_1 + custom_2;
///                      custom_4 = custom_3 + custom_2;
///           - 错误示范1：custom_1 = 666;
///                      custom_3 = custom_1 + custom_2;（custom_2的定义必须在custom_3的前面位置进行定义）
///                      custom_2 = click_value;
///                      custom_4 = custom_3 + custom_2;
///   3.[if-use语句] 书写规范：
///       - 不支持嵌套 if。
///       - 先判断括号内的语句，后判断括号外的语句。
///       - 若条件都不满足时，系统将自动提示用户，并向用户提供数据值。
///       - if 与 use 后必须带":"。（是小写的":"，不是"："）
///       - if-use 语句后不需要带";"。
///       - if 内不能进行计算，因此像 sin(pi) 哪怕值是常量 0，也仍然需要在自定义变量中重新定义，而在 use 内可以。
///           - 正确示范1：custom = sin(pi);
///                      ===
///                      if: custom==0
///                      use: 1-0.56 * custom^0.06+sin(pi)
///           - 错误示范1：if: sin(pi)==0
///                      use: 1-0.56 * (sin(pi))^0.06
///       - 如果值为空（null），则可以这样进行判断：
///           - 正确示范1：if: custom==null
///                     - 含义：如果 custom 为 null...
///   4. [注释] 书写规范：
///       - 使用 <-- 与 --> 包裹起来。
///         - 正确示范1：<--这是个注释-->
///       - 注释内容不能含有 <-- 或 -->，且暂未提供转义字符，因此若注释内容想要存在这两个字符，则请更换其他字符进行代替。
///         - 错误示范1：<--这是个<--注释-->-->
///         - 错误示范2：<--这是个-->注释-->
///         - 正确示范1：<--注释内容可以存在"->"、"<-"，因为它和两个横杠的符号不冲突-->
///       - 注释符号间不能加其他字符。
///         - 错误示范1：<- -注释符号中不能参杂任何其他字符，包括空格-->
///       - 注释内不能存在连续10个"="。
///       - 除了以上，注释里可以写任何内容。
///   4. 运算符规范：
///       - 赋值运算符：
///           - 赋值：=
///             - 解释：a = 1，将1这个值赋予给a;
///                    b = a，将a这个值赋予给b;
///                    以上即 a=b=1。
///           - 空赋值：??=
///             - 解释：a ??= 1;
///                   当 a 不存在时，a 被赋值为 1。
///             - 用途：通常用在 xxx_n 中。
///
///       - 算术运算符：
///           - 加：+
///           - 减：-
///           - 乘：*
///           - 除：/
///           - 乘方：^
///       - 逻辑运算符：
///           - 或：|
///             - 解释：在 R = A|B 中，A 或 B只要存在一个是 true 的，则 R 便是 ture，否则 R 为 false。
///           - 且：&
///             - 解释：在 R = A&B 中，只有 A 与 B 同时为 true 时，R 才为 ture，否则 R 为 false。
///           - 非：!
///             - 解释：当 R 为 true 时，!R 为 false；当 R 为 false 时，!R 为 true。
///       - 关系运算符：
///           - 是否相等：==
///           - 是否不相等：!=
///           - 是否大于：>
///           - 是否小于：<
///           - 是否大于等于：>=
///           - 是否小于等于：<=
///
/// 正确示范：
/// ```
///
/// <--所有地方都可以写注释，但是注释内不能有注释符号-->
/// <--
/// 注释内容也
/// 可以被换行。
/// -->
/// custom_1 = 123;<--注释也可以写在这里-->
/// custom_2 = cu<--注释甚至可以写在这里，会自动将两边字母粘合-->stom_1;
/// add_result = custom_1 +<--注释甚至可以写在这里--> custom_2;
///
/// if:
///   <--如果 add_result 大于 0 -->
///   add_result>0
/// use:
///   <--则使用下面这个公式-->
///   1-0.56 * click_time^0.06
///
/// if:
///   <--如果 add_result+1 为 0，或者， custom_1 不等于 666 且 custom_2 小于等于 1000-->
///   add_result+1 == 0 | (custom_1 != 666 & custom_2 <= 888+112)
/// use:
///   <--则使用下面这个公式-->
///   1-(0.56 * (add_result??3.5 + 1.2^custom_1)) / sin(custom_2)
///
/// if:
///   <可以变量与变量之间进行判断>
///   add_result > custom_1
/// use:
///   <--公式可以直接为数字计算，如下即为 y=6 这条曲线-->
///   1+2+3
///
/// if:
///   <--可以数值与数值之间进行判断-->
///   666==666
/// use:
///   <--公式可以直接为数字，如下即为 y=666.6 这条曲线-->
///   666.6
/// else:
///   <--
///   以上所有 if 都不满足条件时，选用 else 的结果
///   如果并没有 else 指示，请使用 :
///   "else: throw 描述"
///   -->
///   123
///
///```
///
/// Variable x = Variable('x');
/// Variable y = Variable('y');
/// ContextModel cm = ContextModel()
///   ..bindVariable(x, Number(2.0))
///   ..bindVariable(y, Number(5));
/// Expression exp = Parser().parse(c.textEditingController.text);
/// print(exp.evaluate(EvaluationType.REAL, cm));
mixin Explain {}