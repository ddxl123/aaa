import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 存在其他地方已登录。
///
/// 返回当前是否继续执行登录操作。
///
/// TODO: 将刚登录的进行注销。
Future<bool> showExistOtherPlaceLoggedInDialog({
  required RegisterOrLoginVo vo,
}) async {
  bool isContinue = false;
  await showCustomDialog(
    backDismiss: false,
    clickMaskDismiss: false,
    builder: (_) => StatefulBuilder(
      builder: (_, reBuild) {
        return DialogWidget(
          title: "该用户已存在登录！",
          mainVerticalWidgets: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text("将登录用户：${vo.user_entity!.username}")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: Text("是否为会员用户：是")),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            ...vo.device_and_token_bo_list!.map(
              (e) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(DeviceInfoSingle.getDevice(deviceInfo: e.deviceInfo))),
                        TextButton(
                          child: const Text("下线", style: TextStyle(color: Colors.red)),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ],
          bottomKeepWidget: Row(
            children: [
              TextButton(
                style: const ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: Colors.pinkAccent))),
                child: const Text("继续登录(会员)", style: TextStyle(color: Colors.pinkAccent)),
                onPressed: () {},
              ),
              const SizedBox(width: 10),
              TextButton(
                style: const ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: Colors.grey))),
                child: const Text("注销全部并登录", style: TextStyle(color: Colors.red)),
                onPressed: () {},
              ),
            ],
          ),
          bottomHorizontalButtonWidgets: [
            TextButton(
              child: const Text("取消本次登录", style: TextStyle(color: Colors.grey)),
              onPressed: () async {
                await db.deleteDAO.clearDb();
                SmartDialog.dismiss();
              },
            ),
          ],
        );
      },
    ),
  );
  return isContinue;
}
