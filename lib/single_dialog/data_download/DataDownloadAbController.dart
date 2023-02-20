import 'package:aaa/single_dialog/data_download/showDataDownloadDialog.dart';
import 'package:tools/tools.dart';

class DataDownloadAbController extends AbController {
  DataDownloadAbController({required this.progressHandler});

  final ProgressHandler progressHandler;

  /// 范围 0-100
  var progress = 0.ab;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    try {
      await progressHandler(this);
    } catch (e, st) {
      logger.outError(show: "获取失败!", error: e, stackTrace: st);
    }
  }
}
