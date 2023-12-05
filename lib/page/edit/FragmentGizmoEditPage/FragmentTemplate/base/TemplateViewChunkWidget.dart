import 'package:flutter/material.dart';

/// 单个块 Widget
class TemplateViewChunkWidget extends StatelessWidget {
  const TemplateViewChunkWidget({
    super.key,
    required this.chunkTitle,
    required this.children,
  });

  final String chunkTitle;
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
                children: [
                  Text(chunkTitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 10),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
