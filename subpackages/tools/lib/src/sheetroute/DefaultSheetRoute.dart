import 'package:flutter/material.dart';
import 'package:tools/src/sheetroute/SheetRoute.dart';
import 'package:tools/src/sheetroute/SheetRouteController.dart';

class DefaultSheetRoute<T> extends SheetRoute<T> {
  DefaultSheetRoute({
    this.bodyDataException0,
    this.bodyDataFuture0,
    required this.bodySliver0,
    this.failureWidget0,
    this.headerSliver0,
    this.loadingWidget0,
    this.noMoreWidget0,
    this.popMethod0,
  });

  final void Function(Object? exception, StackTrace? stackTrace)? bodyDataException0;

  final Future<void> Function(List<T> bodyData, Mark mark)? bodyDataFuture0;

  final Widget Function() bodySliver0;
  final Widget Function()? failureWidget0;
  final Widget Function()? headerSliver0;
  final Widget Function()? loadingWidget0;
  final Widget Function()? noMoreWidget0;

  final void Function()? popMethod0;

  @override
  void bodyDataException(Object? exception, StackTrace? stackTrace) {
    bodyDataException0 == null ? (throw '未处理 bodyDataException: $exception') : bodyDataException0?.call(exception, stackTrace);
  }

  @override
  Future<void> bodyDataFuture(List<T> bodyData, Mark mark) async => await bodyDataFuture0?.call(bodyData, mark);

  @override
  Widget bodySliver() => bodySliver0();

  @override
  Widget failureWidget() => failureWidget0?.call() ?? Container();

  @override
  Widget headerSliver() => headerSliver0?.call() ?? const SliverToBoxAdapter();

  @override
  Widget loadingWidget() => loadingWidget0?.call() ?? Container();

  @override
  Widget noMoreWidget() => noMoreWidget0?.call() ?? Container();

  @override
  void popMethod() => popMethod0?.call();
}
