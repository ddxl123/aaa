part of aber;

class AbwBuilder extends StatefulWidget {
  const AbwBuilder({Key? key, required this.builder}) : super(key: key);
  final Widget Function(Abw abw) builder;

  @override
  State<AbwBuilder> createState() => _AbwBuilderState();
}

class _AbwBuilderState extends State<AbwBuilder> {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<_AbwAbController>(
      putController: _AbwAbController(),
      tag: hashCode.toString(),
      builder: (c, abw) {
        return widget.builder(abw);
      },
    );
  }
}

class _AbwAbController extends AbController {}
