import 'package:aaa/page/stage/InAppStageAbController.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';

class InAppStage extends StatefulWidget {
  const InAppStage({Key? key, required this.memoryGroupGizmo}) : super(key: key);

  final Ab<MemoryGroup> memoryGroupGizmo;

  @override
  State<InAppStage> createState() => _InAppStageState();
}

class _InAppStageState extends State<InAppStage> {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<InAppStageAbController>(
      putController: InAppStageAbController(memoryGroupAb: widget.memoryGroupGizmo),
      builder: (c, abw) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [_moreButtonWidget()],
          ),
          body: _body(),
          bottomSheet: _bottomWidget(),
        );
      },
    );
  }

  Widget _moreButtonWidget() {
    return AbBuilder<InAppStageAbController>(
      builder: (c, abw) {
        return CustomDropdownBodyButton(
          initValue: 0,
          primaryButton: const Icon(Icons.more_horiz),
          items: [
            Item(value: 0, text: c.isButtonDataShowValue(abw) ? '按钮显示时间' : '按钮显示算法数值'),
          ],
          onChanged: (v) {
            c.isButtonDataShowValue.refreshEasy((oldValue) => !oldValue);
          },
        );
      },
    );
  }

  Widget _bottomWidget() {
    return AbBuilder<InAppStageAbController>(
      builder: (c, abw) {
        if (c.currentPerformer(abw) == null) return const SizedBox(height: 0);
        if (c.currentButtonDataState(abw) == null) return Row(children: const [Expanded(child: Text('获取按钮数据异常！'))]);
        return Row(
          children: c.currentButtonDataState()!.resultButtonValues.map(
            (e) {
              final parseTime = e.parseTime();
              if (parseTime == null) {
                return const SizedBox(height: 0);
              }
              return Expanded(
                child: AbwBuilder(
                  builder: (abw) {
                    return TextButton(
                      child: Text(c.isButtonDataShowValue(abw) ? e.value.toString() : parseTime),
                      onPressed: () async {
                        await c.finishAndNext(clickValue: e.value);
                      },
                    );
                  },
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }

  Widget _body() {
    return AbBuilder<InAppStageAbController>(
      builder: (c, abw) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: c.currentPerformer(abw) == null
              ? const Center(
                  child: Text('任务已全部完成！'),
                )
              : q.QuillEditor.basic(
                  controller: c.quillController,
                  readOnly: true,
                ),
        );
      },
    );
  }
}
