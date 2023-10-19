import 'package:aaa/algorithm_parser/default.dart';
import 'package:aaa/page/edit/MemoryModelGizomoEditPage/AlgorithmEditPageAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tools/tools.dart';

import 'MemoryModelGizmoEditPageAbController.dart';

class AlgorithmEditPage extends StatefulWidget {
  const AlgorithmEditPage({
    Key? key,
    required this.name,
    required this.memoryModel,
  }) : super(key: key);
  final String name;
  final MemoryModel memoryModel;

  @override
  State<AlgorithmEditPage> createState() => _AlgorithmEditPageState();
}

class _AlgorithmEditPageState extends State<AlgorithmEditPage> {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return AbBuilder<AlgorithmEditPageAbController>(
          putController: AlgorithmEditPageAbController(name: widget.name),
          builder: (fc, fAbw) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    c.abBack();
                  },
                ),
                title: Text(
                  widget.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                titleSpacing: 0,
                actions: [
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      fc.save();
                    },
                  ),
                ],
              ),
              body: AbBuilder<AlgorithmEditPageAbController>(
                builder: (c, abw) {
                  return FreeBox(
                    freeBoxController: fc.freeBoxController,
                    moveScaleLayerWidgets: FreeBoxMoveScaleLayerStack(
                      children: [
                        c.isCurrentRaw(abw)
                            ? FreeBoxMoveScaleLayerPositioned(
                                expectPosition: Offset(10, 10),
                                child: SizedBox(
                                  width: 1000,
                                  child: TextField(
                                    controller: c.rawTextEditingController,
                                    minLines: 20,
                                    maxLines: 1000,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                    ),
                                  ),
                                ),
                              )
                            : FreeBoxMoveScaleLayerPositioned(
                                expectPosition: Offset(10, 10),
                                child: SizedBox(
                                  width: 2500,
                                  child: c.currentAlgorithmWrapper(abw).toWidget(),
                                ),
                              ),
                      ],
                    ),
                    fixedLayerWidgets: [
                      FreeBoxFixedLayerPositioned(
                        bottom: 50,
                        right: 25,
                        child: Column(
                          children: [
                            AbwBuilder(
                              builder: (abw) {
                                return IconButton(
                                  icon: Icon(FontAwesomeIcons.locationCrosshairs, size: 28),
                                  onPressed: () {
                                    fc.freeBoxController.targetSlide(
                                      targetCamera: FreeBoxCamera(expectPosition: Offset.zero, expectScale: 1.0),
                                      rightNow: false,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              bottomNavigationBar: AbBuilder<AlgorithmEditPageAbController>(
                builder: (AlgorithmEditPageAbController bnC, Abw bnAbw) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AbBuilder<AlgorithmEditPageAbController>(
                              builder: (AlgorithmEditPageAbController c, Abw abw) {
                                return TextButton(
                                  child: c.isCurrentRaw(abw) ? Text("切换至常规编辑") : Text("切换至纯文本编辑"),
                                  onPressed: () {
                                    c.changeRawOrView(null);
                                  },
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text("格式化"),
                              onPressed: () {
                                bnC.rawFormatting();
                              },
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text("分析"),
                              onPressed: () {
                                bnC.analysis();
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              child: Text("查看内置成员"),
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text("预置"),
                              onPressed: () {
                                showMaterialModalBottomSheet(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                  context: c.context,
                                  builder: (BuildContext context) {
                                    return Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text("请选择一个算法预设", style: TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height / 2,
                                            child: ListView(
                                              children: DefaultAlgorithmOfRaw.getDefaults()
                                                  .map(
                                                    (e) => Row(
                                                      children: [
                                                        Text(e.title + "："),
                                                        Expanded(
                                                          child: TextButton(
                                                            child: Text("熟悉度变化算法"),
                                                            onPressed: () {
                                                              bnC.defaultToPaste(e.familiarityContent);
                                                            },
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: TextButton(
                                                            child: Text("下一次展示时间点算法"),
                                                            onPressed: () {
                                                              bnC.defaultToPaste(e.nextShowTimeContent);
                                                            },
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: TextButton(
                                                            child: Text("按钮数据算法"),
                                                            onPressed: () {
                                                              bnC.defaultToPaste(e.buttonDataContent);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text("帮助"),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
