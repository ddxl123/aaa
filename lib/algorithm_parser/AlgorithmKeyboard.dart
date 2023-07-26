// import 'package:aaa/algorithm_parser/parser.dart';
// import 'package:cool_ui/cool_ui.dart';
// import 'package:flutter/material.dart';
//
// class AlgorithmKeyboard extends StatelessWidget {
//   AlgorithmKeyboard({super.key, required this.controller});
//
//   static const CKTextInputType inputType = CKTextInputType(name: 'CKAlgorithmKeyboard'); //定义InputType类型
//
//   static double getHeight(BuildContext ctx) {
//     return ctx.size!.height / 3;
//   }
//
//   final KeyboardController controller; //用于控制键盘输出的Controller
//
//   static register() {
//     //注册键盘的方法
//     CoolKeyboard.addKeyboard(
//       AlgorithmKeyboard.inputType,
//       KeyboardConfig(
//         builder: (context, controller, params) {
//           // 可通过CKTextInputType传参数到键盘内部
//           return AlgorithmKeyboard(controller: controller);
//         },
//         getHeight: AlgorithmKeyboard.getHeight,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //键盘的具体内容
//     return Card(
//       //例子
//       color: Colors.white,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(padding: EdgeInsets.all(10), child: Text('关键字：')),
//                   Wrap(
//                     spacing: 10,
//                     children: [
//                       ...keywordsWithColon.map(
//                         (e) => ElevatedButton(
//                           child: Text(e),
//                           onPressed: () {
//                             controller.addText(e);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(),
//                   const Padding(padding: EdgeInsets.all(10), child: Text('逻辑运算符：')),
//                   Wrap(
//                     spacing: 10,
//                     children: [
//                       ...oLogicalOperator.map(
//                         (e) => ElevatedButton(
//                           child: Text(e),
//                           onPressed: () {
//                             controller.addText(e);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(),
//                   const Padding(padding: EdgeInsets.all(10), child: Text('关系运算符：')),
//                   Wrap(
//                     spacing: 10,
//                     children: [
//                       ...oRelationalOperator.map(
//                         (e) => ElevatedButton(
//                           child: Text(e),
//                           onPressed: () {
//                             controller.addText(e);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(),
//                   const Padding(padding: EdgeInsets.all(10), child: Text('空合并运算符：')),
//                   Wrap(
//                     spacing: 10,
//                     children: [
//                       ElevatedButton(
//                         child: const Text(oEmptyMergeOperator),
//                         onPressed: () {
//                           controller.addText(oEmptyMergeOperator);
//                         },
//                       ),
//                     ],
//                   ),
//                   const Divider(),
//                   const Padding(padding: EdgeInsets.all(10), child: Text('内置变量：')),
//                   Wrap(
//                     spacing: 10,
//                     children: [
//                       ...InternalVariableConstantHandler.getNames.map(
//                         (e) => ElevatedButton(
//                           child: Text(e),
//                           onPressed: () {
//                             controller.addText(e);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(),
//                   const Padding(padding: EdgeInsets.all(10), child: Text('内置扩展变量类型：')),
//                   Wrap(
//                     spacing: 10,
//                     children: [
//                       ...NType.values.map(
//                         (e) => ElevatedButton(
//                           child: Text('_${e.name.split('.').last}'),
//                           onPressed: () {
//                             controller.addText('_${e.name.split('.').last}');
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           // TODO: 若不滚动，则快速切换键盘时，会出现 RenderFlex overflowed 异常！
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.blue),
//                       fixedSize: MaterialStateProperty.all(const Size(80, 40)),
//                       overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent),
//                     ),
//                     child: const Text('<—', style: TextStyle(color: Colors.white)),
//                     onPressed: () {
//                       controller.deleteOne();
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.blue),
//                         fixedSize: MaterialStateProperty.all(const Size(80, 40)),
//                         overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent)),
//                     child: const Text('( )', style: TextStyle(color: Colors.white)),
//                     onPressed: () {
//                       controller.addText('()');
//                       final s = controller.selection;
//                       controller.selection = s.copyWith(baseOffset: s.start - 1, extentOffset: s.start - 1);
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.blue),
//                         fixedSize: MaterialStateProperty.all(const Size(80, 40)),
//                         overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent)),
//                     child: const Text('空格', style: TextStyle(color: Colors.white)),
//                     onPressed: () {
//                       controller.addText(' ');
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.blue),
//                         fixedSize: MaterialStateProperty.all(const Size(80, 40)),
//                         overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent)),
//                     child: const Text('换行', style: TextStyle(color: Colors.white)),
//                     onPressed: () {
//                       controller.addText('\n');
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
