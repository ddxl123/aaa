// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// CrtGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

/// 这个类在创建表对象时，可以让每个 column 都能被编辑器提示，以防遗漏。
///
/// id createdAt updatedAt 已经在 [DriftSyncExt.insertReturningWith] 中自动更新了。
///
/// 使用方式查看 [withRefs]。
class Crt {
  Crt._();
  static FragmentGroupConfigsCompanion fragmentGroupConfigsCompanion({
    required bool be_private,
    required bool be_publish,
    required int creator_user_id,
    required int fragment_group_id,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return FragmentGroupConfigsCompanion(
      be_private: Value(be_private),
      be_publish: Value(be_publish),
      creator_user_id: Value(creator_user_id),
      fragment_group_id: Value(fragment_group_id),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static UsersCompanion usersCompanion({
    required Value<int?> age,
    required Value<String?> email,
    required Value<String?> password,
    required Value<String?> phone,
    required String username,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return UsersCompanion(
      age: age,
      email: email,
      password: password,
      phone: phone,
      username: Value(username),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static ClientSyncInfosCompanion clientSyncInfosCompanion({
    required String device_info,
    required Value<DateTime?> recent_sync_time,
    required Value<String?> token,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return ClientSyncInfosCompanion(
      device_info: Value(device_info),
      recent_sync_time: recent_sync_time,
      token: token,
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static SyncsCompanion syncsCompanion({
    required String row_id,
    required SyncCurdType sync_curd_type,
    required String sync_table_name,
    required int tag,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return SyncsCompanion(
      row_id: Value(row_id),
      sync_curd_type: Value(sync_curd_type),
      sync_table_name: Value(sync_table_name),
      tag: Value(tag),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static FragmentMemoryInfosCompanion fragmentMemoryInfosCompanion({
    required Value<String?> click_time,
    required Value<String?> click_value,
    required int creator_user_id,
    required Value<String?> current_actual_show_time,
    required String fragment_id,
    required String memory_group_id,
    required Value<String?> next_plan_show_time,
    required Value<String?> show_familiarity,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return FragmentMemoryInfosCompanion(
      click_time: click_time,
      click_value: click_value,
      creator_user_id: Value(creator_user_id),
      current_actual_show_time: current_actual_show_time,
      fragment_id: Value(fragment_id),
      memory_group_id: Value(memory_group_id),
      next_plan_show_time: next_plan_show_time,
      show_familiarity: show_familiarity,
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static RDocument2DocumentGroupsCompanion rDocument2DocumentGroupsCompanion({
    required int creator_user_id,
    required Value<String?> document_group_id,
    required String document_id,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return RDocument2DocumentGroupsCompanion(
      creator_user_id: Value(creator_user_id),
      document_group_id: document_group_id,
      document_id: Value(document_id),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static RFragment2FragmentGroupsCompanion rFragment2FragmentGroupsCompanion({
    required int creator_user_id,
    required Value<String?> fragment_group_id,
    required String fragment_id,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return RFragment2FragmentGroupsCompanion(
      creator_user_id: Value(creator_user_id),
      fragment_group_id: fragment_group_id,
      fragment_id: Value(fragment_id),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static RNote2NoteGroupsCompanion rNote2NoteGroupsCompanion({
    required int creator_user_id,
    required Value<String?> note_group_id,
    required String note_id,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return RNote2NoteGroupsCompanion(
      creator_user_id: Value(creator_user_id),
      note_group_id: note_group_id,
      note_id: Value(note_id),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static Test2sCompanion test2sCompanion({
    required String client_content,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return Test2sCompanion(
      client_content: Value(client_content),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static TestsCompanion testsCompanion({
    required String client_a,
    required String client_content,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return TestsCompanion(
      client_a: Value(client_a),
      client_content: Value(client_content),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static DocumentsCompanion documentsCompanion({
    required String content,
    required int creator_user_id,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return DocumentsCompanion(
      content: Value(content),
      creator_user_id: Value(creator_user_id),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static FragmentTemplatesCompanion fragmentTemplatesCompanion({
    required String content,
    required int owner_user_id,
    required FragmentTemplateType type,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return FragmentTemplatesCompanion(
      content: Value(content),
      owner_user_id: Value(owner_user_id),
      type: Value(type),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static FragmentsCompanion fragmentsCompanion({
    required bool client_be_selected,
    required String content,
    required int creator_user_id,
    required Value<String?> father_fragment_id,
    required Value<String?> fragment_template_id,
    required Value<String?> note_id,
    required String title,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return FragmentsCompanion(
      client_be_selected: Value(client_be_selected),
      content: Value(content),
      creator_user_id: Value(creator_user_id),
      father_fragment_id: father_fragment_id,
      fragment_template_id: fragment_template_id,
      note_id: note_id,
      title: Value(title),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static MemoryGroupsCompanion memoryGroupsCompanion({
    required int creator_user_id,
    required Value<String?> memory_model_id,
    required NewDisplayOrder new_display_order,
    required NewReviewDisplayOrder new_review_display_order,
    required DateTime review_interval,
    required Value<DateTime?> start_time,
    required String title,
    required int will_new_learn_count,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return MemoryGroupsCompanion(
      creator_user_id: Value(creator_user_id),
      memory_model_id: memory_model_id,
      new_display_order: Value(new_display_order),
      new_review_display_order: Value(new_review_display_order),
      review_interval: Value(review_interval),
      start_time: start_time,
      title: Value(title),
      will_new_learn_count: Value(will_new_learn_count),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static MemoryModelsCompanion memoryModelsCompanion({
    required String button_algorithm,
    required int creator_user_id,
    required String familiarity_algorithm,
    required Value<String?> father_memory_model_id,
    required String next_time_algorithm,
    required String title,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return MemoryModelsCompanion(
      button_algorithm: Value(button_algorithm),
      creator_user_id: Value(creator_user_id),
      familiarity_algorithm: Value(familiarity_algorithm),
      father_memory_model_id: father_memory_model_id,
      next_time_algorithm: Value(next_time_algorithm),
      title: Value(title),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static NotesCompanion notesCompanion({
    required String content,
    required int creator_user_id,
    required Value<String?> document_id,
    required Value<String?> father_note_id,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return NotesCompanion(
      content: Value(content),
      creator_user_id: Value(creator_user_id),
      document_id: document_id,
      father_note_id: father_note_id,
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static DocumentGroupsCompanion documentGroupsCompanion({
    required int creator_user_id,
    required Value<String?> father_document_groups_id,
    required String title,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return DocumentGroupsCompanion(
      creator_user_id: Value(creator_user_id),
      father_document_groups_id: father_document_groups_id,
      title: Value(title),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static FragmentGroupsCompanion fragmentGroupsCompanion({
    required bool client_be_selected,
    required int creator_user_id,
    required Value<String?> father_fragment_groups_id,
    required String title,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return FragmentGroupsCompanion(
      client_be_selected: Value(client_be_selected),
      creator_user_id: Value(creator_user_id),
      father_fragment_groups_id: father_fragment_groups_id,
      title: Value(title),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static NoteGroupsCompanion noteGroupsCompanion({
    required int creator_user_id,
    required Value<String?> father_note_groups_id,
    required String title,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return NoteGroupsCompanion(
      creator_user_id: Value(creator_user_id),
      father_note_groups_id: father_note_groups_id,
      title: Value(title),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }
}

extension FragmentGroupConfigsCompanionExt on FragmentGroupConfigsCompanion {
  Future<FragmentGroupConfig> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragmentGroupConfigs,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension UsersCompanionExt on UsersCompanion {
  Future<User> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.users,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension ClientSyncInfosCompanionExt on ClientSyncInfosCompanion {
  Future<ClientSyncInfo> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.clientSyncInfos,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension SyncsCompanionExt on SyncsCompanion {
  Future<Sync> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.syncs,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentMemoryInfosCompanionExt on FragmentMemoryInfosCompanion {
  Future<FragmentMemoryInfo> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragmentMemoryInfos,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension RDocument2DocumentGroupsCompanionExt
    on RDocument2DocumentGroupsCompanion {
  Future<RDocument2DocumentGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.rDocument2DocumentGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension RFragment2FragmentGroupsCompanionExt
    on RFragment2FragmentGroupsCompanion {
  Future<RFragment2FragmentGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.rFragment2FragmentGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension RNote2NoteGroupsCompanionExt on RNote2NoteGroupsCompanion {
  Future<RNote2NoteGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.rNote2NoteGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension Test2sCompanionExt on Test2sCompanion {
  Future<Test2> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.test2s,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension TestsCompanionExt on TestsCompanion {
  Future<Test> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.tests,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension DocumentsCompanionExt on DocumentsCompanion {
  Future<Document> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.documents,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentTemplatesCompanionExt on FragmentTemplatesCompanion {
  Future<FragmentTemplate> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragmentTemplates,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentsCompanionExt on FragmentsCompanion {
  Future<Fragment> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragments,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension MemoryGroupsCompanionExt on MemoryGroupsCompanion {
  Future<MemoryGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.memoryGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension MemoryModelsCompanionExt on MemoryModelsCompanion {
  Future<MemoryModel> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.memoryModels,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension NotesCompanionExt on NotesCompanion {
  Future<Note> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.notes,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension DocumentGroupsCompanionExt on DocumentGroupsCompanion {
  Future<DocumentGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.documentGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentGroupsCompanionExt on FragmentGroupsCompanion {
  Future<FragmentGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragmentGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension NoteGroupsCompanionExt on NoteGroupsCompanion {
  Future<NoteGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.noteGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}
