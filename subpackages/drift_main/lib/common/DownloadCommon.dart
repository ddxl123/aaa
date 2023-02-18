import 'package:drift_main/drift/DriftDb.dart';

class DownloadCommon {
  DownloadCommon._();

  static Future<void> downloadForFragmentGroup({required FragmentGroup fragmentGroup}) async {
    await withRefs(
      syncTag: null,
      ref: (SyncTag syncTag) async {
        return RefFragmentGroups(
          self: ($FragmentGroupsTable table) async {

          },
          rFragment2FragmentGroups: null,
          child_fragmentGroups: null,
          userComments: null,
          userLikes: null,
        );
      },
    );
  }
}
