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

  /// 评估碎片熟悉度变化的算法。
  ///
  /// 每次展示并点击按钮后，将输入以下变量，计算出新的熟悉度函数曲线，并提供给 [nextTimeAlgorithm] 进行下一次展示的时间点的计算。
  /// 注意：是 [每次展示并点击按钮 后 ，将输入以下变量]，而非 [每次点击按钮前，或每次展示前，或每次展示后且点击按钮前...]。
  ///
  /// f(t) 是一个以 t 为[自变量]，以 c、b、f 为[分段变量]，以 rt 为[分段聚合变量]的函数。
  ///
  /// 分段xxx变量：
  /// 每次点击按钮后，都会将 [分段xxx常量] 设置为新值，之后将会根据新的数学公式进行熟悉度的曲线计算。
  /// 注意，算法结构并不会发生改变，只是刷新了 [分段xxx常量] 的值。
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
  ///      分段未来变量：尽情期待
  ///      分段未来聚合变量：尽情期待
  ///
  /// <自变量>
  /// t：流逝的时间
  ///   - 从记忆组启动时开始流逝。
  ///   - 初始值：0
  ///   - 单位：秒
  ///   - 数值类型：自然数（0，1，2，3...）
  ///
  /// <分段变量>
  /// times（ts）：本次是第几次展示。
  ///   - 单位：次数
  ///   - 数值类型：正整数（1，2，3...）
  ///   - 例如：某碎片第1次展示并点击按钮后，将记变量c值为1。
  ///   - 获取方式：搜索当前记忆组、当前碎片的 [FragmentMemoryInfos] 个数。
  /// click_time（c_t）：本次点击按钮后的时间点
  ///   - 单位：秒
  ///   - 数值类型：以秒为单位的时间戳
  /// click_value（c_v）：本次点击按钮的按钮数值
  ///   - 数值类型：任意实数
  /// click_familiar（c_f）：本次点击按钮前的熟悉度。
  ///   - 初始值：默认为0，用户可能会手动分配初始值。
  ///   - 数值类型：任意实数
  ///
  /// <分段聚合变量>
  /// 获取第n次点击按钮后的某个变量：
  ///   - 第n次的变量名：当前变量名加上'_n'后缀
  ///     - 例如：第一次 click_value_1，第二次 click_value_2，第n次 click_value_n...
  ///     - 简写：第一次 c_v，第二次 c_v_1，上n次 c_v_n...
  ///   - 若第n次恰好是本次点击按钮后的次数，则第n次等价于本次。
  ///     - 例如：本次是第3次，那么 click_value_3 等价于本次。
  ///   - 若第n次不存在，则可用 [n??数值] 来充当不存在的值。
  ///     - 例如，click_value_2??123 的含义为：当 click_value_2 不存在时，将使用 123 进行代替。
  /// 获取上n次点击按钮后的某个变量：
  ///   - 上n次的变量名：当前变量名加上'_recentn'后缀。
  ///     - 例如：本次 click_value，上一次 click_value_recent1，上两次 click_value_recent2，上n次 click_value_recentn...
  ///     - 简写：本次 c_v，上一次 c_v_r1，上两次 c_v_r2，上n次 c_v_rn...
  ///   - 若上n次不存在，则可用 [n??数值] 来充当不存在的值。
  ///     - 例如，click_value_recent3??123 的含义为：当 click_value_recent3 不存在时，将使用 123 进行代替。
  ///
  /// <自定义变量>
  /// 用户可以自定义变量，变量中可以嵌入其他变量。
  /// - 例如，现有自定义变量 time_interval，可令 time_interval=click_time-click_time_recent1，
  ///   那么。该 time_interval 变量的含义为：本次点击按钮后的时间点与上一次点击按钮后的时间点的时间差。
  /// - 注意：自定义变量的名称不能与已存在变量的名称相同。
  ///
  /// <常量>
  /// start_time（s_t）：记忆组启动的时间点
  ///   - 单位：秒
  ///   - 数值类型：以秒为单位的时间戳
  /// pi：3.1415926
  /// e：2.7182818
  ///
  /// 例如： f(t)=1-(0.56*(t-d)^0.06)*(1-f)
  ///
  /// 在xxx条件下，自动转化为线性回归算法。
  TextColumn get familiarityAlgorithm => text()();

  /// 评估下一次展示的时间点的算法。
  ///
  /// 点击按钮后
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
