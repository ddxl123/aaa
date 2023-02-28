import 'package:aaa/page/list/ShorthandListPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class ShorthandListPage extends StatelessWidget {
  const ShorthandListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<ShorthandListPageAbController>(
      putController: ShorthandListPageAbController(),
      builder: (c, abw) {
        return SmartRefresher(
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
              return Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        c.shorthandsAb(abw)[index](abw).content,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              c.shorthandsAb(abw)[index](abw).updated_at.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
