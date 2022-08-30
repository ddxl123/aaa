part of drift_db;

const List<Type> cloudTableClass = [
  Users,
  Fragments,
  FragmentGroups,
  MemoryGroups,
  MemoryModels,
  FragmentMemoryInfos,
];

@ReferenceTo([])
class Users extends CloudTableBase {
  TextColumn get username => text()();

  TextColumn get password => text()();

  TextColumn get email => text()();

  IntColumn get age => integer()();
}

@ReferenceTo([])
class Fragments extends CloudTableBase {
  /// 父碎片（该碎片是由哪个碎片修改而来）
  ///
  /// 若为 null，则自身为根节点。
  @ReferenceTo([Fragments])
  TextColumn get fatherFragmentId => text().nullable()();

  TextColumn get title => text()();

  /// 优先级/高频程度。
  ///
  /// 数字越大，优先级越高，不能为负数。
  IntColumn get priority => integer()();
}

@ReferenceTo([])
class FragmentGroups extends CloudTableBase {
  @ReferenceTo([FragmentGroups])
  TextColumn get fatherFragmentGroupId => text().nullable()();

  TextColumn get title => text()();
}

/// 当前
///  新学数量[newLearnCount]：[100]个 剩余100
///  复习数量：300个 剩余300
///   1. 取用接下来[24h][takeReviewInterval]内的复习量（包含曾逾期的碎片）
///  展示优先级：[newReviewDisplayOrder]
///
/// 总学习量：共400个碎片 剩余400
///
/// 熟练度清零：[点击清零]
///    - [选择] 不清零在其他碎片组中正在学习的。
///    - 清零后，会将其碎片的熟练度降至0
///
/// 将[熟练度高于0.8][filterOut]的碎片视为完全掌握状态，将不会在当前记忆组中出现。（可写入算法）
@ReferenceTo([])
class MemoryGroups extends CloudTableBase {
  @ReferenceTo([MemoryModels])
  TextColumn get memoryModelId => text().nullable()();

  TextColumn get title => text()();

  IntColumn get type => intEnum<MemoryGroupType>()();

  IntColumn get status => intEnum<MemoryGroupStatus>()();

  /// 新学数量
  IntColumn get newLearnCount => integer()();

  /// 取用 [reviewInterval] 时间点内的复习碎片。
  DateTimeColumn get reviewInterval => dateTime()();

  /// 过滤碎片
  TextColumn get filterOut => text()();

  /// 新旧碎片展示先后顺序。
  IntColumn get newReviewDisplayOrder => intEnum<NewReviewDisplayOrder>()();

  /// 新碎片展示先后顺序。
  IntColumn get newDisplayOrder => intEnum<NewDisplayOrder>()();

  /// 悬浮碎片是否立即触发音频/特效/振动等。
}

@ReferenceTo([])
class MemoryModels extends CloudTableBase {
  TextColumn get title => text()();

