import 'dart:convert';

import 'package:aaa/page/list/ShorthandListPageAbController.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;

class ShorthandListPage extends StatelessWidget {
  const ShorthandListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<ShorthandListPageAbController>(
      putController: ShorthandListPageAbController(),
      builder: (c, abw) {
        return Scaffold(
          body: SmartRefresher(
            controller: c.refreshController,
            onRefresh: () async {
              await c.refreshPage();
              c.refreshController.refreshCompleted();
            },
            header: ClassicHeader(),
            child: MasonryGridView.count(
              padding: EdgeInsets.only(top: 20, bottom: 100),
              crossAxisCount: 2,
              itemCount: c.shorthandsAb(abw).length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    pushToShorthandGizmoEditPage(context: context, initShorthand: c.shorthandsAb()[index]);
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            q.Document.fromJson(jsonDecode(c.shorthandsAb(abw)[index].content)).toPlainText(),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  () {
                                    final time = c.shorthandsAb(abw)[index].updated_at;
                                    final spt = time.toString().split(" ");
                                    if (DateTime.now().difference(time).inHours >= 24) {
                                      return spt.first.replaceAll("-", ".");
                                    } else {
                                      return spt.last.split(".").first;
                                    }
                                  }(),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingRoundCornerButton(
            text: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FontAwesomeIcons.feather, size: 18),
                SizedBox(width: 10),
                Text("新增速记"),
              ],
            ),
            onPressed: () {
              pushToShorthandGizmoEditPage(context: context, initShorthand: null);
            },
          ),
        );
      },
    );
  }
}
