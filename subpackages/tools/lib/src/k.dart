import 'dart:ui';

import 'package:flutter/widgets.dart';

final globalDialogFixedWidth = MediaQueryData.fromWindow(window).size.width * 0.8;
final globalDialogFixedHeight = MediaQueryData.fromWindow(window).size.height * 0.8;

/// 用户头像图片正方形边长
const globalUserAvatarSquareSide = 80.0;

/// 碎片组封面图片尺寸长宽比值
const globalFragmentGroupCoverRatio = Size(1.0, 1.4);
