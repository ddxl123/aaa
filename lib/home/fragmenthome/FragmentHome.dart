import 'package:aaa/home/fragmenthome/FragmentHomeAbController.dart';
import 'package:aaa/page/create/CreateFragmentGroupPage.dart';
import 'package:aaa/page/create/CreateFragmentPage.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/FragmentGroupModel.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
              DropdownButtonHideUnderline(
                child: DropdownButton2<int>(
                  dropdownWidth: 150,
                  dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  customButton: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Icon(Icons.more_horiz),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('添加碎片'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('添加碎片组'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == 0) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => const CreateFragmentPage()));
                      return;
                    }
                    if (value == 1) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => const CreateFragmentGroupPage()));
                    }
                  },
                ),
              ),
            ],
          ),
          body: const FragmentGroupModel(modelType: FragmentGroupModelType.home),
        );
      },
    );
  }
}
