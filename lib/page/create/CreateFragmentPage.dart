import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:aaa/widget_model/Models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateFragmentPage extends StatelessWidget {
  const CreateFragmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(onPressed: () {}, child: const Text('存草稿')),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.tealAccent)),
                child: const Text('创建'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const FragmentGroupModelForAdd()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          // 屏幕高度-状态栏高度-appBar-padding
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - 20,
          child: Column(
            children: const [
              TextField(
                minLines: null,
                maxLines: null,
                autofocus: true,
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(border: InputBorder.none, hintText: '标题'),
              ),
              Expanded(
                child: TextField(
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  decoration: InputDecoration(border: InputBorder.none, hintText: '请输入内容'),
                ),
              ),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
