import 'package:aaa/global/tool_widgets/CustomImageWidget.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class FollowListPage extends StatefulWidget {
  const FollowListPage({
    super.key,
    required this.userId,
    required this.followOrBeFollowed,
  });

  final int userId;

  /// true - TA的关注
  /// false - 关注TA的
  final bool followOrBeFollowed;

  @override
  State<FollowListPage> createState() => _FollowListPageState();
}

class _FollowListPageState extends State<FollowListPage> {
  final list = <UserIdAndAvatarAndName>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  Future<void> _query() async {
    final result = await request(
      path: HttpPath.GET__NO_LOGIN_REQUIRED_PERSONAL_HOME_HANDLE_FOLLOW_AND_BE_FOLLOWED_LIST_QUERY,
      dtoData: FollowOrBeFollowedListQueryDto(
        user_id: widget.userId,
        follow_or_be_followed: widget.followOrBeFollowed,
      ),
      parseResponseVoData: FollowOrBeFollowedListQueryVo.fromJson,
    );
    await result.handleCode(
      code70601: (String showMessage, FollowOrBeFollowedListQueryVo vo) async {
        list.clear();
        list.addAll(vo.list_list);
        setState(() {});
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.followOrBeFollowed ? "TA的关注" : "关注TA的")),
      body: ListView.separated(
        padding: EdgeInsets.all(20),
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemBuilder: (ctx, index) {
          return GestureDetector(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: ForceCloudImageWidget(
                    size: Size(50, 50),
                    cloudPath: list[index].avatar_path,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(list[index].user_name),
                ),
              ],
            ),
            onTap: () {
              pushToPersonalHomePage(context: context, userId: list[index].user_id);
            },
          );
        },
        separatorBuilder: (ctx, index) {
          return Container(height: 20);
        },
        itemCount: list.length,
      ),
    );
  }
}
