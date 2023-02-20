import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:tools/tools.dart';

class DataDownload {
  static Future<void> downloadForFragmentGroup({
    required FragmentGroup downloadRootFragmentGroup,
    required FragmentGroup? saveFragmentGroup,
  }) async {
    final result = await request<DataDownloadForFragmentGroupDto, DataDownloadForFragmentGroupVo>(
      path: HttpPath.LOGIN_REQUIRED_DATA_DOWNLOAD_FOR_FRAGMENT_GROUP,
      dtoData: DataDownloadForFragmentGroupDto(
        fragment_group_id: downloadRootFragmentGroup.id,
        dto_padding_1: null,
      ),
      parseResponseVoData: DataDownloadForFragmentGroupVo.fromJson,
      onReceiveProgress: (count, total) {
        logger.outNormal(print: "count-$count, total-$total");
      },
    );
    await result.handleCode(
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outError(show: httperException.showMessage, print: httperException.debugMessage, stackTrace: st);
      },
      code40101: (String showMessage, DataDownloadForFragmentGroupVo vo) async {
        logger.outNormal(print: showMessage);

        // 存储至本地。
        await db.rawDAO.rawInsertDownloadForFragmentGroup(
          user: Aber.find<GlobalAbController>().loggedInUser()!,
          saveFragmentGroup: saveFragmentGroup,
          dataDownloadForFragmentGroupVo: vo,
        );

      },
    );
  }
}
