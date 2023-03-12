import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/MemoryModelGizomoEditPage/FamiliarityAlgorithmPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';

import 'MemoryModelGizmoEditPageAbController.dart';

class FamiliarityAlgorithmPage extends StatefulWidget {
  const FamiliarityAlgorithmPage({Key? key}) : super(key: key);

  @override
  State<FamiliarityAlgorithmPage> createState() => _FamiliarityAlgorithmPageState();
}

class _FamiliarityAlgorithmPageState extends State<FamiliarityAlgorithmPage> {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return AbBuilder<FamiliarityAlgorithmPageAbController>(
          putController: FamiliarityAlgorithmPageAbController(),
          builder: (fc, fAbw) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {},
                ),
                actions: [
                  TextButton(
                    child: Text("分析"),
                    onPressed: () {
                      // AlgorithmParser.parse(state: FamiliarityState(algorithmWrapper: algorithmWrapper,
                      //     simulationType: simulationType,
                      //     externalResultHandler: externalResultHandler), onSuccess: onSuccess, onError: onError)
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {},
                  ),
                ],
              ),
              body: FreeBox(
                freeBoxController: fc.freeBoxController,
                moveScaleLayerWidgets: FreeBoxMoveScaleLayerStack(
                  children: [
                    FreeBoxMoveScaleLayerPositioned(
                      expectPosition: Offset(10, 10),
                      child: SizedBox(
                        width: 2500,
                        child: AlgorithmWrapper.fromJsonString(
                          c.copyMemoryModelAb(abw).familiarity_algorithm_a ?? AlgorithmWrapper.emptyAlgorithmWrapper.toJsonString(),
                        ).toWidget(),
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
              ),
            );
          },
        );
      },
    );
  }
}
