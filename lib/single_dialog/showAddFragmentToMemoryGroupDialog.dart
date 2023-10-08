import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/page/list/FragmentGroupListSelfPageController.dart';
import 'package:aaa/single_dialog/showCreateMemoryGroupDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

Future<void> showAddFragmentToMemoryGroupDialog() async {
  await showCustomDialog(builder: (_) => const AddFragmentToMemoryGroupDialogWidget());
}

class AddFragmentToMemoryGroupDialogWidget extends StatefulWidget {
  const AddFragmentToMemoryGroupDialogWidget({Key? key}) : super(key: key);

  @override
  State<AddFragmentToMemoryGroupDialogWidget> createState() => _AddFragmentToMemoryGroupDialogWidgetState();
}

class _AddFragmentToMemoryGroupDialogWidgetState extends State<AddFragmentToMemoryGroupDialogWidget> {
  final user = Aber.find<GlobalAbController>().loggedInUser()!;

  /// 记忆组 -> 现有碎片数量。
  final Map<MemoryGroup, int> mgsMap = {};
  MemoryGroup? selectedMg;

  int selectedFragmentsCount = 0;

  int repeatCount = 0;

  bool isRemoveDuplication = true;

  @override
  void initState() {
    super.initState();
    getMgs();
    getSelectedFragmentsCount();
  }

