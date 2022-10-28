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
          body: Container(
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(c.fragmentAndMemoryInfos(abw) == null ? '任务已全部完成！' : c.fragmentAndMemoryInfos()!.t1.title),
                ],
              ),
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
            Tuple2(t1: c.isButtonDataShowValue(abw) ? '按钮显示时间' : '按钮显示数值', t2: 0),
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
        if (c.fragmentAndMemoryInfos(abw) == null) return const SizedBox(height: 0);
        if (c.buttonDataState(abw) == null) return Row(children: const [Expanded(child: Text('获取按钮数据异常！'))]);
        if (!c.buttonDataState(abw)!.isSlidable) {
          // 不可滑动
          return Row(
            children: c.buttonDataState()!.resultButtonValues.map(
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
                          await c.finishAndStartNextPerform(clickValue: e.value);
                        },
                      );
                    },
                  ),
                );
              },
            ).toList(),
          );
        } else {
          // 可滑动
          return Row(
            children: c.buttonDataState()!.resultButtonValues.map(
              (e) {
                final parseTime = e.parseTime();
                if (parseTime == null) {
                  return const SizedBox(height: 0);
                }
                return Expanded(
                  child: ElevatedButton(
                    child: AbwBuilder(
                      builder: (abw) {
                        return Text(c.isButtonDataShowValue(abw) ? e.value.toString() : parseTime);
                      },
                    ),
                    onPressed: () async {
                      await c.finishAndStartNextPerform(clickValue: e.value);
                    },
                  ),
                );
              },
            ).toList(),
          );
        }
      },
    );
  }
}
