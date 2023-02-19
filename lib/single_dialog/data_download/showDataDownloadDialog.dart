import 'package:aaa/single_dialog/data_download/DataDownloadAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

typedef ProgressHandler = Future<void> Function(DataDownloadAbController c);

Future<void> showDataDownloadDialog(ProgressHandler progressHandler) async {
  await showCustomDialog(
    builder: (_) => DataDownloadWidget(progressHandler: progressHandler),
    backDismiss: false,
    clickMaskDismiss: false,
  );
}

class DataDownloadWidget extends StatefulWidget {
  const DataDownloadWidget({Key? key, required this.progressHandler}) : super(key: key);
  final ProgressHandler progressHandler;

  @override
  State<DataDownloadWidget> createState() => _DataDownloadWidgetState();
}

class _DataDownloadWidgetState extends State<DataDownloadWidget> {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<DataDownloadAbController>(
      putController: DataDownloadAbController(progressHandler: widget.progressHandler),
      tag: Aber.single,
      builder: (c, abw) {
        return DialogWidget(
          mainVerticalWidgetsAlignment: CrossAxisAlignment.center,
          mainVerticalWidgets: [
            Stack(
              alignment: Alignment.center,
              children: [
                SpinKitCircle(color: Colors.greenAccent, size: 60),
                Text("${c.progress(abw)}%"),
              ],
            ),
            Text("下载中，请稍等"),
            MaterialButton(
              child: Text("取消", style: TextStyle(color: Colors.grey)),
              onPressed: () {
                SmartDialog.dismiss(status: SmartStatus.dialog);
              },
            ),
          ],
          bottomHorizontalButtonWidgets: [],
        );
      },
    );
  }
}
