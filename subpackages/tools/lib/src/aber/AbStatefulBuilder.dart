part of aber;

class AbStatefulBuilder extends StatefulWidget {
  const AbStatefulBuilder({
    Key? key,
    this.initExtra,
    this.onInit,
    this.onReady,
    required this.builder,
    this.onDispose,
  }) : super(key: key);

  final Map<String, Object?>? initExtra;

  final void Function(Map<String, Object?> extra, BuildContext context, void Function() refresh)? onInit;
  final void Function(Map<String, Object?> extra, BuildContext context, void Function() refresh)? onReady;
  final Widget Function(Map<String, Object?> extra, BuildContext context, void Function() refresh) builder;
  final void Function(Map<String, Object?> extra, BuildContext context, void Function() refresh)? onDispose;

  @override
  State<AbStatefulBuilder> createState() => _AbStatefulBuilderState();
}

class _AbStatefulBuilderState extends State<AbStatefulBuilder> {
  final Map<String, Object?> extra = {};

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    extra.addAll(widget.initExtra ?? {});
    widget.onInit?.call(extra, context, refresh);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onReady?.call(extra, context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(extra, context, refresh);
  }

  @override
  void dispose() {
    widget.onDispose?.call(extra, context, refresh);
    super.dispose();
  }
}
