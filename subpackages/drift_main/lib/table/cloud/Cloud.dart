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
///  新学数量[willNewLearnCount]：[100]个 剩余100
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
  IntColumn get willNewLearnCount => integer()();

  /// 取用 [reviewInterval] 时间点内的复习碎片。
  DateTimeColumn get reviewInterval => dateTime()();

  /// 过滤碎片
  TextColumn get filterOut => text()();

  /// 新旧碎片展示先后顺序。
  IntColumn get newReviewDisplayOrder => intEnum<NewReviewDisplayOrder>()();

  /// 新碎片展示先后顺序。
  IntColumn get newDisplayOrder => intEnum<NewDisplayOrder>()();
}

@ReferenceTo([])
class MemoryModels extends CloudTableBase {
  TextColumn get title => text()();

  /// <在点击按钮时>，评估碎片熟悉度变化的算法。
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

  /// <在点击按钮时>，评估下一次展示的时间点的算法。
  ///
  /// 每次展示并点击按钮后，将输入以下变量，计算出下一次展示的时间点.
  /// 注意：是 [每次展示并点击按钮 后 ，将输入以下变量]，而非 [每次点击按钮前，或每次展示前，或每次展示后且点击按钮前...]。
  TextColumn get nextTimeAlgorithm => text()();

  /// <在刚展示时>，按钮算法
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
/// 用户可以在其他地方配置记忆记录，由于需要配置 [planedShowTime]，
/// 因此必须检索所有记忆组内是否存在该碎片，并要进行按钮触发配置对应的 [stageButtonValue]。
///
@ReferenceTo([])
class FragmentMemoryInfos extends CloudTableBase {
  @ReferenceTo([Fragments])
  TextColumn get fragmentId => text()();

  @ReferenceTo([MemoryGroups])
  TextColumn get memoryGroupId => text()();

  /// 在当前记忆组内的，当前记录是否为当前碎片的最新记录。
  /// 在新纪录被创建的同时，需要把旧记录设为 false。
  BoolColumn get isLatestRecord => boolean()();

  /// =====

  /// 原本计划展示的时间点。
  DateTimeColumn get planedShowTime => dateTime()();

  /// 实际展示的时间点。
  DateTimeColumn get actualShowTime => dateTime()();

  /// 刚展示时的熟练度。
  RealColumn get clickFamiliarity => real()();

  /// 点击按钮的时间。
  DateTimeColumn get clickTime => dateTime()();

  /// 点击按钮的按钮数值。
  RealColumn get clickValue => real()();
}
