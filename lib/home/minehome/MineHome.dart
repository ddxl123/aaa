import 'package:aaa/home/minehome/MineHomeAbController.dart';
import 'package:aaa/home/test/TestHome.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';

import '../../push_page/push_page.dart';

class MineHome extends StatelessWidget {
  const MineHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MineHomeAbController>(
      putController: MineHomeAbController(),
      builder: (c, abw) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              UnconstrainedBox(
                child: IconButton(
                  icon: const Icon(Icons.settings_sharp),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TestHome()));
                  },
                ),
              ),
            ],
          ),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              _userInfo(),
              _task(context: context),
              _creator(context: context),
              _other(),
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
            ],
          ),
        );
      },
    );
  }

  Widget _userInfo() {
    return SliverToBoxAdapter(
      child: AbBuilder<MineHomeAbController>(
        builder: (c, abw) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    icon: const Icon(Icons.ac_unit, size: 80, color: Colors.tealAccent),
                    style: ButtonStyle(
                      visualDensity: kMinVisualDensity,
                      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      // side: const MaterialStatePropertyAll(BorderSide(color: Colors.grey)),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                AbwBuilder(
                  builder: (abw) {
                    if (c.globalAbController.loggedInUser(abw) == null) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: GestureDetector(
                          child: Text('点击登录', style: Theme.of(c.context).textTheme.headlineSmall),
                          onTap: () {
                            pushToLoginPage(context: c.context);
                          },
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.globalAbController.loggedInUser(abw)!.username, style: Theme.of(c.context).textTheme.headlineSmall),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text("关注 ", style: const TextStyle(color: Colors.grey)),
                            Text(c.follow(abw) > 9999 ? "9999+" : c.follow(abw).toString()),
                            Text("  |  ", style: TextStyle(color: Colors.grey)),
                            Text("被关注 ", style: const TextStyle(color: Colors.grey)),
                            Text(c.beFollowed(abw) > 9999 ? "9999+" : c.follow(abw).toString()),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                GestureDetector(
                  child: const Text('个人主页 >', style: TextStyle(color: Colors.grey)),
                  onTap: () {
                    pushToPersonalHomePage(context: c.context, userId: c.globalAbController.loggedInUser()!.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _card({required Widget child, EdgeInsetsGeometry? cardPadding}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Card(
          child: Padding(
            padding: cardPadding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _cardWithTitle({
    required BuildContext context,
    required List<Widget> children,
    required String title,
  }) {
    final c = Aber.find<MineHomeAbController>();
    return AbwBuilder(
      builder: (abw) {
        return _card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleSmall),
                  const Icon(Icons.arrow_right),
                ],
              ),
              const SizedBox(height: 10),
              ...c.globalAbController.loggedInUser(abw) == null
                  ? [
                      GestureDetector(
                        child: Text('点击登录', style: Theme.of(c.context).textTheme.headlineSmall),
                        onTap: () {
                          pushToLoginPage(context: c.context);
                        },
                      )
                    ]
                  : children,
            ],
          ),
        );
      },
    );
  }

  Widget _lv({
    required BuildContext context,
    required String text,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text('Lv6', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontStyle: FontStyle.italic, color: Colors.blue)),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 50, 0),
                height: 5,
                decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(50)),
                child: Transform.scale(
                  alignment: Alignment.centerLeft,
                  scaleX: 0.45545645,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(text, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 14)),
            Text(' 25564/60000', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.blue, fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _task({required BuildContext context}) {
    return _cardWithTitle(
      context: context,
      title: '学习中心',
      children: [
        _lv(context: context, text: '学习点数'),
        const Divider(height: 40),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey)),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: const [
                  Text('今日'),
                  Text('任务'),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('记忆 200 个新碎片', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('进度 ', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey)),
                    Text('100 / 200', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.blue)),
                  ],
                )
              ],
            ),
            const Spacer(),
            TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                visualDensity: VisualDensity.compact,
              ),
              child: const Text('  去完成  '),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _creator({required BuildContext context}) {
    return _cardWithTitle(
      context: context,
      title: '创作中心',
      children: [
        _lv(context: context, text: '创作点数'),
        const Divider(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: const [
                Text('共享碎片数'),
                SizedBox(height: 10),
                Text('3456', style: TextStyle(color: Colors.blue)),
              ],
            ),
            Column(
              children: const [
                Text('碎片被学习次数'),
                SizedBox(height: 10),
                Text('468w', style: TextStyle(color: Colors.blue)),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _otherButton({required String text, required IconData iconData}) {
    return MaterialButton(
      visualDensity: kMinVisualDensity,
      child: Column(
        children: [
          const SizedBox(height: 10),
          FaIcon(iconData, color: Colors.black45),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 10),
        ],
      ),
      onPressed: () {},
    );
  }

  Widget _other() {
    return _card(
      cardPadding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _otherButton(text: '主题', iconData: FontAwesomeIcons.cloudMoon),
              _otherButton(text: '提醒', iconData: FontAwesomeIcons.bell),
              _otherButton(text: '个性化推荐', iconData: FontAwesomeIcons.streetView),
              _otherButton(text: 'TTS引擎', iconData: FontAwesomeIcons.headphones),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _otherButton(text: '使用手册', iconData: FontAwesomeIcons.book),
              _otherButton(text: '应用好评', iconData: FontAwesomeIcons.star),
              _otherButton(text: '客服/建议', iconData: FontAwesomeIcons.headset),
              _otherButton(text: '关于', iconData: FontAwesomeIcons.gg),
            ],
          ),
        ],
      ),
    );
  }
}
