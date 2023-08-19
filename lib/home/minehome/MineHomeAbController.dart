import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/http_file_enum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class MineHomeAbController extends AbController {
  final globalAbController = Aber.find<GlobalAbController>();

  final refreshController = RefreshController(initialRefresh: true);

  /// 关注
  final follow = 0.ab;

  /// 被关注
  final beFollowed = 0.ab;

  @override
  void onInit() {
    super.onInit();
    refreshMineHome();
  }

  Future<void> refreshMineHome() async {
    await getUserAvatar();
    refreshController.refreshCompleted();
  }

  Future<void> getUserAvatar() async {
    await requestFile(
      httpFileEnum: HttpFileEnum.userAvatar,
      filePathWrapper: FilePathWrapper(
        fileUint8List: null,
        oldCloudPath: globalAbController.loggedInUser()?.avatar_cloud_path,
      ),
      fileRequestMethod: FileRequestMethod.forceCloud,
      isUpdateCache: false,
      onSuccess: (FilePathWrapper filePathWrapper) async {
        globalAbController.loggedInUser.refreshInevitable((obj) => obj?..avatar_cloud_path = filePathWrapper.newCloudPath);
      },
      onError: (FilePathWrapper filePathWrapper, e, StackTrace st) async {
        logger.outError(print: "图片获取异常", error: e, stackTrace: st);
      },
    );
  }
}
