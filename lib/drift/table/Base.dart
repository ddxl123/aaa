import 'package:drift/drift.dart';

class TableLocalBase extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}

class TableCloudBase extends TableLocalBase {
  IntColumn get cloudId => integer().nullable().customConstraint('UNIQUE')();

  /// 同步 curd 类型。为空则表示该行 不需要进行同步。
  ///
  /// 值： null C-0 U-1 R-2 D-3
  ///
  /// 不为 null 的可能性：
  ///   1. 未上传更改。
  ///   2. 客户端上传数据后，客户端被断掉，从而未对服务器上传成功的消息进行接收。（若是服务器断掉，则客户端会收到失败的响应）
  ///
  /// 若客户端请求——服务器响应，这个流程成功则设为 null，失败则保持为 curd。
  /// 若为 2 的情况，应用会再次检索未上传的数据，再次进行上传，但无碍，因为服务端上传时，会对比 updatedAt。
  ///   - 若新旧相同，则服务端已同步过，响应客户端将其置空。
  ///   - 若新的晚于旧的，则需要服务端进行同步后，响应客户端将其置空。
  ///   - 若新的早于旧的，则 1. 可能客户端、服务端时间被篡改；2. 该条数据在其他客户端已经被同步过了 TODO: 可依据此处设计多客户端登陆方案。
  IntColumn get syncCurd => integer().nullable()();

  /// 当 [syncCurd] 为 U-1 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如："username,password"。
  TextColumn get syncUpdateColumns => text().nullable()();
}
