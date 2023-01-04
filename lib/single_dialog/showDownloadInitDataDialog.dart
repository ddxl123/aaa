import 'package:tools/tools.dart';

Future<void> showDownloadInitDataDialog() async {
  await showCustomDialog(
    builder: (_) => DialogWidget(
      mainVerticalWidgets: [],
      bottomHorizontalButtonWidgets: [],
    ),
  );
}
