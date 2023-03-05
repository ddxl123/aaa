library freebox;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'FreeBoxController.dart';

part 'FreeBoxWidget.dart';

/// 左上角的偏移量。
///
/// 该偏移量使得整个盒子的位置(以盒子左上角为原点)被移动到 -[freeBoxTopLeftOffset] 位置，
/// 以防止左上方越界，导致越界的widget不显示。
const Offset freeBoxTopLeftOffset = Offset(10000, 10000);

class FreeBox extends StatefulWidget {
  FreeBox({
    required this.freeBoxController,
    required this.moveScaleLayerWidgets,
    required this.fixedLayerWidgets,
    Key? key,
  }) : super(key: key);

  final FreeBoxController freeBoxController;

  /// 移动缩放层。
  final FreeBoxMoveScaleLayerStack moveScaleLayerWidgets;

  /// 移动缩放层上方的固定层。
  final List<FreeBoxFixedLayerPositioned> fixedLayerWidgets;

  @override
  State<StatefulWidget> createState() {
    return _FreeBox();
  }
}

class _FreeBox extends State<FreeBox> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.freeBoxController.animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(top: 0, left: 0, child: _freeMoveScaleLayer()),
        Stack(children: _fixedLayer()),
      ],
    );
  }

  /// 移动缩放层
  Widget _freeMoveScaleLayer() => GestureDetector(
        // 让不包含 widget 的地方也能被触发移动缩放事件。
        behavior: HitTestBehavior.translucent,
        onScaleStart: (ScaleStartDetails details) {
          widget.freeBoxController.freeBoxSetState = () {
            if (mounted) setState(() {});
          };
          widget.freeBoxController.onScaleStart(details);
        },
        onScaleUpdate: widget.freeBoxController.onScaleUpdate,
        onScaleEnd: widget.freeBoxController.onScaleEnd,
        child: StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Transform.translate(
              offset: widget.freeBoxController.freeBoxCamera.getActualPosition(),
              child: Transform.scale(
                // 以左上角为中心进行缩放
                alignment: Alignment.topLeft,
                scale: widget.freeBoxController.freeBoxCamera.expectScale,
                child: SizedBox(
                  // 盒子的大小必须比上一层容器要大，否则超出盒子范围外的widget无法被显示，这里无限大即可。
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: widget.moveScaleLayerWidgets,
                ),
              ),
            );
          },
        ),
      );

  /// 移动缩放层上方的固定层
  List<FreeBoxFixedLayerPositioned> _fixedLayer() => widget.fixedLayerWidgets;
}
