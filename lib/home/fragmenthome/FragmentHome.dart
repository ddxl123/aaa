import 'package:aaa/home/fragmenthome/FragmentHomeAbController.dart';
import 'package:aaa/page/create/CreateFragmentGroupPage.dart';
import 'package:aaa/page/create/CreateFragmentPage.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/FragmentGroupPage.dart';
import 'package:aaa/widget_model/FragmentGroupPageAbController.dart';
import 'package:aaa/widget_model/MemoryModelPage.dart';
import 'package:aaa/widget_model/MemoryModelPageAbController.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class FragmentHome extends StatefulWidget {
  const FragmentHome({Key? key}) : super(key: key);

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentHomeAbController>(
      putController: FragmentHomeAbController(),
      builder: (putController, putAbw) {
        return Scaffold(
          appBar: PreferredSize(
            child: Row(
              children: [
                const Expanded(child: Text('data')),
                Expanded(
                  flex: 2,
                  child: TabBar(
                    controller: putController.tabController,
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('碎片', style: TextStyle(color: Colors.blue)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('规则', style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('草稿'),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<int>(
                          dropdownWidth: 150,
                          dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                          customButton: const Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                ),
              ],
            ),
            preferredSize: const Size.fromHeight(kMinInteractiveDimension),
          ),
          body: TabBarView(
            controller: putController.tabController,
            children: const [
              FragmentGroupPage(pageType: FragmentGroupPageType.home),
              MemoryModelPage(pageType: MemoryModelPageType.home),
            ],
          ),
        );
      },
    );
  }
}
