import 'dart:async';
import 'dart:math';

import 'package:tools/tools.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';

class TestHomeAbController extends AbController {
  final user = Ab<User?>(null);

  final textEditingController = TextEditingController();

  final analysisResult = '无结果'.ab;

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    await getUser();
  }

  @override
  Widget loadingWidget() {
    return const Center(
      child: Text('加载中...'),
    );
  }

  Future<void> getUser() async {
    final result = await DriftDb.instance.generalQueryDAO.queryUser();
    user.refreshInevitable((obj) => result);
  }

  Future<void> inserts() async {
    const count = 5;
    for (int i = 0; i < count; i++) {
      final fg = await DriftDb.instance.insertDAO.insertFragmentGroup(
        WithCrts.fragmentGroupsCompanion(
          id: absent(),
          createdAt: absent(),
          updatedAt: absent(),
          fatherFragmentGroupId: null.value(),
          title: 'test ${Random().nextInt(999999)}',
        ),
      );
      for (int i = 0; i < count; i++) {
        await DriftDb.instance.insertDAO.insertFragment(
          willFragment: WithCrts.fragmentsCompanion(
            id: absent(),
            createdAt: absent(),
            updatedAt: absent(),
            fatherFragmentId: null.value(),
            title: 'test ${Random().nextInt(999999)}',
            priority: 0,
          ),
        );
      }

      for (int i = 0; i < count; i++) {
        final fg1 = await DriftDb.instance.insertDAO.insertFragmentGroup(
          WithCrts.fragmentGroupsCompanion(
            id: absent(),
            createdAt: absent(),
            updatedAt: absent(),
            fatherFragmentGroupId: fg.id.value(),
            title: 'test ${Random().nextInt(999999)}',
          ),
        );
        for (int i = 0; i < count; i++) {
          await DriftDb.instance.insertDAO.insertFragment(
            willFragment: WithCrts.fragmentsCompanion(
              id: absent(),
              createdAt: absent(),
              updatedAt: absent(),
              fatherFragmentId: fg.id.value(),
              title: 'test ${Random().nextInt(999999)}',
              priority: 0,
            ),
          );
        }

        for (int i = 0; i < count; i++) {
          final fg2 = await DriftDb.instance.insertDAO.insertFragmentGroup(
            WithCrts.fragmentGroupsCompanion(
              id: absent(),
              createdAt: absent(),
              updatedAt: absent(),
              fatherFragmentGroupId: fg1.id.value(),
              title: 'test ${Random().nextInt(999999)}',
            ),
          );
          for (int i = 0; i < count; i++) {
            await DriftDb.instance.insertDAO.insertFragment(
              willFragment: WithCrts.fragmentsCompanion(
                id: absent(),
                createdAt: absent(),
                updatedAt: absent(),
                fatherFragmentId: fg1.id.value(),
                title: 'test ${Random().nextInt(999999)}',
                priority: 0,
              ),
            );
          }

          for (int i = 0; i < count; i++) {
            await DriftDb.instance.insertDAO.insertFragment(
              willFragment: WithCrts.fragmentsCompanion(
                id: absent(),
                createdAt: absent(),
                updatedAt: absent(),
                fatherFragmentId: fg2.id.value(),
                title: 'test ${Random().nextInt(999999)}',
                priority: 0,
              ),
            );
          }
        }
      }
    }

    for (int i = 0; i < count; i++) {
      await DriftDb.instance.insertDAO.insertMemoryModel(
        WithCrts.memoryModelsCompanion(
          id: absent(),
          createdAt: absent(),
          updatedAt: absent(),
          title: 'test ${Random().nextInt(999999)}',
          familiarityAlgorithm: '',
          nextTimeAlgorithm: '',
          buttonAlgorithm: '',
          applicableGroups: '',
          applicableFields: '',
          stimulateAlgorithm: '',
        ),
      );
    }
  }
}
