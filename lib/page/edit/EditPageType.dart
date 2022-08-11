enum EditPageType {
  /// 仅创建，不检查
  create,

  /// 仅修改，不检查
  modify,

  /// 创建，并检查
  createCheck,

  /// 修改，并检查
  modifyCheck,

  /// 选择
  select,
}
