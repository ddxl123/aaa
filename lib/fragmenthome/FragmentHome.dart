import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FragmentHome extends StatefulWidget {
  const FragmentHome({Key? key}) : super(key: key);

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> with AutomaticKeepAliveClientMixin {
  final List<String> _list = ['aaa', 'bbb', 'ccc', 'ddd'];
  final RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showAboutDialog(context: context);

              // List<Widget> columnChildren;
              // if (scrollable) {
              //   columnChildren = <Widget>[
              //     if (title != null || content != null)
              //       Flexible(
              //         child: SingleChildScrollView(
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             crossAxisAlignment: CrossAxisAlignment.stretch,
              //             children: <Widget>[
              //               if (title != null) titleWidget!,
              //               if (content != null) contentWidget!,
              //             ],
              //           ),
              //         ),
              //       ),
              //     if (actions != null)
              //       actionsWidget!,
              //   ];
              // } else {
              //   columnChildren = <Widget>[
              //     if (title != null) titleWidget!,
              //     if (content != null) Flexible(child: contentWidget!),
              //     if (actions != null) actionsWidget!,
              //   ];
              // }
              //
              // Widget dialogChild = IntrinsicWidth(
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: columnChildren,
              //   ),
              // );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    alignment: Alignment.center,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black26)],
                          color: Colors.white,
                        ),
                        child: IntrinsicWidth(
                          child: IntrinsicHeight(
                            //①
                            child: Column(
                              children: [
                                // 可防止 SingleChildScrollView 高度过大而使 Column① 溢出.
                                Flexible(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: const [
                                        Text('标题', style: TextStyle(fontSize: 24)),
                                        SizedBox(height: 10),
                                        Text('消息大苏打实打实大苏打实打实大苏打'),
                                      ],
                                      // stretch 要求子元素充满横轴(即 Text 充满横轴),可在 Text 内部设置 TextAlign
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(child: TextButton(onPressed: () {}, child: Text('daddddddddddddddta'))),
                                    Flexible(
                                        child: TextButton(onPressed: () {}, child: Text('datdddddddddddddddddddda'))),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Text(_list[index]),
            );
          },
        ),
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          _refreshController.refreshCompleted();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
