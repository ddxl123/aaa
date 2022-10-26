import 'package:aaa/page/stage/InAppStageAbController.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/DriftDb.dart';
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
      putController: InAppStageAbController(memoryGroupGizmo: widget.memoryGroupGizmo),
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
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(c.fragmentAndMemoryInfos(abw) == null ? '任务已全部完成！' : c.fragmentAndMemoryInfos()!.t1.title),
              ],
            ),
          ),
          bottomSheet: _bottomWidget(),
        );
      },
    );
  }

  Widget _moreButtonWidget() {
    return AbBuilder<InAppStageAbController>(
      builder: (c, abw) {
        return CustomDropdownBodyButton(
          value: 0,
          dropdownWidth: 150,
          customButton: const CustomDropdownPrimaryButtonContainer(child: Icon(Icons.more_horiz)),
          item: [
            Tuple2(t1: '按钮显示时间', t2: 0),
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
        if (c.fragmentAndMemoryInfos(abw) == null) return Container();
        if (c.buttonDataState(abw) == null) return Row(children: const [Expanded(child: Text('获取按钮数据异常！'))]);
        if (!c.buttonDataState(abw)!.isSlidable) {
          return Row(
            children: c
                .buttonDataState()!
                .resultButtonValues
                .map(
                  (e) => Expanded(
                    child: TextButton(
                      child: AbwBuilder(
                        builder: (abw) {
                          return TextButton(
                            onPressed: () {},
                            child: Text(c.isButtonDataShowValue(abw) ? e.value.toString() : e.parseTime()),
                          );
                        },
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
                .toList(),
          );
        } else {
          return Row(
            children: c
                .buttonDataState()!
                .resultButtonValues
                .map(
                  (e) => Expanded(
                    child: ElevatedButton(
                      child: AbwBuilder(
                        builder: (abw) {
                          return Text(c.isButtonDataShowValue(abw) ? e.value.toString() : e.parseTime());
                        },
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }
}
