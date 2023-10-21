import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/MemoryModelGizomoEditPage/AlgorithmEditPage.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MemoryModelGizmoEditPageAbController.dart';

class MemoryModelGizmoEditPage extends StatelessWidget {
  const MemoryModelGizmoEditPage({Key? key, required this.memoryModel}) : super(key: key);
  final MemoryModel memoryModel;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      putController: MemoryModelGizmoEditPageAbController(memoryModel: memoryModel),
      tag: Aber.single,
      builder: (c, abw) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.chevron_left_outlined),
              onPressed: () {
                c.abBack();
              },
            ),
            title: _appBarTitleWidget(),
            actions: [
              _appBarRightAnalyzeWidget(),
              _appBarRightButtonWidget(),
            ],
          ),
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(child: _titleWidget()),
              SliverToBoxAdapter(child: _algorithmWidget(context: context, name: ButtonDataState.name)),
              SliverToBoxAdapter(child: _algorithmWidget(context: context, name: FamiliarityState.name)),
              SliverToBoxAdapter(child: _algorithmWidget(context: context, name: NextShowTimeState.name)),
            ],
          ),
          floatingActionButton: AbwBuilder(
            builder: (fAbw) {
              return c.isAlgorithmKeyboard(fAbw)
                  ? FloatingRoundCornerButton(
                      text: const FaIcon(FontAwesomeIcons.keyboard),
                      onPressed: () {
                        c.changeKeyword();
                      },
                      border: const CircleBorder(),
                    )
                  : FloatingRoundCornerButton(
                      text: const Text('算法键盘'),
                      onPressed: () {
                        c.changeKeyword();
                      },
                    );
            },
          ),
        );
      },
    );
  }

  Widget _appBarTitleWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return Text(c.memoryModel.title);
      },
    );
  }

  Widget _appBarRightAnalyzeWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return TextButton(
          child: const Text('分析'),
          onPressed: () {},
        );
      },
    );
  }

  Widget _appBarRightButtonWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            c.save();
          },
        );
      },
    );
  }

  Widget _titleWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                minLines: 1,
                maxLines: 3,
                controller: c.titleEditingController,
                decoration: const InputDecoration(border: InputBorder.none, labelText: '名称：'),
                onChanged: (v) {
                  c.memoryModel.title = v;
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _algorithmWidget({
    required BuildContext context,
    required String name,
  }) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => AlgorithmEditPage(
                name: name,
                memoryModel: memoryModel,
              ),
            ),
          );
          Aber.findOrNull<MemoryModelGizmoEditPageAbController>()?.thisRefresh();
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(name),
                    filter(
                              from: name,
                              targets: {
                                [ButtonDataState.name]: () => memoryModel.button_algorithm,
                                [FamiliarityState.name]: () => memoryModel.familiarity_algorithm,
                                [NextShowTimeState.name]: () => memoryModel.next_time_algorithm,
                              },
                              orElse: null,
                            ) ==
                            null
                        ? Text(" (未设置)", style: TextStyle(fontSize: 14, color: Colors.red))
                        : Text(" (已设置)", style: TextStyle(fontSize: 14, color: Colors.green)),
                    Spacer(),
                    Icon(Icons.edit_outlined),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        filter(
                              from: name,
                              targets: {
                                [ButtonDataState.name]: () => memoryModel.button_algorithm_remark,
                                [FamiliarityState.name]: () => memoryModel.familiarity_algorithm_remark,
                                [NextShowTimeState.name]: () => memoryModel.next_time_algorithm_remark,
                              },
                              orElse: null,
                            ) ??
                            "无说明",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
