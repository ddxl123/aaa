import 'package:aaa/page/stage/InAppStageAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
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
          ),
          body: Center(
            child: Column(
              children: [
                Text(c.currentFragmentAndMemoryInfo(abw)?.t1.title ?? '任务已全部完成！'),
              ],
            ),
          ),
        );
      },
    );
  }
}
