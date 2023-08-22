part of drift_db;

/// 给 tag 创建一个对象，方便引用。
class SyncTag {
  SyncTag._();

  /// 见 [Syncs.tag] 注释。
  late final int tag;

  /// 防止 cloud 类型表创建行时 id 重复。
  int cloudIdIncrease = 0;

  /// 创建一个 cloud 类型 id。
  ///
  /// 前 7 个字符
  /// 1. 最大时间点：4453-04-05 23:21:35
  /// 2. 最大 10 进制时间戳（单位s）：783 6416 4095
  /// 3. 最大 36 进制时间戳：'zzz zzzz'
  ///
  /// 中间 7 字符：
  /// 1. 用户 id(10进制) 转 36进制：
  /// 2. 最大值 10 进制值：783 6416 4095
  /// 3. 最大 36 进制值：'zzz zzzz'
  ///
  /// 最后 4 字符：
  /// 1. [cloudIdIncrease]
  /// 2. 最大 10 进制值：1679615
  /// 3. 最大 36 进制值：'zzzz'
  ///
  /// 整体：
  /// 000 0000 - 000 0000 - 0000
  String createCloudId({required int userId}) {
    String prefix = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toRadixString(36);
    String center = userId.toRadixString(36);
    String suffix = cloudIdIncrease.toRadixString(36);
    cloudIdIncrease += 1;
    prefix = '0' * (7 - prefix.length) + prefix;
    center = '0' * (7 - center.length) + center;
    suffix = '0' * (4 - suffix.length) + suffix;
    return prefix + center + suffix;
  }

  /// 创建一个新的 sync。
  ///
  /// [tag] 值将被设为 [Syncs] 表中的 sync 列的最大值+1，
  /// 若 [Syncs] 表没有数据，则 [tag] 值将被设为 0.
  static Future<SyncTag> create() async {
    final syncTag = SyncTag._();
    final db = DriftDb.instance;
    final maxExpr = db.syncs.tag.max();
    final result = await (db.selectOnly(db.syncs)..addColumns([maxExpr])).get();
    final max = result.isEmpty ? null : result.first.read(maxExpr);
    syncTag.tag = max == null ? 0 : max + 1;
    return syncTag;
  }

  /// 解析出 userId。
  // static int parseToUserId(int id) {
  //   final userId36 = id, .substring(7, 14);
  //   return int.parse(userId36, radix: 36);
  // }

  @override
  bool operator ==(Object other) {
    return (other is SyncTag) ? tag == other.tag : false;
  }

  @override
  int get hashCode => tag.hashCode;
}
