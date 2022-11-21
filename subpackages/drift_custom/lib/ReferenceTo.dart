/// 当前 id（外键）所引用的表的注解。
///
/// 为了能生成 [Ref] 表。
///
/// 使用在其类的外键成员上：必须是带s的表类型，如 @ReferenceTo([Users])。
/// 使用在其类上：直接传入 []，如 @ReferenceTo([])。
///
/// 必须先在其类上标注 @ReferenceTo([])，外键成员上的注解才能被识别。
///
/// 必须让所有数据表处在同一个库中，这样能集中生成到同一个文件中。
///
/// ```dart
/// @ReferenceTo([])
/// class TestTable extends Table {
///   @ReferenceTo([Users])
///   IntColumn get userId => integer()();
/// }
/// ```
class ReferenceTo {
  final List<Type> referenceTable;

  const ReferenceTo(this.referenceTable);
}
