import 'package:flutter/material.dart';

/// 需要配套使用 [FloatingRoundCornerButtonLocation]
///
/// 若需要占位框，则可以使用 [floatingRoundCornerButtonPlaceholderBox]。
class FloatingRoundCornerButton extends StatelessWidget {
  const FloatingRoundCornerButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.border,
  }) : super(key: key);

  final Widget text;
  final void Function() onPressed;
  final OutlinedBorder? border;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
        elevation: MaterialStateProperty.all(5),
        shape: MaterialStateProperty.all(border),
      ),
      child: text,
      onPressed: () {
        onPressed();
      },
    );
  }
}

class FloatingRoundCornerButtonLocation extends FloatingActionButtonLocation {
  FloatingRoundCornerButtonLocation({
    required this.context,
    this.offset = Offset.zero,
  });

  final BuildContext context;
  final Offset offset;

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final centerDockedOffset = FloatingActionButtonLocation.centerDocked.getOffset(scaffoldGeometry);
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    if (bottom > 0) return centerDockedOffset;
    return centerDockedOffset + offset;
  }
}

Widget floatingRoundCornerButtonPlaceholderBox([double height = 100]) => SizedBox(height: height);
