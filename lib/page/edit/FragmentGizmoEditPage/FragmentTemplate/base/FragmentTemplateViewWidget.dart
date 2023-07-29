import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'FragmentTemplate.dart';

class FragmentTemplateViewWidget extends StatefulWidget {
  const FragmentTemplateViewWidget({
    super.key,
    required this.fragmentTemplate,
    required this.frontChildren,
    required this.backChildren,
    this.frontDialChildren,
    this.backDialChildren,
  });

  final FragmentTemplate fragmentTemplate;

  final List<Widget> frontChildren;

  final List<Widget> backChildren;
  final List<SpeedDialChild>? frontDialChildren;

  final List<SpeedDialChild>? backDialChildren;

  @override
  State<FragmentTemplateViewWidget> createState() => _FragmentTemplateViewWidgetState();
}

class _FragmentTemplateViewWidgetState extends State<FragmentTemplateViewWidget> {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      alignment: Alignment.topLeft,
      speed: 350,
      front: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                child: Column(
                  children: widget.frontChildren,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: widget.frontDialChildren == null
            ? null
            : SpeedDial(
                icon: Icons.more_horiz,
                activeIcon: Icons.close_outlined,
                overlayOpacity: 0.2,
                overlayColor: Colors.black,
                children: widget.frontDialChildren!,
              ),
      ),
      back: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                child: Column(
                  children: widget.backChildren,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: widget.backDialChildren == null
            ? null
            : SpeedDial(
                icon: Icons.more_horiz,
                activeIcon: Icons.close_outlined,
                overlayOpacity: 0.2,
                overlayColor: Colors.black,
                children: widget.backDialChildren!,
              ),
      ),
    );
  }
}
