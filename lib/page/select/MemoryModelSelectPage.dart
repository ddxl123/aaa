import 'package:aaa/page/list/ListPageType.dart';
import 'package:aaa/page/list/MemoryModeListPage.dart';
import 'package:aaa/page/list/MemoryModeListPageAbController.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class MemoryModelSelectPage extends StatelessWidget {
  const MemoryModelSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const MemoryModeListPage(listPageType: ListPageType.selectPath),
            Positioned(
              top: 0,
              left: 0,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    onPressed: () {
                      SmartDialog.showToast('已取消');
                      Navigator.pop(context);
                    },
                  ),
                  const Text('选择记忆规则'),
                ],
              ),
            ),
            // FloatingRoundCornerButton(
            //   text: '确认选择',
            //   onPressed: () {
            //     Aber.findLast<CreateModifyMemoryGroupPageAbController>()
            //         .selectedMemoryModel
            //         .refreshEasy((oldValue) => Aber.findLast<MemoryModelModelAbController>().selected());
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingRoundCornerButton(
        text: '确认选择',
        onPressed: () {
          Aber.findLast<MemoryModeListPageAbController>().confirmSelect();
        },
      ),
      floatingActionButtonLocation: FloatingRoundCornerButtonLocation(context: context, offset: const Offset(0, -50)),
    );
  }
}
