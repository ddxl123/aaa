import 'package:flutter/material.dart';

import '../tools.dart';

class CustomAbWrongCard extends StatelessWidget {
  const CustomAbWrongCard({Key? key, required this.child, this.abWrong}) : super(key: key);
  final Widget child;
  final Ab<String?>? abWrong;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: AbwBuilder(
          builder: (abw) {
            return abWrong == null || abWrong!(abw) == null
                ? child
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      child,
                      AbwBuilder(
                        builder: (abw) {
                          return Text(abWrong!(abw)!, style: const TextStyle(color: Colors.red));
                        },
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
