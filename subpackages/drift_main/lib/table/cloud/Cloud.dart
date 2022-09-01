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
}

///
/// [分段变量]：
///
/// 每次点击按钮后，都会将 [分段常量] 设置为新值，之后将会根据新的数学函数进行熟悉度的曲线计算。
/// 注意，算法结构并不会发生改变，只是刷新了 [分段常量] 的值。
///
/// <在刚展示时获取>
/// start_time（s_t）：记忆组启动的时间点
///   - 数值类型：以秒为单位的时间戳
/// times（ts）：本次是第几次展示。
///   - 单位：次数
///   - 数值类型：正整数（1，2，3...）
/// show_time(s_t)：本次展示的时间点
///   - 数值类型：以秒为单位的时间戳
/// click_familiar（c_f）：本次刚展示时的熟悉度。
///   - 初始值：默认为0，用户可能会手动分配初始值。
///   - 数值类型：任意实数
/// count_all（ct_a）：当前记忆组碎片数量
/// count_new（ct_n）：本次展示前，当前记忆组剩余的新碎片数量
///
/// <在点击按钮时获取>
/// click_time（c_t）：本次点击按钮时的时间点
///   - 数值类型：以秒为单位的时间戳
/// click_value（c_v）：本次点击按钮的按钮数值
///   - 数值类型：任意实数
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
@ReferenceTo([])
class MemoryModels extends CloudTableBase {
  TextColumn get title => text()();

  /// 评估碎片熟悉度变化的算法。
  ///
  /// 每次展示并点击按钮后，将输入以下变量，计算出新的熟悉度函数曲线。
  /// 注意：是 [每次展示并点击按钮 后 ，将输入以下变量]，而非 [每次点击按钮前，或每次展示前，或每次展示后且点击按钮前...]。
  ///
  /// y=f(x) 是一个任意函数。
  ///   1. 一般来讲，若熟悉度的范围为0%~100%，则需要将其表示为 0~1 或 0.0~1.0。例如，熟悉度 50%，则需要写成 0.5，否则%符号无法解析。
  ///   2. 即使熟悉度可能存在范围，但它仍然可以超出范围，例如 -0.5, 1.5...，甚至999.999...
  ///   3. 若想使熟悉度维持在范围之内，则需要将算法进行优化。
  ///       - 例如，在 y=sin(x) 的函数图像中，只要在 0≤x≤pi 范围内，其本身就会被限制在 0≤y≤1。
  ///       - 而当 y<0 时，即使 f(y) 在第二三象限内，但由于 y>=0，因此算法执行时，y 本身就不会小于 0。
  ///   4. "熟悉度"函数曲线的含义不一定非得是对碎片的熟悉程度曲线——f(t)随时间的增大而减小。也可以改变它的含义，例如"熟悉度"函数曲线也可以代表着遗忘程度曲线——f(t)随时间的增大而增大。
  ///   5. 总结：你想让函数曲线是什么样子就可以是什么样子，你想让函数值为多少就可以是多少，你想让 f(t) 的含义是什么就可以是什么。
  ///      甚至，用户可以利用编程知识来编写算法，提供了 if-else/for语句, ??语法糖等。
  TextColumn get familiarityAlgorithm => text()();

  /// 评估下一次展示的时间点的算法。
  ///
  /// 每次展示并点击按钮后，将输入以下变量，计算出下一次展示的时间点.
  /// 注意：是 [每次展示并点击按钮 后 ，将输入以下变量]，而非 [每次点击按钮前，或每次展示前，或每次展示后且点击按钮前...]。
  ///
  /// y=f(x) 是一个任意函数。
  ///
  TextColumn get nextTimeAlgorithm => text()();

  /// 按钮算法
  TextColumn get buttonData => text()();

  /// 激发算法
  ///
  /// 在碎片展示时，若满足xxx条件，将展示对应的[激发碎片]，刺激学习者的记忆，以至加深记忆。
  ///
  /// 例如，若在本次展示前，已经满足连续5次点击了'忘记'按钮，则本次将展示对应的[激发碎片]。
  ///
  /// 若不存在对应的[激发碎片]，有两种选择或可能性：
  ///   1. 将默认使用格外的文字代替，来提醒学习者。（仅仅只能是提醒作用）
  ///   2. 对市场上的碎片进行检索，寻找合适的碎片来充当[激发碎片]，
  ///      若处于离线状态，将默认使用 1 代替。
  TextColumn get stimulateAlgorithm => text()();

  /// 适用群体
  ///
  /// 例如：大一生、高中生
  TextColumn get applicableGroups => text()();

  /// 适用领域
  ///
  /// 例如：英语、英语-四级英语、语文-高中必备文言文
  TextColumn get applicableFields => text()();
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
