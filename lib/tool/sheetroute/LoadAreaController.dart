import 'package:flutter/material.dart';

enum LoadAreaStatus { loading, noMore, failure }

class LoadAreaController {
  late final Widget Function() loadingWidget;
  late final Widget Function() noMoreWidget;
  late final Widget Function() failureWidget;

  LoadAreaStatus loadAreaStatus = LoadAreaStatus.noMore;

  Widget currentStatusWidget() {
    switch (loadAreaStatus) {
      case LoadAreaStatus.loading:
        return loadingWidget();
      case LoadAreaStatus.noMore:
        return noMoreWidget();
      default:
        return failureWidget();
    }
  }
}
