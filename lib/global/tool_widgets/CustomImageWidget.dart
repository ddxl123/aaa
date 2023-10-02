import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';

/// 先加载本地，如果本地加载失败，则获取云端，若云端获取失败，则 errorWidget
///
/// [cloudPath] 需要相对路径。会自动转换成 [FilePathWrapper.toAvailablePath]
///
/// [localPath] 需要绝对路径。
class LocalThenCloudImageWidget extends StatelessWidget {
  const LocalThenCloudImageWidget({
    super.key,
    required this.size,
    required this.localPath,
    required this.cloudPath,
  });

  final Size size;
  final String? localPath;
  final String? cloudPath;
  final String unknown = "unknown";

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(localPath ?? unknown),
      width: size.width,
      height: size.height,
      errorBuilder: (ctx, e, st) {
        return CachedNetworkImage(
          width: size.width,
          height: size.height,
          imageUrl: FilePathWrapper.toAvailablePath(cloudPath: cloudPath) ?? unknown,
          placeholder: (ctx, url) {
            return Container(
              width: size.width,
              height: size.height,
              color: Colors.black12,
              child: Center(child: Text("无图片")),
            );
          },
          errorWidget: (ctx, url, e) {
            if (url == unknown) {
              return Container(
                width: size.width,
                height: size.height,
                color: Colors.black12,
                child: Center(child: Text("无图片")),
              );
            } else {
              return Container(
                width: size.width,
                height: size.height,
                color: Colors.black12,
                child: Center(child: Text("加载异常！")),
              );
            }
          },
        );
      },
    );
  }
}

/// 先获取云端，如果云端获取失败，则加载本地，若本地加载失败，则 errorWidget
///
/// [cloudPath] 需要相对路径。会自动转换成 [FilePathWrapper.toAvailablePath]
///
/// [localPath] 需要绝对路径。
class CloudThenLocalImageWidget extends StatelessWidget {
  const CloudThenLocalImageWidget({
    super.key,
    required this.size,
    required this.localPath,
    required this.cloudPath,
  });

  final Size size;
  final String? localPath;
  final String? cloudPath;
  final String unknown = "unknown";

  @override
  Widget build(BuildContext context) {
    print(cloudPath);
    return CachedNetworkImage(
      width: size.width,
      height: size.height,
      imageUrl: FilePathWrapper.toAvailablePath(cloudPath: cloudPath) ?? unknown,
      placeholder: (ctx, url) {
        return Container(
          width: size.width,
          height: size.height,
          color: Colors.black12,
          child: Center(child: Text("无图片")),
        );
      },
      errorWidget: (ctx, url, e) {
        return Image.file(
          File(localPath ?? unknown),
          width: size.width,
          height: size.height,
          errorBuilder: (ctx, e, st) {
            if (url == unknown) {
              return Container(
                width: size.width,
                height: size.height,
                color: Colors.black12,
                child: Center(child: Text("无图片")),
              );
            } else {
              return Container(
                width: size.width,
                height: size.height,
                color: Colors.black12,
                child: Center(child: Text("加载异常！")),
              );
            }
          },
        );
      },
    );
  }
}

/// 先加载本地，如果本地加载失败，则获取云端，若云端获取失败，则 errorWidget
///
/// [cloudPath] 会自动转换成 [FilePathWrapper.toAvailablePath]
class ForceCloudImageWidget extends StatelessWidget {
  const ForceCloudImageWidget({
    super.key,
    required this.size,
    required this.cloudPath,
  });

  final Size? size;
  final String? cloudPath;
  final String unknown = "https://img2.baidu.com/it/u=824807255,173743980&fm=253&fmt=auto&app=120&f=JPEG?w=200&h=200";

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: size?.width,
      height: size?.height,
      imageUrl: FilePathWrapper.toAvailablePath(cloudPath: cloudPath) ?? unknown,
      errorWidget: (ctx, url, e) {
        if (url == unknown) {
          return Container(
            width: size?.width,
            height: size?.height,
            color: Colors.black12,
            child: Center(child: Text("无图片")),
          );
        } else {
          return Container(
            width: size?.width,
            height: size?.height,
            color: Colors.black12,
            child: Center(child: Text("加载异常！")),
          );
        }
      },
    );
  }
}
