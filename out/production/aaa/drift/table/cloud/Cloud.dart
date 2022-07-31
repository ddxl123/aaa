part of drift_db;

const List<Type> cloudTableClass = [
  Users,
  Fragments,
  FragmentGroups,
  MemoryGroups,
  MemoryModels,
  FragmentPermanentMemoryInfos,
  FragmentTemporaryMemoryInfo2,
];

@ReferenceTo([])
class Users extends CloudTableBase {
  TextColumn get username => text().withDefault(const Constant('还没有名字'))();

  TextColumn get password => text().nullable()();

  TextColumn get email => text().withDefault(const Constant('-'))();

  IntColumn get age => integer().check(age.isBiggerOrEqual(const Constant(0))).withDefault(const Constant(0))();
}

@ReferenceTo([])
class Fragments extends CloudTableBase {
  /// 父节点。
  ///
  /// 若为 null，则自身为父节点。
  @ReferenceTo([Fragments])
  TextColumn get fatherFragmentId => text().nullable()();

  TextColumn get title => text().withDefault(const Constant('还没有标题'))();

  /// 优先级/高频程度。
  ///
  /// 数字越大，优先级越高，不能为负数。
  IntColumn get priority => integer().check(priority.isBiggerOrEqual(const Constant(0))).withDefault(const Constant(0))();
}

@ReferenceTo([])
class FragmentGroups extends CloudTableBase {
  @ReferenceTo([FragmentGroups])
  TextColumn get fatherFragmentGroupId => text().nullable()();

  TextColumn get title => text().withDefault(const Constant('还没有名称'))();
}

@ReferenceTo([])
class MemoryGroups extends CloudTableBase {
  TextColumn get title => text().withDefault(const Constant('还没有名称'))();

  IntColumn get type => intEnum<MemoryGroupType>().withDefault(Constant(MemoryGroupType.normal.index))();

  /// [MemoryGroupStatusForNormal]
  IntColumn get normalStatus => intEnum<MemoryGroupStatusForNormal>().withDefault(Constant(MemoryGroupStatusForNormal.notStart.index))();

  /// [MemoryGroupStatusForNormalPart]
  IntColumn get normalPartStatus => intEnum<MemoryGroupStatusForNormalPart>().withDefault(Constant(MemoryGroupStatusForNormalPart.disabled.index))();

  /// [MemoryGroupStatusForFullFloating]
  IntColumn get fullFloatingStatus =>
      intEnum<MemoryGroupStatusForFullFloating>().withDefault(Constant(MemoryGroupStatusForFullFloating.notStarted.index))();

  /// 悬浮碎片是否立即触发音频/特效等。
}

@ReferenceTo([])
class MemoryModels extends CloudTableBase {
  TextColumn get title => text().withDefault(const Constant('还没有名称'))();

  /// 熟悉度算法。用来计算碎片的熟悉度曲线的数学函数，
  ///
  /// 可用变量：
  ///   t（变量） - 流逝的时间，初始值为 0。
  ///   d（阶段变量） - 启动任务的时间点与当次展示结束后与的时间间隔。
  ///   i（阶段变量） - 每次展示前的 [瞬时熟练度]。
  ///   c1（自定义变量1） - 来自 [nextTimeAlgorithm] 的自定义变量。
  /// 其他：
  ///   f(t) - 流逝熟悉度，单位百分比。
  ///   type - 表示算法类型，比如普通函数曲线类型、分段函数类型、固定值类型（fix:5,30,60,300(单位分钟)）等。
  /// 例如： ype:f(t)=1-(0.56(t-d)^0.06)*(1-i)
  ///
  /// 阶段变量：
  /// 每次展示结束后，都会将 [非固定常量] 设置为新值，之后将会根据新的数学公式进行 [流逝熟悉度] 计算。注意，数学公式结构并不会发生改变，只是刷新了 [非固定常量] 的值。
  TextColumn get familiarityAlgorithm => text().nullable()();

  /// 评估下一次展示的时间点的算法。
  ///
  /// 可用变量：
  ///   i - 瞬时熟练度 - 是否启用（启用时请将该因子加入到数学公式中，若未加入则等于未启用）
  ///   b - 按钮数据 - 例如 熟悉-、还行、陌生，
  TextColumn get nextTimeAlgorithm => text().nullable()();

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
  ///
  /// 是否"将过就过"：碎片的展示错过了计划时间，是否跳过/优先于冲突碎片/滞后于冲突碎片
}

/// 碎片的永久存储的记忆信息（包含了历史记忆信息）。
///
/// [TableBase.createdAt] 充当每次的记忆时间
@ReferenceTo([])
class FragmentPermanentMemoryInfos extends CloudTableBase {
  @ReferenceTo([])
  TextColumn get fragmentId => text().nullable()();

  /// 自然熟悉度 —— 当前时间点的熟悉度
  /// 范围：0~100。
  IntColumn get naturalFamiliarity =>
      integer().check(naturalFamiliarity.isBetween(const Constant(0), const Constant(100))).withDefault(const Constant(0))();

  /// 明确熟悉度 —— 当前时间点所操作的熟悉度。
  ///
  /// 范围：0~100。
  ///
  /// 在用户选择某点明确熟悉度时，会根据 [MemoryModels] 来计算下一次展示的时间。
  IntColumn get explicitFamiliarity =>
      integer().check(explicitFamiliarity.isBetween(const Constant(0), const Constant(100))).withDefault(const Constant(0))();

  /// 碎片展示时长。
  IntColumn get showDuration => integer().withDefault(const Constant(0))();
}

/// 碎片的临时存储的记忆信息（只包含了当前碎片在对应的记忆组中的记忆信息）
@ReferenceTo([])
class FragmentTemporaryMemoryInfo2 extends CloudTableBase {
  @ReferenceTo([Fragments])
  TextColumn get fragmentId => text().nullable()();

  @ReferenceTo([MemoryGroups])
  TextColumn get memoryGroupId => text().nullable()();

  /// 下一次展示的时间点。
  ///
  /// 为 null 表示在当前记忆组时的当前碎片为新碎片。
  ///
  /// 为 1970 年 1 月 1 日 00:00 分（时间戳为0）表示在当前记忆组时的当前碎片已经完成任务。
  DateTimeColumn get nextShowTime => dateTime().nullable()();
}
