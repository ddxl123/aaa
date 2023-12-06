import 'package:aaa/page/login_register/LoginPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<LoginPageAbController>(
      putController: LoginPageAbController(),
      builder: (c, abw) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('游客模式', style: TextStyle(color: Colors.grey, fontSize: 16)),
            leading: IconButton(
              icon: const FaIcon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                Navigator.pop(c.context);
              },
            ),
            actions: [
              TextButton(
                child: const Text('帮助'),
                onPressed: () {},
              ),
            ],
          ),
          body: Builder(
            builder: (b) {
              return _body(context: b);
            },
          ),
        );
      },
    );
  }

  Widget _body({required BuildContext context}) {
    return AbBuilder<LoginPageAbController>(
      builder: (c, abw) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AbwBuilder(
                builder: (abw) {
                  late final String text;
                  if (c.loginWrapper(abw).isPhone(abw)) {
                    text = "手机号登录";
                  } else if (c.loginWrapper(abw).isEmail(abw)) {
                    text = "邮箱登录";
                  } else {
                    throw "未处理类型: ${c.loginWrapper().loginType}";
                  }
                  return Text(text, style: Theme.of(context).textTheme.titleLarge);
                },
              ),
              const SizedBox(height: 10),
              AbwBuilder(
                builder: (abw) {
                  late final String text;
                  if (c.loginWrapper(abw).isPhone(abw)) {
                    text = "未注册的手机号会在验证后自动注册";
                  } else if (c.loginWrapper(abw).isEmail(abw)) {
                    text = "未注册的邮箱会在验证后自动注册";
                  } else {
                    throw "未处理类型: ${c.loginWrapper().loginType}";
                  }
                  return Text(text, style: const TextStyle(color: Colors.grey));
                },
              ),
              const SizedBox(height: 30),
              AbwBuilder(
                builder: (abw) {
                  final lw = c.loginWrapper(abw);
                  if (lw.isPhone(abw)) {
                    return TextField(
                      autofocus: true,
                      controller: lw.textEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: CustomDropdownBodyButton<int>(
                          initValue: (lw as PhoneLoginWrapper).currentNumberPre(abw),
                          items: lw.phones.map((e) => CustomItem(value: e, text: '+$e')).toList(),
                          onChanged: (v) {
                            lw.currentNumberPre.refreshEasy((oldValue) => v!);
                          },
                        ),
                        hintText: '手机号',
                      ),
                    );
                  } else {
                    return TextField(
                      autofocus: true,
                      controller: lw.textEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(prefixIcon: Icon(Icons.email_outlined), hintText: '邮箱'),
                    );
                  }
                },
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  AbwBuilder(
                    builder: (abw) {
                      return Checkbox(
                        visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                        value: c.isAgree(abw),
                        onChanged: (v) {
                          c.isAgree.refreshEasy((oldValue) => !oldValue);
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text('我已阅读并同意', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  TextButton(
                    style: const ButtonStyle(
                      visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('《XXX协议》', style: TextStyle(fontSize: 12)),
                    onPressed: () {},
                  ),
                  TextButton(
                    style: const ButtonStyle(
                      visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('《个人信息保护指引》', style: TextStyle(fontSize: 12)),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AbwBuilder(
                builder: (abw) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                            padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(0, 15, 0, 15)),
                          ),
                          child: c.isSending(abw) ? const SpinKitThreeBounce(color: Colors.white, size: 22) : const Text('发送验证码'),
                          onPressed: () {
                            c.send();
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
              AbwBuilder(
                builder: (abw) {
                  if (c.loginWrapper(abw).isPhone(abw)) {
                    return Center(
                      child: MaterialButton(
                        child: const Text('邮箱登录', style: TextStyle(color: Colors.grey)),
                        onPressed: () {
                          c.loginWrapper.refreshEasy((oldValue) => EmailLoginWrapper());
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    );
                  } else if (c.loginWrapper(abw).isEmail(abw)) {
                    return MaterialButton(
                      child: const Text('手机号登录', style: TextStyle(color: Colors.grey)),
                      onPressed: () {
                        c.loginWrapper.refreshEasy((oldValue) => PhoneLoginWrapper());
                        FocusScope.of(context).unfocus();
                      },
                    );
                  } else {
                    throw "未处理类型: ${c.loginWrapper(abw).loginType}";
                  }
                },
              ),
              const SizedBox(height: 50),
              const Center(child: Text('其他登录方式', style: TextStyle(color: Colors.grey))),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                    icon: const FaIcon(FontAwesomeIcons.weixin, color: Colors.white, size: 18),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.lightBlueAccent)),
                    icon: const FaIcon(FontAwesomeIcons.qq, color: Colors.white, size: 18),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.orange)),
                    icon: const FaIcon(FontAwesomeIcons.weibo, color: Colors.white, size: 18),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
