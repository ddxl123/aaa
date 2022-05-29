import 'dart:async';

import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FragmentHomeGetController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  final Ab<List<Ab<dynamic>>> sections = <Ab<dynamic>>[
    Fragment(id: 1, createdAt: DateTime.now(), updatedAt: DateTime.now()).ab,
    FragmentGroup(id: 222, createdAt: DateTime.now(), updatedAt: DateTime.now()).ab,
    Fragment(id: 333, createdAt: DateTime.now(), updatedAt: DateTime.now()).ab,
  ].ab;

  final fragmentsCompanion = FragmentsCompanion().ab;
  final fList = <Ab<FragmentsCompanion>>[].ab;

  final count = 0.ab;
}
