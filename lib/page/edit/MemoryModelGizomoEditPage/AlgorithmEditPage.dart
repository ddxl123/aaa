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
                  TextButton(
                    child: Text("分析"),
                    onPressed: () {
                      fc.analysis();
                    },
                  ),
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
                        FreeBoxMoveScaleLayerPositioned(
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
            );
          },
        );
      },
    );
  }
}
