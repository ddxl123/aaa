// import 'dart:ui';
//
// import 'package:demo/util/sheetroute/LoadAreaController.dart';
// import 'package:flutter/material.dart';
//
// class LoadAreaAnimationWidget extends StatefulWidget {
//   const LoadAreaAnimationWidget(this.loadAreaController);
//
//   final LoadAreaController loadAreaController;
//
//   @override
//   _LoadAreaAnimationWidgetState createState() => _LoadAreaAnimationWidgetState();
// }
//
// class _LoadAreaAnimationWidgetState extends State<LoadAreaAnimationWidget> with SingleTickerProviderStateMixin {
//   /// -1表示被dispose,0表示loading,1表示success,2表示fail
//   int _stataus = 1;
//
//   @override
//   void dispose() {
//     _stataus = -1;
//     widget.loadAreaController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     widget.loadAreaController.animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
//     widget.loadAreaController.animation = CurvedAnimation(parent: widget.loadAreaController.animationController, curve: Curves.linear);
//     widget.loadAreaController.animation =
//         Tween<double>(begin: 0.0, end: MediaQueryData.fromWindow(window).size.width).animate(widget.loadAreaController.animation);
//     widget.loadAreaController.toLoading = _toLoading;
//     widget.loadAreaController.toSuccess = _toSuccess;
//     widget.loadAreaController.toFailure = _toFail;
//   }
//
//   Future<void> _toLoading(Duration wait, void startFuture(LoadAreaController loadAreaController)) async {
//     /// 保证了仅触发一次
//     if (_stataus == 0 || _stataus == -1) {
//       return;
//     }
//     _stataus = 0;
//     widget.loadAreaController.animationController.value = 0.0;
//     widget.loadAreaController.animationController.repeat(reverse: true);
//     widget.loadAreaController.animationController.addListener(() {
//       setState(() {});
//       if (widget.loadAreaController.animationController.value == 1.0) {
//         widget.loadAreaController.animationController.reverse();
//       }
//     });
//     // 触发异步操作后的进一步指令
//     await Future<void>.delayed(wait);
//     startFuture(widget.loadAreaController);
//   }
//
//   void _toSuccess() {
//     if (_stataus == 1 || _stataus == -1) {
//       return;
//     }
//     _stataus = 1;
//     widget.loadAreaController.animationController.stop();
//     setState(() {});
//   }
//
//   void _toFail() {
//     if (_stataus == 2 || _stataus == -1) {
//       return;
//     }
//     _stataus = 2;
//     widget.loadAreaController.animationController.stop();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     switch (_stataus) {
//       case 0:
//         return Container(
//           alignment: Alignment.center,
//           child: Container(
//             color: Colors.blue,
//             width: widget.loadAreaController.animation.value,
//           ),
//         );
//       case 1:
//         return Container(
//           alignment: Alignment.center,
//           child: const Text('no more'),
//         );
//       case 2:
//         return Container(
//           alignment: Alignment.center,
//           child: const Text('fail', style: TextStyle(color: Colors.red)),
//         );
//       default:
//         return Container(
//           alignment: Alignment.center,
//           child: const Text('发生了异常'),
//         );
//     }
//   }
// }
