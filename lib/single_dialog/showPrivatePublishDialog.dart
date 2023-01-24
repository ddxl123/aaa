import 'package:aaa/page/edit/FragmentGizmoEditPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';

Future<void> showPrivatePublishDialog() async {
  final c = Aber.findOrNull<FragmentGizmoEditPageAbController>();
  if (c == null) {
    logger.outNormal(print: "没有发现 FragmentGizmoEditPageAbController，但却对其进行了 find。");
    return;
  }
  return await showCustomDialog(
    builder: (_) {
      return StatefulBuilder(
        builder: (_, refresh) {
          return AbwBuilder(
            builder: (abw) {
              return DialogWidget(
                mainVerticalWidgets: [
                  Row(
                    children: [
                      Text("是否私密", style: TextStyle(fontSize: 18)),
                      Spacer(),
                      Switch(
                        value: c.currentPerformer(abw).bePrivate,
                        onChanged: (v) {
                          c.currentPerformer().bePrivate = v;
                          c.currentPerformer.refreshForce();
                        },
                      ),
                    ],
                  ),
                  Text("私密：个人主页界面仅自己可见", style: TextStyle(color: Colors.grey)),
                  Text("公开：个人主页界面陌生人也可见", style: TextStyle(color: Colors.grey)),
                  Divider(),
                  Row(
                    children: [
                      Text("是否发布", style: TextStyle(fontSize: 18)),
                      Spacer(),
                      Switch(
                        value: c.currentPerformer(abw).bePublish,
                        onChanged: (v) {
                          c.currentPerformer().bePublish = v;
                          c.currentPerformer.refreshForce();
                        },
                      ),
                    ],
                  ),
                  Text("发布：会在首页中被推荐，也可被搜索到", style: TextStyle(color: Colors.grey)),
                  Text("不发布：不会在首页中被推荐，也无法被搜索到", style: TextStyle(color: Colors.grey)),
                  Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circleExclamation,
                        size: 20,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "私密和发布并不相互影响。\n例如，当设为私密，但同时设为发布时，个人主页陌生人不可见，但是将会被首页推荐或搜索到。\n如果想要完全私密，请将私密启用，并将发布关闭。",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
                bottomHorizontalButtonWidgets: [],
              );
            },
          );
        },
      );
    },
  );
}
