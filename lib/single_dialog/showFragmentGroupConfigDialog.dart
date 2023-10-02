import 'package:aaa/page/edit/FragmentGroupGizmoEditPage.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:tools/tools.dart';

import '../page/list/FragmentGroupListSelfPageController.dart';

Future<void> showFragmentGroupConfigDialog({required FragmentGroupListSelfPageController c, required Ab<FragmentGroup?> currentDynamicFragmentGroupAb}) async {
  return await showCustomDialog(
    builder: (_) {
      return _PrivatePublishDialogWidget(
        c: c,
        currentDynamicFragmentGroupAb: currentDynamicFragmentGroupAb,
      );
    },
  );
}

class _PrivatePublishDialogWidget extends StatefulWidget {
  const _PrivatePublishDialogWidget({super.key, required this.currentDynamicFragmentGroupAb, required this.c});

  final FragmentGroupListSelfPageController c;
  final Ab<FragmentGroup?> currentDynamicFragmentGroupAb;

  @override
  State<_PrivatePublishDialogWidget> createState() => _PrivatePublishDialogWidgetState();
}

class _PrivatePublishDialogWidgetState extends State<_PrivatePublishDialogWidget> {
  final privateJustTheController = JustTheController();
  final publishJustTheController = JustTheController();

  Widget single({required String number, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$number. "),
        Expanded(child: Text(text)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      mainVerticalWidgets: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              child: Text("编辑"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FragmentGroupGizmoEditPage(currentDynamicFragmentGroupAb: widget.currentDynamicFragmentGroupAb),
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {},
              child: Text("查看详情"),
            ),
          ],
        ),
        Divider(color: Colors.black12),
        Row(
          children: [
            Text("是否发布", style: TextStyle(fontSize: 16)),
            SizedBox(width: 10),
            JustTheTooltip(
              controller: publishJustTheController,
              backgroundColor: Colors.grey.shade800,
              content: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("发布：会在首页中被推荐，也可被搜索到", style: TextStyle(color: Colors.white)),
                    Text("不发布：不会在首页中被推荐，也无法被搜索到", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              child: GestureDetector(
                child: Icon(Icons.error, color: Colors.blue, size: 18),
                onTap: () {
                  publishJustTheController.showTooltip();
                },
              ),
            ),
            Transform.scale(
              scaleX: 0.8,
              scaleY: 0.8,
              child: Switch(
                activeColor: Colors.green,
                inactiveThumbColor: Colors.grey,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: widget.currentDynamicFragmentGroupAb()!.be_publish,
                onChanged: (v) async {
                  if (widget.currentDynamicFragmentGroupAb()!.be_publish) {
                    await showCustomDialog(
                      builder: (BuildContext context) {
                        return OkAndCancelDialogWidget(
                          okText: "取消发布",
                          cancelText: "返回",
                          title: "取消发布说明：",
                          columnChildren: [
                            single(number: "1", text: "知识库中将不显示且无法搜索到该碎片组。"),
                            single(number: "2", text: "知识库中若其他碎片组内含有该碎片组，则该碎片组将不会在其他碎片组内显示。"),
                            single(number: "3", text: "已下载过的用户仍然留存着该碎片组。"),
                            single(number: "4", text: "即使取消了发布，对该碎片组进行增、删、改、移等操作，已下载过的用户仍然会被通知更新。"),
                          ],
                          onOk: () async {
                            final result = await request(
                              path: HttpPath.POST__LOGIN_REQUIRED_SINGLE_ROW_MODIFY,
                              dtoData: SingleRowModifyDto(
                                table_name: driftDb.fragmentGroups.actualTableName,
                                row: widget.currentDynamicFragmentGroupAb()!..be_publish = false,
                              ),
                              parseResponseVoData: SingleRowModifyVo.fromJson,
                            );
                            await result.handleCode(
                              code110101: (String showMessage, SingleRowModifyVo vo) async {
                                setState(() {});
                                widget.currentDynamicFragmentGroupAb.refreshInevitable((obj) => obj!..be_publish = v);
                                widget.c.thisRefresh();
                                Navigator.pop(context);
                              },
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  } else {
                    await showCustomDialog(
                      builder: (BuildContext context) {
                        return OkAndCancelDialogWidget(
                          okText: "发布",
                          cancelText: "返回",
                          title: "发布说明：",
                          text: "1. 将会在知识库中显示，并可被搜索到。\n2. 如果父碎片组已发布，则该碎片组将会额外发布一份。",
                          columnChildren: [
                            Text("对发布者：", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            single(
                              number: "1",
                              text: "其他用户下载你发布的碎片组，"
                                  "其碎片/碎片组引用的是你发布的碎片本身，"
                                  "而不是拷贝版，因此哪怕你取消了发布，"
                                  "只要对碎片进行任意操作，都会通知给已下载的用户进行更新。",
                            ),
                            single(
                              number: "2",
                              text: "其他用户下载你发布的碎片组，其用户是可以对下载的碎片或碎片组进行更改、删除，"
                                  "但一旦该用户进行更新或重新下载（包括app清除数据），都会被还原成您发布的。",
                            ),
                            single(
                              number: "3",
                              text: "其他用户下载你发布的碎片组，其用户在碎片组内进行新增碎片或碎片组后，"
                                  "进行了更新或重新下载，新增的仍然会被保留。",
                            ),
                            single(
                              number: "4",
                              text: "为考虑已下载的用户，尽可能不对碎片或碎片组进行删除，"
                                  "否则用户进行重新下载或更新时，将会丢失被删除部分。",
                            ),
                            single(
                              number: "4",
                              text: "为考虑已下载的用户，尽可能在内部进行移动，"
                                  "若移动到外部，则用户更新或重新下载会导致移出去的部分丢失。",
                            ),
                            SizedBox(height: 5),
                            Text("对下载者：", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            single(number: "1", text: "删除：更新或重新下载会重新出现。"),
                            single(number: "2", text: "移动：可以移动到任意地方，但更新或重新下载会被归位。"),
                            single(number: "3", text: "修改：更新或重新下载会被复原。"),
                            single(number: "4", text: "新增：更新或重新下载后，新增的会被保留。"),
                          ],
                          onOk: () async {
                            final result = await request(
                              path: HttpPath.POST__LOGIN_REQUIRED_SINGLE_ROW_MODIFY,
                              dtoData: SingleRowModifyDto(
                                table_name: driftDb.fragmentGroups.actualTableName,
                                row: widget.currentDynamicFragmentGroupAb()!..be_publish = true,
                              ),
                              parseResponseVoData: SingleRowModifyVo.fromJson,
                            );
                            await result.handleCode(
                              code110101: (String showMessage, SingleRowModifyVo vo) async {
                                setState(() {});
                                widget.currentDynamicFragmentGroupAb.refreshInevitable((obj) => obj!..be_publish = v);
                                widget.c.thisRefresh();
                                Navigator.pop(context);
                              },
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
      bottomHorizontalButtonWidgets: [],
    );
  }
}
