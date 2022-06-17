import 'package:aaa/tool/WidgetWrapper.dart';
import 'package:aaa/widget_model/MemoryRuleModel.dart';
import 'package:aaa/widget_model/MemoryRuleModelAbController.dart';
import 'package:flutter/material.dart';

class MemoryRuleChoosePage extends StatelessWidget {
  const MemoryRuleChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const MemoryRuleModel(modelType: MemoryRuleModelType.select),
            Positioned(
              top: 0,
              left: 0,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text('选择记忆规则'),
                ],
              ),
            ),
            FloatingConfirmPosition(
              text: '确认选择',
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
