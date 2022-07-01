part of drift_db;

const List<Type> cloudTableClass = [
  Users,
  Fragments,
  FragmentGroups,
  MemoryGroups,
  MemoryModels,
  FragmentMemoryInfos,
];

class Users extends CloudTableBase {
  TextColumn get username => text().withDefault(const Constant('还没有名字'))();

  TextColumn get password => text().nullable()();

  TextColumn get email => text().withDefault(const Constant('-'))();

  IntColumn get age => integer().check(age.isBiggerOrEqual(const Constant(0))).withDefault(const Constant(0))();
}

class Fragments extends CloudTableBase {
  /// 父节点。
  ///
  /// 若为 null，则自身为父节点。
  IntColumn get fatherFragmentId => integer().nullable()();

  TextColumn get title => text().withDefault(const Constant('还没有标题'))();

  /// 优先级/高频程度。
  ///
  /// 数字越大，优先级越高，不能为负数。
  IntColumn get priority => integer().check(priority.isBiggerOrEqual(const Constant(0))).withDefault(const Constant(0))();
}

class FragmentGroups extends CloudTableBase {
  TextColumn get title => text().withDefault(const Constant('还没有名称'))();
}

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

class MemoryModels extends CloudTableBase {
  TextColumn get title => text().withDefault(const Constant('还没有名称'))();

  /// 初始数学函数，用逗号隔开。
  ///
  /// 例如： 'y=1-0.56t^0.06,y=1-0.56t^0.06'
  TextColumn get mathFunction1 => text().nullable()();

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

/// 碎片的历史记忆信息。
///
/// [TableBase.createdAt] 充当每次的记忆时间
class FragmentMemoryInfos extends CloudTableBase {
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

  /// 碎片展示时间。
  IntColumn get showTime => integer().withDefault(const Constant(0))();
}
