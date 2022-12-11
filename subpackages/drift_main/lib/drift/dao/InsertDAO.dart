part of drift_db;

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: tableClasses,
)
class InsertDAO extends DatabaseAccessor<DriftDb> with _$InsertDAOMixin {
  InsertDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<User> insertUser() async {
    final findUser = await select(users).getSingleOrNull();
    if (findUser != null) throw '已存在用户！';
    return await Crt.usersCompanion(
      age: 18,
      email: '1033839760@qq.com'.toValue(),
      password: 'password'.toValue(),
      username: 'username',
    ).insert(syncTag: null);
  }

  /// 向当前 [FragmentGroups] 表中插入一条数据, 返回新插入的 [FragmentGroup]。
  Future<FragmentGroup> insertFragmentGroupWithRef(FragmentGroupsCompanion willEntity) async {
    late FragmentGroup returnFragmentGroup;
    await withRefs(
      syncTag: await SyncTag.create(),
      ref: (syncTag) async => RefFragmentGroups(
        self: (table) async {
          returnFragmentGroup = await insertReturningWith(table, entity: willEntity, syncTag: syncTag);
        },
        child_fragmentGroups: null,
        rFragment2FragmentGroups: null,
      ),
    );
    return returnFragmentGroup;
  }

  /// 向当前 [Fragments] 表中插入一条数据, 返回新插入的 [Fragment]。
  Future<Fragment> insertFragmentWithRef({
    required FragmentsCompanion willFragment,
    required FragmentGroupsCompanion? willFragmentGroup,
  }) async {
    late Fragment newFragment;
    await withRefs(
      syncTag: await SyncTag.create(),
      ref: (syncTag) async => RefFragments(
        self: (table) async {
          newFragment = await willFragment.insert(syncTag: syncTag);
        },
        rFragment2FragmentGroups: RefRFragment2FragmentGroups(
          self: (table) async {
            await Crt.rFragment2FragmentGroupsCompanion(
              creatorUserId: willFragment.creatorUserId.value,
              fragmentGroupId: willFragmentGroup?.id ?? null.toValue(),
              fragmentId: willFragment.id.value,
            ).insert(syncTag: syncTag);
          },
        ),
        child_fragments: null,
        fragmentMemoryInfos: null,
        memoryModels: null,
      ),
    );
    return newFragment;
  }

  /// 创建一个记忆
  Future<void> insertMemoryGroupWithOtherWithRef({required MemoryGroupsCompanion willMemoryGroup, required List<Fragment> willFragments}) async {
    // late MemoryGroup newMemoryGroup;
    // await withRefs(
    //   syncTag: await SyncTag.create(),
    //   ref: (syncTag) async => RefMemoryGroups(
    //     self: (table) async {
    //       newMemoryGroup = await insertReturningWith(table, entity: willMemoryGroup, syncTag: syncTag);
    //     },
    //     rFragment2MemoryGroups: RefRFragment2MemoryGroups(
    //       self: (table) async {
    //         await Future.forEach<Fragment>(
    //           willFragments,
    //           (element) async {
    //             await insertReturningWith(
    //               table,
    //               entity: WithCrts.rFragment2MemoryGroupsCompanion(
    //                 fatherId: newMemoryGroup.id.toValue(),
    //                 sonId: element.id,
    //               ),
    //               syncTag: syncTag,
    //             );
    //           },
    //         );
    //       },
    //     ),
    //     fragmentMemoryInfos: null,
    //   ),
    // );
  }

  Future<MemoryModel> insertMemoryModelWithRef(MemoryModelsCompanion willEntry) async {
    // late MemoryModel newMemoryModel;
    // await withRefs(
    //   syncTag: await SyncTag.create(),
    //   ref: (syncTag) async => RefMemoryModels(
    //     self: (table) async {
    //       newMemoryModel = await insertReturningWith(table, entity: willEntry, syncTag: syncTag);
    //     },
    //     memoryGroups: null,
    //   ),
    // );
    // return newMemoryModel;
    return MemoryModel(
      id: '',
      title: '',
      creatorUserId: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      buttonAlgorithm: '',
      familiarityAlgorithm: '',
      nextTimeAlgorithm: '',
      stimulateAlgorithm: '',
    );
  }
}
