// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// Future<T> showOkCancelDialog<T>({
//   required BuildContext context,
//   String? title,
//   String? message,
//   required String okContent,
//   required String cancelContent,
// }) async {
//   Widget titleWidget = title == null
//       ? Container()
//       : DefaultTextStyle(style: Theme.of(context).textTheme.titleLarge!, child: Text(title));
//
//   Widget messageWidget = message == null
//       ? Container()
//       : DefaultTextStyle(style: Theme.of(context).textTheme.titleMedium!, child: Text(message));
//
//   return await showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         alignment: Alignment.center,
//         child: Material(
//           type: MaterialType.transparency,
//           child: Container(
//             margin: const EdgeInsets.all(50),
//             padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black26)],
//               color: Colors.white,
//             ),
//             child: IntrinsicWidth(
//               child: IntrinsicHeight(
//                 //①
//                 child: Column(
//                   children: [
//                     // 可防止 SingleChildScrollView 高度过大而使 Column① 溢出.
//                     Flexible(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             titleWidget,
//                             title == null ? Container() : const SizedBox(height: 20),
//                             messageWidget,
//                             message == null ? Container() : const SizedBox(height: 20),
//                           ],
//                           // stretch 要求子元素充满横轴(即 Text 充满横轴),可在 Text 内部设置 TextAlign
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Flexible(
//                           child: MaterialButton(
//                             child: Text(cancelContent),
//                             onPressed: () {},
//                           ),
//                         ),
//                         Flexible(
//                           child: MaterialButton(
//                             child: Text(okContent, style: const TextStyle(color: Colors.red)),
//                             onPressed: () {},
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
