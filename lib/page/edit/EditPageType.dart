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
