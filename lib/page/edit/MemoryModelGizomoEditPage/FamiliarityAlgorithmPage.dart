import 'package:aaa/algorithm_parser/parser.dart';
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
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {},
              ),
            ],
          ),
          body: FreeBox(
            freeBoxController: c.freeBoxController,
            moveScaleLayerWidgets: FreeBoxMoveScaleLayerStack(
              children: [
                FreeBoxMoveScaleLayerPositioned(
                  expectPosition: Offset(10, 10),
                  child: SizedBox(
                    width: 2500,
                    child: AlgorithmWrapper.fromJsonString(
                      AlgorithmWrapper(
                        customVariables: [
                          CustomVariable(name: "name1", content: "value1", explain: "解释1"),
                          CustomVariable(name: "name2", content: "value2", explain: "解释2"),
                        ],
                        ifElseUseWrapper: IfElseUseWrapper(
                          ifers: [
                            Ifer(
                              condition: "1",
                              use: null,
                              ifElseUseWrapper: IfElseUseWrapper(
                                ifers: [
                                  Ifer(
                                    condition: "11",
                                    use: null,
                                    ifElseUseWrapper: IfElseUseWrapper(
                                      ifers: [
                                        Ifer(
                                          condition: "111",
                                          use: "use",
                                          ifElseUseWrapper: null,
                                          explain: "ddd",
                                        ),
                                      ],
                                      elser: Elser(
                                        use: null,
                                        ifElseUseWrapper: IfElseUseWrapper(
                                          ifers: [
                                            Ifer(
                                              condition: "condition",
                                              use: "use",
                                              ifElseUseWrapper: null,
                                              explain: "explain",
                                            ),
                                          ],
                                          elser: Elser(use: "use1", ifElseUseWrapper: null, explain: "explain"),
                                        ),
                                        explain: "explain",
                                      ),
                                    ),
                                    explain: "dddddd",
                                  ),
                                ],
                                elser: Elser(use: "zzzz", ifElseUseWrapper: null, explain: "eee"),
                              ),
                              explain: "撒大大",
                            ),
                            Ifer(
                              condition: "1",
                              use: null,
                              ifElseUseWrapper: IfElseUseWrapper(
                                ifers: [
                                  Ifer(
                                    condition: "11",
                                    use: null,
                                    ifElseUseWrapper: IfElseUseWrapper(
                                      ifers: [
                                        Ifer(
                                          condition: "111",
                                          use: "use",
                                          ifElseUseWrapper: null,
                                          explain: "ddd",
                                        ),
                                      ],
                                      elser: Elser(
                                        use: null,
                                        ifElseUseWrapper: IfElseUseWrapper(
                                          ifers: [
                                            Ifer(
                                              condition: "condition",
                                              use: "use",
                                              ifElseUseWrapper: null,
                                              explain: "explain",
                                            ),
                                          ],
                                          elser: Elser(use: "use1", ifElseUseWrapper: null, explain: "explain"),
                                        ),
                                        explain: "explain",
                                      ),
                                    ),
                                    explain: "dddddd",
                                  ),
                                  Ifer(
                                    condition: "1",
                                    use: null,
                                    ifElseUseWrapper: IfElseUseWrapper(
                                      ifers: [
                                        Ifer(
                                          condition: "11",
                                          use: null,
                                          ifElseUseWrapper: IfElseUseWrapper(
                                            ifers: [
                                              Ifer(
                                                condition: "111",
                                                use: "use",
                                                ifElseUseWrapper: null,
                                                explain: "ddd",
                                              ),
                                            ],
                                            elser: Elser(
                                              use: null,
                                              ifElseUseWrapper: IfElseUseWrapper(
                                                ifers: [
                                                  Ifer(
                                                    condition: "condition",
                                                    use: "use",
                                                    ifElseUseWrapper: null,
                                                    explain: "explain",
                                                  ),
                                                ],
                                                elser: Elser(use: "use1", ifElseUseWrapper: null, explain: "explain"),
                                              ),
                                              explain: "explain",
                                            ),
                                          ),
                                          explain: "dddddd",
                                        ),
                                      ],
                                      elser: Elser(use: "zzzz", ifElseUseWrapper: null, explain: "eee"),
                                    ),
                                    explain: "撒大大",
                                  ),
                                ],
                                elser: Elser(use: "zzzz", ifElseUseWrapper: null, explain: "eee"),
                              ),
                              explain: "撒大大",
                            ),
                          ],
                          elser: Elser(
                            use: "aaa",
                            ifElseUseWrapper: null,
                            explain: "explain",
                          ),
                        ),
                      ).toJsonString(),
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
                            c.freeBoxController.targetSlide(
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
  }
}
