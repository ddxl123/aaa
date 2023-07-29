import 'package:flutter/material.dart';

class SingleEmptyFragmentTemplateChunk extends StatelessWidget {
  const SingleEmptyFragmentTemplateChunk({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [Expanded(child: Container())],
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
