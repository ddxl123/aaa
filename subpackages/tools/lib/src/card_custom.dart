import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class CardCustom extends StatefulWidget {
  const CardCustom({Key? key, required this.child, this.verifyAb}) : super(key: key);
  final Widget child;
  final Ab? verifyAb;

  @override
  State<CardCustom> createState() => _CardCustomState();
}

class _CardCustomState extends State<CardCustom> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.child,
            if (widget.verifyAb != null) Row(children: [Expanded(child: VerifyErrorWidget(verify: widget.verifyAb!.verify))]),
          ],
        ),
      ),
    );
  }
}

class VerifyErrorWidget extends StatefulWidget {
  const VerifyErrorWidget({Key? key, required this.verify}) : super(key: key);
  final AbVerify verify;

  @override
  State<VerifyErrorWidget> createState() => _VerifyErrorWidgetState();
}

class _VerifyErrorWidgetState extends State<VerifyErrorWidget> {
  bool isHide = true;

  void refresh() {
    isHide = widget.verify.isOk;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.verify.checkCallBacks.add(refresh);
  }

  @override
  void dispose() {
    widget.verify.checkCallBacks.remove(refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isHide) return Container();
    return Text(widget.verify.message, style: const TextStyle(color: Colors.red));
  }
}

class HintWidget extends StatefulWidget {
  const HintWidget({Key? key, required this.hint}) : super(key: key);
  final Tuple2<FocusNode, String> hint;

  @override
  State<HintWidget> createState() => _HintWidgetState();
}

class _HintWidgetState extends State<HintWidget> {
  @override
  void initState() {
    super.initState();
    widget.hint.t1.addListener(focusListener);
  }

  @override
  void dispose() {
    widget.hint.t1.removeListener(focusListener);
    super.dispose();
  }

  void focusListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hint.t1.hasFocus) return Text(widget.hint.t2);
    return Container();
  }
}
