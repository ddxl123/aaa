import 'package:aaa/page/login_register/LoginPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';

class LoginVerifyPage extends StatelessWidget {
  const LoginVerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Aber.find<LoginPageAbController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('输入验证码', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            AbwBuilder(
              builder: (abw) {
                late final String text;
                if (c.loginWrapper(abw).isPhone(abw)) {
                  text = "短信";
                } else if (c.loginWrapper(abw).isEmail(abw)) {
                  text = "邮箱";
                } else {
                  throw "未处理类型: ${c.loginWrapper().loginType}";
                }
                return Text('$text已发送至 ${c.loginWrapper(abw).getEditContent()}', style: const TextStyle(color: Colors.grey));
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: c.verifyCodeTextEditingController,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(hintText: '验证码'),
            ),
            const SizedBox(height: 20),
            AbwBuilder(
              builder: (abw) {
                if (c.verifyCountdown(abw) == 0) {
                  return TextButton(
                    style: const ButtonStyle(
                      visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('重新发送验证码'),
                    onPressed: () {
                      c.reSend();
                    },
                  );
                } else {
                  return Text('${c.verifyCountdown(abw)}s 后可重新获取');
                }
              },
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                      padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(0, 15, 0, 15)),
                    ),
                    child: AbwBuilder(
                      builder: (abw) {
                        return c.isVerifying(abw) ? const SpinKitThreeBounce(color: Colors.white, size: 22) : const Text('登录/注册');
                      },
                    ),
                    onPressed: () {
                      c.verify();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
