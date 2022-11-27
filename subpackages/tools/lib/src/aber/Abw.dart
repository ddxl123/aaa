part of aber;

/// 将 [AbController]/[AbBuilder]/[Ab] 连接起来的重要类。
///
/// 引用的 [Ab] 被标记为 refresh 时, 所传入的 [Abw] 是哪个 [AbBuilder.builder] 产生的，就会使哪个 widget 被重建.
///
/// 例如:
/// ```dart
/// ...
/// return AbBuilder(
///   controller: Controller1(), // 第一次创建控制器
///   builder: (controller1, abw_1) {
///
///        return AbBuilder<Controller1>( // 因为已经创建过需要的控制器了，因此只需查找。
///          builder: (controller_1, abw_2) {
///
///               // 因为 count 所引用的是 abw_2, 因此当 count 被更新时，
///               // 将会自动重建 abw_2 所在的 AbBuilder, 而 abw_1 所在的 AbBuilder 不会被重建。
///               return Text(controller_1.count.get(abw_2).toString());
///        });
///
/// });
/// ...
/// ```
class Abw {
  Abw(this.refresh, this._removeRefreshFunctions);

  final RefreshFunction refresh;
  final Set<RemoveRefreshFunction> _removeRefreshFunctions;
}
