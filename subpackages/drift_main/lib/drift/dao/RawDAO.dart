part of drift_db;

@DriftAccessor(
  tables: tableClasses,
)
class RawDAO extends DatabaseAccessor<DriftDb> with _$RawDAOMixin {
  RawDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  /// [newUsersCompanion] 可以使用 [Crt.usersCompanion]。
  Future<User> rawInsertUser({required UsersCompanion newUsersCompanion}) async {
    final findUser = await driftDb.generalQueryDAO.queryUserOrNull();
    if (findUser != null) throw "本地已存在用户！";
    return await into(driftDb.users).insertReturning(newUsersCompanion);
  }

  // Future<void> rawInsertDownloadForFragmentGroup({
  //   required User user,
  //   required FragmentGroup? saveFragmentGroup,
  //   required DataDownloadForFragmentGroupVo dataDownloadForFragmentGroupVo,
  // }) async {
  //   await db.transaction(
  //     () async {
  //       final st = await SyncTag.create();
  //       final now = DateTime.now();
  //       await db.batch(
  //         (batch) async {
  //           // 原id - 现id
  //           final fragmentGroupMap = <String, String>{};
  //           bool isRootFragmentGroupIdAssigned = false;
  //
  //           final fragmentGroupSyncsResult = <SyncsCompanion>[];
  //           final fragmentGroupsResult = dataDownloadForFragmentGroupVo.fragment_group_list
  //               .map(
  //                 (e) {
  //                   final newId = st.createCloudId(userId: user.id);
  //                   fragmentGroupMap[e.id] = newId;
  //                   throw "未处理";
  //                   // return Crt.fragmentGroupsCompanion(
  //                   //   be_private: false,
  //                   //   be_publish: false,
  //                   //   client_be_selected: false,
  //                   //   creator_user_id: user.id,
  //                   //   father_fragment_groups_id: e.father_fragment_groups_id.toValue(),
  //                   //   title: e.title,
  //                   //   profile: e.profile,
  //                   //   id: newId,
  //                   //   created_at: now,
  //                   //   updated_at: now,
  //                   // );
  //                 },
  //               )
  //               .toList() // 必须 toList，不然调用下面的 map 时会再调用一次上面的 map。
  //               .map(
  //                 (e) {
  //                   // 修改 fatherId
  //                   // var nowFatherId = fragmentGroupMap[e.father_fragment_groups_id.value];
  //                   // if (nowFatherId == null) {
  //                   //   if (isRootFragmentGroupIdAssigned) {
  //                   //     throw "存在多个 root";
  //                   //   }
  //                   //   nowFatherId = saveFragmentGroup?.id;
  //                   //   isRootFragmentGroupIdAssigned = true;
  //                   // }
  //                   //
  //                   // fragmentGroupSyncsResult.add(
  //                   //   Crt.syncsCompanion(
  //                   //     row_id: e.id.value,
  //                   //     sync_curd_type: SyncCurdType.c,
  //                   //     sync_table_name: fragmentGroups.actualTableName,
  //                   //     tag: st.tag,
  //                   //     created_at: now,
  //                   //     updated_at: now,
  //                   //   ),
  //                   // );
  //                   // return e..father_fragment_groups_id = nowFatherId.toValue();
  //                   throw "未处理";
  //                 },
  //               )
  //               .toList(); // 必须 toList，不然调用下面的 map 时会再调用一次上面的 map。
  //
  //           final rFragment2FragmentGroupSyncsResult = <SyncsCompanion>[];
  //           final rFragment2FragmentGroupsResult = dataDownloadForFragmentGroupVo.r_fragment2_fragment_group_list.map(
  //             (e) {
  //               final newId = st.createCloudId(userId: user.id);
  //               rFragment2FragmentGroupSyncsResult.add(Crt.syncsCompanion(
  //                 row_id: newId,
  //                 sync_curd_type: SyncCurdType.c,
  //                 sync_table_name: rFragment2FragmentGroups.actualTableName,
  //                 tag: st.tag,
  //                 created_at: now,
  //                 updated_at: now,
  //               ));
  //               return Crt.rFragment2FragmentGroupsCompanion(
  //                 id: newId,
  //                 creator_user_id: user.id,
  //                 fragment_group_id: fragmentGroupMap[e.fragment_group_id].toValue(),
  //                 fragment_id: e.fragment_id,
  //                 created_at: now,
  //                 updated_at: now, client_be_selected: null,
  //               );
  //             },
  //           ).toList();
  //
  //           final fragmentsResult = dataDownloadForFragmentGroupVo.fragment_list.map(
  //             (e) {
  //               // 若 id 相同,则内容进行修改覆盖,因为始终指向同一个 fragmentId.
  //               return Crt.fragmentsCompanion(
  //                 id: e.id,
  //                 be_sep_publish: e.be_sep_publish,
  //                 client_be_selected: false,
  //                 content: e.content,
  //                 creator_user_id: e.creator_user_id,
  //                 father_fragment_id: e.father_fragment_id.toValue(),
  //                 title: e.title,
  //                 created_at: e.created_at,
  //                 updated_at: e.updated_at,
  //               );
  //             },
  //           ).toList();
  //
  //           batch.insertAll(fragmentGroups, fragmentGroupsResult);
  //           batch.insertAll(syncs, fragmentGroupSyncsResult);
  //           batch.insertAll(rFragment2FragmentGroups, rFragment2FragmentGroupsResult);
  //           batch.insertAll(syncs, rFragment2FragmentGroupSyncsResult);
  //           batch.insertAll(fragments, fragmentsResult, mode: InsertMode.replace);
  //         },
  //       );
  //     },
  //   );
  // }

// Future<User> rawInsertUserAndToken({
//   required UsersCompanion newUsersCompanion,
//   required ClientSyncInfo originalClientSyncInfo,
//   required String token,
// }) async {
//   late User user;
//   await transaction(
//     () async {
//       user = await rawInsertUser(newUsersCompanion: newUsersCompanion);
//       await db.updateDAO.resetClientSyncInfo(
//         originalClientSyncInfoReset: (SyncTag resetSyncTag) async {
//           return originalClientSyncInfo.reset(
//             deviceInfo: toAbsent(),
//             recentSyncTime: toAbsent(),
//             token: token.toValue(),
//             syncTag: resetSyncTag,
//           );
//         },
//         syncTag: null,
//       );
//     },
//   );
//   return user;
// }

  /// 注销当前账户,注销前需要请求服务器端注销.
// Future<void> rawLogoutCurrentUser() async {
//   await transaction(
//     () async {
//       final clientSyncInfoOrNull = await db.generalQueryDAO.queryClientSyncInfoOrNull();
//       if (clientSyncInfoOrNull == null) return;
//       await db.updateDAO.resetClientSyncInfo(
//         originalClientSyncInfoReset: (SyncTag resetSyncTag) async {
//           return clientSyncInfoOrNull.reset(
//             deviceInfo: toAbsent(),
//             recentSyncTime: toAbsent(),
//             token: null.toValue(),
//             syncTag: resetSyncTag,
//           );
//         },
//         syncTag: null,
//       );
//     },
//   );
// }
}
