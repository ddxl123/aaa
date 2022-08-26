import 'package:flutter/material.dart';

class CardCustom extends StatefulWidget {
  const CardCustom({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<CardCustom> createState() => _CardCustomState();
}

class _CardCustomState extends State<CardCustom> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: widget.child,
      ),
    );
  }
}
