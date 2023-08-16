import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tools/tools.dart';

class PersonalHomePageAbController extends AbController {
  PersonalHomePageAbController({required this.userId});

  final int userId;

  final userName = Ab<String?>(null);

  final userAvatar = Ab<String?>(null);

  /// 关注
  final follow = 0.ab;

  /// 被关注
  final beFollowed = 0.ab;

  /// 碎片创建量
  final createCount = 0.ab;

  /// 碎片收集量
  final collectionCount = 0.ab;

  late final TabController tabController;

  final fragmentsAb = <Fragment>[].ab;

  final fragmentGroupsAb = <FragmentGroup>[].ab;

  final publishFragmentGroupAb = <FragmentGroup>[].ab;

  /// 是否已关注
  final isFollowed = false.ab;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: Navigator.of(context));
    queryFirstPage();
    queryPublishPage();
  }

  /// 是否是当前登录用户
  bool get isSelf => userId == Aber.find<GlobalAbController>().loggedInUser()?.id;

  Future<void> queryFirstPage() async {
    final result = await request(
      path: HttpPath.NO_LOGIN_REQUIRED_PERSONAL_HOME_PAGE_FRAGMENT_PAGE,
      dtoData: PersonalHomePageForFragmentPageDto(
        user_id: userId,
        dto_padding_1: null,
      ),
      parseResponseVoData: PersonalHomePageForFragmentPageVo.fromJson,
    );
    await result.handleCode(
      code70101: (String showMessage, PersonalHomePageForFragmentPageVo vo) async {
        fragmentGroupsAb.refreshInevitable((obj) => obj
          ..clear()
          ..addAll(vo.fragment_groups_list));
        fragmentsAb.refreshInevitable((obj) => obj
          ..clear()
          ..addAll(vo.fragments_list));
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
      },
    );
  }

  Future<void> queryPublishPage() async {
    final result = await request(
      path: HttpPath.NO_LOGIN_REQUIRED_PERSONAL_HOME_PAGE_PUBLISH_PAGE,
      dtoData: PersonalHomePageForPublishPageDto(
        user_id: userId,
        dto_padding_1: null,
      ),
      parseResponseVoData: PersonalHomePageForPublishPageVo.fromJson,
    );
    await result.handleCode(
      code70201: (String showMessage, PersonalHomePageForPublishPageVo vo) async {
        publishFragmentGroupAb.refreshInevitable((obj) => obj
          ..clear()
          ..addAll(vo.fragment_groups_list));
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
      },
    );
  }

  /// 头像
  Future<void> showAvatar() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      print("=======");
      print(result.path);
      userAvatar.refreshEasy((oldValue) => result.path);
    }
  }
}
