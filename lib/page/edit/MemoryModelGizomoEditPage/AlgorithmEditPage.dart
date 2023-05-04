import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/MemoryModelGizomoEditPage/AlgorithmEditPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';

import 'MemoryModelGizmoEditPageAbController.dart';

class AlgorithmEditPage extends StatefulWidget {
  const AlgorithmEditPage({Key? key}) : super(key: key);

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
          putController: AlgorithmEditPageAbController(),
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
                  c.filterForType(
                        algorithmType: c.enterType(abw)!.algorithmType,
                        buttonDataStateFunc: () => ButtonDataState.NAME,
                        familiarityStateFunc: () => FamiliarityState.NAME,
                        nextShowTimeStateFunc: () => NextShowTimeState.NAME,
                        abw: abw,
                      ) +
                      " · 方案 ${c.enterType()!.algorithmUsageStatus.name}",
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
                            child: TextButton(
                              child: Text("内置成员"),
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text("预置"),
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text("拷贝管理"),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AbBuilder<AlgorithmEditPageAbController>(
                              builder: (AlgorithmEditPageAbController c, Abw abw) {
                                return TextButton(
                                  child: c.isCurrentRaw(abw) ? Text("常规模式") : Text("纯文本模式"),
                                  onPressed: () {
                                    c.changeRawOrView();
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
                      )
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
