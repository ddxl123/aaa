import 'package:aaa/home/fragmenthome/FragmentHomeAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/FragmentGroupModel.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:flutter/material.dart';

class FragmentHome extends StatefulWidget {
  const FragmentHome({Key? key}) : super(key: key);

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AbBuilder<FragmentHomeAbController>(
      putController: FragmentHomeAbController(),
      builder: (controller, abw) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(onPressed: () {}, child: const Text('草稿')),
            ],
          ),
          body: const FragmentGroupModel(modelType: FragmentGroupModelType.home),
        );
      },
    );
  }
}
