part of aber;

class BuildExceptionWidget extends StatelessWidget {
  const BuildExceptionWidget({
    Key? key,
    required this.title,
    required this.exceptionContent,
    required this.logCallback,
  }) : super(key: key);

  final String title;
  final AbException exceptionContent;
  final void Function(String title, AbException exceptionContent) logCallback;

  @override
  Widget build(BuildContext context) {
    logCallback(title, exceptionContent);
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Expanded(child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center))],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Expanded(child: Text('内部构建异常！'))],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Expanded(child: Text(exceptionContent.toString()))],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
