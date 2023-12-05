import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplate.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

import '../../edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import '../../edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplatePreviewWidget.dart';
import '../../edit/FragmentGizmoEditPage/FragmentTemplate/template/question_answer/QAFragmentTemplate.dart';
import '../../edit/FragmentGizmoEditPage/FragmentTemplate/template/question_answer/QAFragmentTemplatePreviewWidget.dart';

class MultiFragmentTemplatePage extends StatefulWidget {
  const MultiFragmentTemplatePage({
    super.key,
    required this.allFragments,
    required this.fragment,
  });

  final List<Fragment> allFragments;
  final Fragment fragment;

  @override
  State<MultiFragmentTemplatePage> createState() => _MultiFragmentTemplatePageState();
}

class _MultiFragmentTemplatePageState extends State<MultiFragmentTemplatePage> {
  final carouselController = CarouselController();

  int currentIndex = 0;

  /// null 表示没有上/下一页
  final fragment3 = <Fragment?>[null, null, null];

  Fragment? get current => fragment3[currentIndex];

  @override
  void initState() {
    super.initState();
    fragment3[0] = widget.fragment;
    currentIndex = 0;
    load(fragment3[0]!);
  }

  Fragment? getLast(Fragment current) {
    final currentIndex = widget.allFragments.indexOf(current);
    if (currentIndex == 0) {
      return null;
    }
    return widget.allFragments[currentIndex - 1];
  }

  Fragment? getNext(Fragment current) {
    final currentIndex = widget.allFragments.indexOf(current);
    if (currentIndex == widget.allFragments.length - 1) {
      return null;
    }
    return widget.allFragments[currentIndex + 1];
  }

  void load(Fragment current) {
    final currentIndex = fragment3.indexOf(current);
    late final int lastIndex;
    if (currentIndex == 0) {
      lastIndex = 2;
    } else if (currentIndex == 1) {
      lastIndex = 0;
    } else {
      lastIndex = 1;
    }
    late final int nextIndex;
    if (currentIndex == 0) {
      nextIndex = 1;
    } else if (currentIndex == 1) {
      nextIndex = 2;
    } else {
      nextIndex = 0;
    }

    fragment3[lastIndex] = getLast(current);
    fragment3[nextIndex] = getNext(current);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("预览"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () async {
              if (current != null) {
                pushToFragmentEditView(
                  context: context,
                  initFragmentAb: current!,
                  initFragmentTemplate: FragmentTemplate.newInstanceFromContent(current!.content),
                  initSomeBefore: [],
                  initSomeAfter: [],
                  enterDynamicFragmentGroups: null,
                  isEditableAb: true.ab,
                  isTailNew: false,
                );
              }
            },
          ),
        ],
      ),
      body: CarouselSlider.builder(
        carouselController: carouselController,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          final current = fragment3[index];
          if (current == null) {
            return Container();
          }
          final ft = FragmentTemplate.newInstanceFromContent(current.content);
          return FragmentTemplate.templateSwitch(
            ft.fragmentTemplateType,
            questionAnswer: () {
              return QAFragmentTemplatePreviewWidget(qaFragmentTemplate: ft as QAFragmentTemplate);
            },
            choice: () {
              return ChoiceFragmentTemplatePreviewWidget(choiceFragmentTemplate: ft as ChoiceFragmentTemplate);
            },
          );
        },
        options: CarouselOptions(
          viewportFraction: 1,
          enlargeCenterPage: true,
          enlargeFactor: 0.5,
          height: MediaQuery.of(context).size.height,
          onPageChanged: (v, r) {
            if (fragment3[v] == null) {
              carouselController.animateToPage(currentIndex);
            } else {
              currentIndex = v;
              load(fragment3[v]!);
            }
          },
        ),
      ),
    );
  }
}
