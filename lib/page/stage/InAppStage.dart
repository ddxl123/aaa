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
            actions: [
              IconButton(onPressed: (){}, icon:const Icon(Icons.more_horiz))
            ],
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(c.currentFragmentAndMemoryInfo(abw) == null ? '任务已全部完成！' : c.currentFragmentAndMemoryInfo()!.t1.title),
              ],
            ),
          ),
          // bottomSheet: _bottomWidget(),
        );
      },
    );
  }

//   Widget _bottomWidget() {
//     return AbBuilder<InAppStageAbController>(
//       builder: (c, abw) {
//         return Row(
//           children: c.vMemoryModelButtonDataVerifyResult(abw)?.center.map(
//                 (e) {
//                   return Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
//                       child: ElevatedButton(
//                         style: ButtonStyle(elevation: MaterialStateProperty.all(3)),
//                         child: Text(e.toString()),
//                         onPressed: () {},
//                       ),
//                     ),
//                   );
//                 },
//               ).toList() ??
//               [const Expanded(child: Text('按钮数据获取异常！'))],
//         );
//       },
//     );
//   }
// }
