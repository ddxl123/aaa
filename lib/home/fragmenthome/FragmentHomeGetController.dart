import 'dart:async';

import 'package:aaa/drift/DriftDb.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FragmentHomeGetController extends GetxController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  final RxList<FragmentGroup> fragmentGroup = <FragmentGroup>[].obs;
  final RxList<Rx<Fragment>> fragments = <Rx<Fragment>>[].obs;
  final Rx<int> i = 1.obs;

  @override
  void onClose() {
    fragments.first.value;
    refreshController.dispose();
    super.onClose();
  }
}

extension A on Object? {
  G find<G extends GetxController>() {
    return Get.find<G>();
  }
}
