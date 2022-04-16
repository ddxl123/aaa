// import 'package:flutter/material.dart';
//
// abstract class ShowXRoute<T> extends OverlayRoute<T> {
//   /// Widget 为 [Positioned] 或 [AutoPositioned]
//   List<Widget> body();
//
//   /// 背景不透明度
//   double get backgroundOpacity => 0;
//
//   /// 背景颜色
//   Color get backgroundColor => Colors.transparent;
//
//   @override
//   Iterable<OverlayEntry> createOverlayEntries() {
//     return <OverlayEntry>[
//       OverlayEntry(
//         builder: (_) {
//           return ShowXRouteWidget(showXRoute: this);
//         },
//       ),
//     ];
//   }
// }
//
// class ShowXRouteWidget extends StatefulWidget {
//   const ShowXRouteWidget({Key? key, required this.showXRoute}) : super(key: key);
//
//   final ShowXRoute showXRoute;
//
//   @override
//   _ShowXRouteWidgetState createState() => _ShowXRouteWidgetState();
// }
//
// class _ShowXRouteWidgetState extends State<ShowXRouteWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: <Widget>[
//           background(),
//           ...widget.showXRoute.body(),
//         ],
//       ),
//     );
//   }
//
//   Widget background() {
//     return Positioned(
//       top: 0,
//       child: Listener(
//         onPointerUp: (_) {
//           widget.showXRoute.didPop(null);
//         },
//         child: Opacity(
//           opacity: widget.showXRoute.backgroundOpacity,
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             color: widget.showXRoute.backgroundColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