  /// 熟悉度算法。用来计算碎片的熟悉度的数学函数，
  ///
  /// 每次展示并点击按钮后，将输入以下变量，计算出新的熟悉度函数曲线，并提供给 [nextTimeAlgorithm] 进行下一次展示时间点的计算。
  /// 注意：是 [每次展示并点击按钮后，将输入以下变量]，而非 [每次点击按钮前，或每次展示前，或每次展示后且点击按钮前...]。
  ///
  /// f(t) 是一个以 t 为[自变量]，以 c、b、f 为[分段变量]，以 rt 为[分段聚合变量]的函数。
  ///
  /// f(t)：熟悉度函数
  ///   - 数值类型：任意实数
  ///   1. 一般来讲，若熟悉度的范围为0%~100%，则需要将其写成 0~1，或 0~1.0。例如，熟悉度 50%，则需要写成 0.5，否则无法解析。
  ///   2. 即使熟悉度可能存在范围，但它仍然可以超出范围，例如 -0.5, 1.5...
  ///   3. 若想使熟悉度维持在范围之内，则需要将算法进行优化。例如，在 f(t)=sin(t) 的函数图像中，只要在 0≤t≤pi 范围内，其本身就会被限制在 0≤f(x)≤1。
  ///   4. "熟悉度"函数曲线的含义不一定非得是对碎片的熟悉程度曲线——f(t)随时间的增大而减小。也可以改变它的含义，例如"熟悉度"函数曲线也可以代表着遗忘程度曲线——f(t)随时间的增大而增大。
  ///   5. 总结：你想让函数曲线是什么样子就可以是什么样子，你想让函数值为多少就可以是多少，
  ///      下面所提供的 [分段变量]、[分段聚合变量]、[分段未来变量]、[分段未来聚合变量] 将大大地提高用户自定义曲线的灵活度。
  ///      分段变量：每次点击按钮后的一瞬间所分配的非计算数值。
  ///      分段聚合变量：每次点击按钮后的一瞬间所分配的需要聚合其他数据来计算出结果的结果数值。
  ///
  /// t（自变量）：流逝的时间
  ///   - 从记忆组启动时开始流逝。
  ///   - 初始值：0
  ///   - 单位：秒
  ///   - 数值类型：自然数（0，1，2，3...）
  ///
  /// c（分段变量）：当前是第几次展示。
  ///   - 单位：次数
  ///   - 数值类型：正整数（1，2，3...）
  ///   - 例如：某碎片第1次展示并点击按钮后，将记变量c值为1。
  ///   - 获取方式：搜索当前记忆组、当前碎片的 [FragmentMemoryInfos] 个数。
  /// b（分段变量）：当前展示所点击按钮的按钮数值
  ///   - 数值类型：任意实数
  /// f（分段变量）：当前展示点击按钮前的熟悉度。
  ///   - 初始值：默认为0，用户可能会手动分配初始值
  ///   - 数值类型：任意实数
  ///   - 注意：一般来讲，若熟悉度的范围为0%~100%，则需要将其写成0~1。
  ///       - 例如，熟悉度50%，则需要写成0.5。
  ///       - 即使熟悉度存在范围，但它仍然可以超出范围，例如-0.5,1.5。
  ///       - 若想使熟悉度维持在范围之内，则需要将算法进行优化，例如，f(x)=sin(x)函数图像，当范围本身就是 -1≤f(x)≤1。
  ///       - "熟悉度"函数曲线的含义不一定非得是对碎片的熟悉程度曲线——f(t)随时间的增大而减小。也可以改变它的含义，例如"熟悉度"函数曲线也可以代表着遗忘程度曲线——f(t)随时间的增大而增大。
  ///       - 即，你想让函数曲线是什么样子就可以是什么样子，你想让函数值为多大多小就可以是多大多小。
  ///
  /// rt（分段聚合变量）：[当前展示点击按钮后的时间点]与[启动任务的时间点]的[时间间隔]
  ///   - 单位：秒
  ///   - 例如：记忆组在6:00被启动，在7:00时用户点击了按钮后，则将记变量rt值为3600。
  ///   - 获取方式：点击按钮后的时间点-记忆组启动时间点。
  ///
  /// pi（常量）：3.1415926
  /// e（常量）：2.7182818
  ///
  ///
  /// 例如： type:f(t)=1-(0.56*(t-d)^0.06)*(1-i)
  ///
  /// 分段变量：
  /// 每次展示结束后，都会将 [分段常量] 设置为新值，之后将会根据新的数学公式进行熟悉度的曲线计算。
  /// 注意，数学公式结构并不会发生改变，只是刷新了 [非固定常量] 的值。
  TextColumn get familiarityAlgorithm => text()();

  /// 评估下一次展示的时间点的算法。
  ///
  /// 可用变量：
  ///   i - 分段熟练度
  ///   b - 按钮数据 - 例如：很熟悉(b=b1=1/i 计算得60min后)  挺熟悉(b=b2=(1/i)*0.5 计算得30min后)  挺陌生(b=b3=(1/i)*0.01 计算得15min后) 很陌生(b=b4=0 计算得1min后)
  ///       - 按钮可以自定义数量 0-5 个，同时也可以设置区间选择，例如对 1.5-0.2 区间进行滑动选择。
  ///   c1 - 自定义变量 - c1、c2、c3...
  /// 其他：
  ///   y - [当前展示结束后]到[下一次展示]的时间间隔，单位min
  ///   type - 表示算法类型
  ///   multi -
  ///     - 第1天的算法：
  ///     - 第2天的算法：
  ///     - 第n天的算法：
  ///     - 第n天以上的算法：
  /// 例如：type:y=30*24*60*(i*b)+1
  ///   - 最终熟悉度=1：  30d+1min  后展示下一次。
  ///   - 最终熟悉度=0.5：  15d+0.5min  后展示下一次。
  ///   - 最终熟练度=0.01： 7h+12min  后展示下一次。
  ///   - 最终熟练度=0：  1min  后展示下一次。
  ///
  /// 展示碎片时，[按钮数据]会进行计算出y值，并展现给用户看，例如，展示内容：很熟悉(+5min)  挺熟悉(+60min)  挺陌生(+1d) 很陌生(+14d)。
  ///
  /// 变量中可以嵌入其他变量，例如，b的值可以是 1/i。
  ///
  /// 熟练度叠加的注意事项：
  ///   - [最终熟练度]的范围应该在 0%~100% 区间，即 0~1。
  ///   - 假设您设定的算法为：[最终熟练度]=[分段熟练度]*[按钮指定熟练度]，那么[按钮指定熟练度]的最大值应该等于[分段熟练度的倒数]，这样能保证 [最终熟练度] 的最大值为1。
  ///   - 当然，若您的算法需要的话，也可以让 [最终熟练度] 的值大于1，当程序计算时，也会按照大于1的值进行计算，不过最终向用户展现的最高熟练度仍然为1。
  TextColumn get nextTimeAlgorithm => text()();

