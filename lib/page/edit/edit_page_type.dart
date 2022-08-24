enum MemoryGroupGizmoEditPageType {
  /// 初始化，并检查初始化的部分
  initCheck,

  /// 修改初始化的部分，并检查
  /// TODO: 要注意修改前与修改后的兼容提示。
  modifyInitCheck,

  /// 修改非初始化部分,并检查
  /// TODO: 要注意修改前与修改后的兼容提示。
  modifyOtherCheck,
}

enum MemoryModelGizmoEditPageType {
  /// 仅创建，不检查
  create,

  /// 仅修改，不检查
  modify,

  /// 修改，并检查
  modifyCheck,

  /// 仅查看，无法修改
  look,
}
