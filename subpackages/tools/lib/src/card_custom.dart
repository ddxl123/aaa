import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class CardCustom extends StatefulWidget {
  const CardCustom({Key? key, required this.child, required this.verifyAb}) : super(key: key);
  final Widget child;
  final Ab? verifyAb;

  @override
  State<CardCustom> createState() => _CardCustomState();
}

class _CardCustomState extends State<CardCustom> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.child,
            Row(
              children: [
                Expanded(
                  child: AbStatefulBuilder(
                    initExtra: const {'isHide': true},
                    builder: (e, c, r) {
                      widget.verifyAb?.verify.checkCallBacks.add(() {
                        e['isHide'] = widget.verifyAb?.verify.isOk ?? true;
                        r();
                      });
                      return e['isHide'] == false ? Text(widget.verifyAb!.verify.message, style: const TextStyle(color: Colors.red)) : Container();
                    },
                    onDispose: (e, c, r) {
                      widget.verifyAb?.verify.checkCallBacks.remove(r);
                      e.clear();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