  /// 5 2 1
  /// 4 3 1
  /// 6 5 2
  /// 初始熟悉度：
  ///
  /// 记忆规则建议命名格式：知识领域 - 适用群体。
  ///   - 例如：四级英语高频词组 - 大一生/高中生
  ///
  /// 基于艾宾浩斯记忆算法：
  /// 标准-艾宾浩斯记忆算法、高中生-高考英语单词-记忆算法、古诗词-记忆算法、四级英语单词-记忆算法、四级英语单词--记忆算法
  ///
  /// 瞬时记忆：在碎片内容执行完毕（比如声音播放完成）后，只展示1s。
  ///
  /// y=1-0.56t^0.06
  ///
  /// 记忆率-y：当前对该碎片的记忆程度。
  ///
  /// 时间-t(小时): 可以是小数，比如 30分钟-0.5小时。
  ///
  /// 印象因子-i(%)：
  ///
  /// 精确复现率：对以往的记忆过的碎片进行全文检索，检索出相似度高的碎片，
  /// 模糊复现率：对以往的记忆过的碎片进行全文检索，检索出相似度低的碎片，
  ///
  /// 个人遗忘因子：可自己分配、可智能分配
  ///   - -1：根据以往的记录智能分配。
  ///   - 0：你没有记忆细胞。
  ///   - 0~1：稍微记忆差一点。
  ///   - 1：标准艾宾浩斯。
  ///   - 1~2：稍微记忆好一点。
  ///   - 2：你拥有过目不忘本领。
  ///
  /// 多问多答机制：每次记忆都展示多个问题。
  ///
  /// 混沌因子：可能会在记忆的过程中混入趣味碎片、涨知识碎片等，甚至会展示某些令你意想不到的内容。
  ///   - 千分之10：表示每次展示碎片并识记后，会有千分之10的概率会继续展示混沌碎片。
  ///   - 例如，某个碎片展示过2次，那么第三次有可能会合成三星碎片，会将永久记录到该碎片中。
  ///   - 分为特效类和非特效类，用户可选择启用/禁用他们。
  ///   - 可对算法进行加权。
  ///
  /// 是否"将过就过"：碎片的展示错过了计划时间，是否跳过/优先于冲突碎片/滞后于冲突碎片

  /// 按钮分配
  ///
  /// 规范：
  ///   - 不可滑动：1,2,3
  ///   - 可滑动：0 1,2,3 5
  ///   - 可以为小数。
  TextColumn get buttonData => text()();
}

/// 碎片的记忆信息。
///
/// 每次用户在碎片展示中点击按钮后，就会创建一条记录。
///
/// 1. 用户自己手动配置熟悉度：
/// 用户可以在其他地方配置记忆记录，由于需要配置 [planedNextShowTime]，
/// 因此必须检索所有记忆组内是否存在该碎片，并要进行按钮触发配置对应的 [stageButtonValue]。
///
@ReferenceTo([])
class FragmentMemoryInfos extends CloudTableBase {
  @ReferenceTo([Fragments])
  TextColumn get fragmentId => text()();

  /// 允许对应的 [MemoryGroup] 不存在。
  @ReferenceTo([MemoryGroups])
  TextColumn get memoryGroupId => text()();

  /// 在当前记忆组内的， 分段按钮数值 —— 点击的按钮的数值。
  RealColumn get stageButtonValue => real()();

  /// 在当前记忆组内的，分段熟练度 —— 点击按钮瞬间前的熟练度。
  ///
  /// 在用户**触发按钮一瞬间**后 ，会根据 [MemoryModels.familiarityAlgorithm] 来计算**触发按钮一瞬间前**的熟练度（触发按钮后的瞬间熟练度必然是100%）
  ///
  /// 在其碎片没有记忆信息记录时，默认熟练度为0。
  RealColumn get stageFamiliarity => real()();

  /// 在当前记忆组内的，下一次计划展示的时间点。
  ///
  /// 在用户触发按钮后，会根据 [MemoryModels.nextTimeAlgorithm] 来计算下一次展示的时间。
  DateTimeColumn get planedNextShowTime => dateTime()();

  /// 在当前记忆组内的，下次实际展示的时间点。
  ///
  /// 在用户触发按钮后，会向上一条记录的 [actualNextShowTime] 设为碎片展示前的时间点。
  DateTimeColumn get actualNextShowTime => dateTime().nullable()();

  /// 在当前记忆组内的，碎片展示时长。
  RealColumn get showDuration => real()();

  /// 在当前记忆组内的，当前记录是否为当前碎片的最新记录。
  /// 在新纪录被创建的同时，需要把旧记录设为 false。
  BoolColumn get isLatestRecord => boolean()();
}
