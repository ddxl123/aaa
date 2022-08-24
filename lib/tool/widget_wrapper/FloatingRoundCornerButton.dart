import 'package:flutter/material.dart';

/// 需要配套使用 [FloatingRoundCornerButtonLocation]
class FloatingRoundCornerButton extends StatelessWidget {
  const FloatingRoundCornerButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
        ),
        child: Text(text),
        onPressed: () {
          onPressed();
        },
      ),
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
