import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/material.dart';

class AlgorithmKeyboard extends StatelessWidget {
  static const CKTextInputType inputType = CKTextInputType(name: 'CKAlgorithmKeyboard'); //定义InputType类型
  static double getHeight(BuildContext ctx) {
    //编写获取高度的方法
    return 300;
  }

  final KeyboardController controller; //用于控制键盘输出的Controller
  const AlgorithmKeyboard({required this.controller});

  static register() {
    //注册键盘的方法
    CoolKeyboard.addKeyboard(
      AlgorithmKeyboard.inputType,
      KeyboardConfig(
        builder: (context, controller, params) {
          // 可通过CKTextInputType传参数到键盘内部
          return AlgorithmKeyboard(controller: controller);
        },
        getHeight: AlgorithmKeyboard.getHeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: const Text('if:'),
                  onPressed: () {
                    controller.addText('if:');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