  Future<void> getMgs() async {
    final mgsResult = await request(
      path: HttpPath.POST__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUPS_QUERY,
      dtoData: MemoryGroupsQueryDto(
        user_id: user.id,
        dto_padding_1: null,
      ),
      parseResponseVoData: MemoryGroupsQueryVo.fromJson,
    );
    await mgsResult.handleCode(
      code160101: (String showMessage, MemoryGroupsQueryVo vo) async {
        mgsMap.clear();
        for (var value in vo.memory_groups_list) {
          mgsMap.addAll({value: 0});
        }

        for (var element in vo.memory_groups_list) {
          final countResult = await request(
            path: HttpPath.GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_FRAGMENTS_COUNT_QUERY,
            dtoData: MemoryGroupFragmentsCountQueryDto(
              memory_group_id: element.id,
              dto_padding_1: null,
            ),
            parseResponseVoData: MemoryGroupFragmentsCountQueryVo.fromJson,
          );
          await countResult.handleCode(
            code160201: (String showMessage, vo) async {
              mgsMap[element] = vo.count;
            },
          );
        }
        if (mounted) setState(() {});
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
  }

  Future<void> getSelectedFragmentsCount() async {
    selectedFragmentsCount = (await Aber.findOrNullLast<FragmentGroupListSelfPageController>()?.getSelectedFragmentsCount()) ?? 0;
    if (mounted) setState(() {});
  }

  Widget _topRightAction() {
    return IconButton(
      icon: const Icon(Icons.add),
      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      onPressed: () async {
        await showCreateMemoryGroupDialog();
        mgsMap.clear();
        selectedMg = null;
        await getMgs();
      },
    );
  }

  List<Widget> _columnChildren() {
    return mgsMap.keys.map(
      (e) {
        return TextButton(
          style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
          child: Row(
            children: [
              Expanded(child: Text(e.title)),
              const SizedBox(width: 10),
              Text('${mgsMap[e]}', style: const TextStyle(color: Colors.grey)),
              selectedMg == e ? Text(' +$selectedFragmentsCount', style: const TextStyle(color: Colors.green)) : Container(),
              const SizedBox(width: 10),
              if (selectedMg == e) const SolidCircleIcon() else const SolidCircleGreyIcon(),
            ],
          ),
          onPressed: () async {
            if (selectedMg == e) {
              selectedMg = null;
            } else {
              selectedMg = e;
            }
            setState(() {});
          },
        );
      },
    ).toList();
  }

  Future<void> _onOk() async {
    if (selectedMg == null) {
      SmartDialog.showToast('未选择！');
    } else {
      // TODO: 增加完整性修复功能，检查数量是否相等，完整性修复可以检查每个碎片信息的 id 是否与云端相同。

      // 查询已存在于该记忆组内的全部碎片id，
      final mgFragmentIdsResult = await request(
        path: HttpPath.GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_FRAGMENT_IDS_QUERY,
        dtoData: MemoryGroupFragmentIdsQueryDto(
          memory_group_id: selectedMg!.id,
          dto_padding_1: null,
        ),
        parseResponseVoData: MemoryGroupFragmentIdsQueryVo.fromJson,
      );
      await mgFragmentIdsResult.handleCode(
        code160401: (String showMessage, vo) async {
          // 只插入云端，且只插入不存在于当前记忆组内的碎片。
          final will = (await Aber.findOrNullLast<FragmentGroupListSelfPageController>()!.getSelectedFragments()).toSet().difference(vo.fragment_ids_list.toSet());
          final willMap = will
              .map((e) => Crt.fragmentMemoryInfoEntity(
                    creator_user_id: user.id,
                    fragment_id: e,
                    memory_group_id: selectedMg!.id,
                    actual_show_time: [].toJsonString(),
                    button_values: [].toJsonString(),
                    click_familiarity: [].toJsonString(),
                    click_time: [].toJsonString(),
                    click_value: [].toJsonString(),
                    content_value: [].toJsonString(),
                    next_plan_show_time: [].toJsonString(),
                    show_familiarity: [].toJsonString(),
                    study_status: StudyStatus.never,
                    sync_version: 0,
                    be_synced: false,
                  ))
              .toList();

          final result = await request(
            path: HttpPath.POST__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_SELECTED_FRAGMENTS_INSERT,
            dtoData: MemoryGroupSelectedFragmentsInsertDto(
              fragment_memory_infos_list: willMap,
              memory_group_id: selectedMg!.id,
            ),
            parseResponseVoData: MemoryGroupSelectedFragmentsInsertVo.fromJson,
          );
          await result.handleCode(
            code160301: (String showMessage, vo) async {
              // 这里不插入到本地，而是在记忆组中提示是否要下载。
              SmartDialog.dismiss();
              SmartDialog.showToast('添加成功！');
              await showCustomDialog(
                builder: (ctx) => OkAndCancelDialogWidget(
                  text: "是否现在下载？",
                  okText: "下载",
                  cancelText: "等会下",
                  onOk: () async {
                    SmartDialog.showLoading(msg: "下载中...");
                    final result = await request(
                      path: HttpPath.POST__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_MEMORY_INFO_DOWNLOAD_BY_IDS,
                      dtoData: MemoryGroupMemoryInfoDownloadByIdsDto(
                        memory_info_ids_list: vo.memory_info_ids_list,
                        dto_padding_1: null,
                      ),
                      onReceiveProgress: (count, total) {
                        // TODO: 下载中...
                      },
                      parseResponseVoData: MemoryGroupMemoryInfoDownloadByIdsVo.fromJson,
                    );
                    await result.handleCode(
                      code161701: (String showMessage, MemoryGroupMemoryInfoDownloadByIdsVo vo) async {
                        await driftDb.insertDAO.insertManyFragmentAndMemoryInfos(fragmentAndMemoryInfos: vo.fragment_and_memory_infos_list);
                      },
                    );
                    SmartDialog.dismiss(status: SmartStatus.loading);
                  },
                ),
              );
            },
          );
        },
        otherException: (a, b, c) async {
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OkAndCancelDialogWidget(
      dialogSize: DialogSize(width: globalDialogFixedWidth, height: null),
      title: '添加至记忆组：',
      topRightAction: _topRightAction(),
      columnChildren: mgsMap.isEmpty ? const [Text('未创建记忆组', style: TextStyle(color: Colors.grey))] : _columnChildren(),
      cancelText: '再选选($selectedFragmentsCount)',
      okText: '添加',
      onCancel: () async {
        SmartDialog.dismiss();
      },
      onOk: _onOk,
      topKeepWidget: Row(
        children: [
          Text(
            "请选择记忆组",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
      // bottomKeepWidget: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     const Text('去除重复'),
      //     Switch(
      //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //       value: isRemoveDuplication,
      //       onChanged: (v) async {
      //         if (selectedMg != null) {
      //           if (v) {
      //             repeatCount = await db.generalQueryDAO.querySelectedFragmentsRepeatCount(memoryGroup: selectedMg!);
      //           } else {
      //             repeatCount = 0;
      //           }
      //         }
      //         isRemoveDuplication = v;
      //         if (mounted) setState(() {});
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
