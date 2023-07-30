import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

Future<void> showFragmentGroupTagSearchDialog({
  required Ab<List<FragmentGroupTag>> initTags,
  required FragmentGroup fragmentGroup,
}) async {
  await showCustomDialog(
    builder: (BuildContext context) {
      return FragmentGroupTagSearchDialogWidget(
        initTags: initTags,
        fragmentGroup: fragmentGroup,
      );
    },
  );
}

class FragmentGroupTagSearchDialogWidget extends StatefulWidget {
  const FragmentGroupTagSearchDialogWidget({
    super.key,
    required this.fragmentGroup,
    required this.initTags,
  });

  final FragmentGroup fragmentGroup;
  final Ab<List<FragmentGroupTag>> initTags;

  @override
  State<FragmentGroupTagSearchDialogWidget> createState() => _FragmentGroupTagSearchDialogWidgetState();
}

class _FragmentGroupTagSearchDialogWidgetState extends State<FragmentGroupTagSearchDialogWidget> {
  final textEditingController = TextEditingController();

  /// 为空数组时，提示请输入。
  ///
  /// 为非空数组时，第一个元素必然为新增标签的按钮。
  final searchedTags = <String>[];

  /// [target] 是否已被添加到其碎片组中。
  bool isAdded(String target) {
    return widget.initTags().map((e) => e.tag).contains(target);
  }

  /// [textEditingController.text] 是否存在于 [searchedTags] 中。
  bool isValueInSearchedTags() {
    return searchedTags.contains(textEditingController.text.trim());
  }

  @override
  void initState() {
    super.initState();
    searchTags("");
  }

  /// TODO: 防止并发
  Future<void> searchTags(String value) async {
    final valueTrim = value.trim();
    if (valueTrim.isEmpty) {
      searchedTags.clear();
      return;
    }

    searchedTags.clear();
    searchedTags.add("创建新标签：$valueTrim");
    final result = await request(
      path: HttpPath.NO_LOGIN_REQUIRED_FRAGMENT_GROUP_TAG_BY_LIKE,
      dtoData: QueryFragmentGroupTagByLikeDto(
        like: textEditingController.text,
        dto_padding_1: null,
      ),
      parseResponseVoData: QueryFragmentGroupTagByLikeVo.fromJson,
    );
    await result.handleCode(
      code50201: (String showMessage, QueryFragmentGroupTagByLikeVo vo) async {
        searchedTags.addAll(vo.fragment_group_tag_list.map((e) => e.tag));
        // 让完全相同的放在第二位。
        if (searchedTags.remove(valueTrim)) {
          searchedTags.insert(1, valueTrim);
        }
        setState(() {});
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outError(show: httperException.showMessage, error: httperException.debugMessage);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      mainVerticalWidgets: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                runSpacing: 10,
                children: widget.initTags().map((FragmentGroupTag fTag) {
                  return FragmentGroupTagWidget(
                    backgroundColor: Colors.lightBlueAccent,
                    child: GestureDetector(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '#${fTag.tag}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 4.0),
                          const Icon(
                            Icons.cancel,
                            size: 14.0,
                            color: Color.fromARGB(255, 233, 233, 233),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              TextField(
                maxLength: 10,
                controller: textEditingController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "请输入标签名进行搜索或新建...",
                  hintStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 74, 137, 92),
                      width: 3.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                ),
                onChanged: (v) {
                  searchTags(v);
                },
              ),
              SizedBox(height: 10),
              Wrap(
                runSpacing: 10,
                children: [
                  for (int i = 0; i < searchedTags.length; i++)
                    if (i == 0)
                      isValueInSearchedTags()
                          ? Container()
                          : GestureDetector(
                              child: FragmentGroupTagWidget(
                                backgroundColor: Colors.lightBlueAccent,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      searchedTags[i],
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                /// TODO: 创建新标签需要联网，并且需要登录状态。
                                final result = await request(
                                  path: HttpPath.LOGIN_REQUIRED_FRAGMENT_GROUP_TAG_NEW_FRAGMENT_GROUP_TAG,
                                  dtoData: FragmentGroupTagNewFragmentGroupTagDto(
                                    tag: textEditingController.text,
                                    dto_padding_1: null,
                                  ),
                                  parseResponseVoData: FragmentGroupTagNewFragmentGroupTagVo.fromJson,
                                );
                                await result.handleCode(
                                  code60101: (String showMessage, FragmentGroupTagNewFragmentGroupTagVo vo) async {
                                    print(showMessage);
                                  },
                                  otherException: (int? code, HttperException httperException, StackTrace st) async {
                                    logger.outError(show: httperException.showMessage, error: httperException.debugMessage);
                                  },
                                );
                              },
                            )
                    else
                      FragmentGroupTagWidget(
                        backgroundColor: isAdded(searchedTags[i]) ? Colors.grey : Colors.white,
                        child: GestureDetector(
                          onTap: isAdded(searchedTags[i])
                              ? null
                              : () {
                                  widget.initTags.refreshEasy(
                                    (oldValue) => oldValue
                                      ..add(
                                        FragmentGroupTag.fromJson(
                                          Crt.fragmentGroupTagsCompanion(tag: searchedTags[i]).toColumns(false),
                                        ),
                                      ),
                                  );
                                  setState(() {});
                                },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                searchedTags[i],
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 4.0),
                              const Icon(
                                Icons.cancel,
                                size: 14.0,
                                color: Color.fromARGB(255, 233, 233, 233),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
      bottomHorizontalButtonWidgets: [],
    );
  }
}

class FragmentGroupTagWidget extends StatelessWidget {
  const FragmentGroupTagWidget({super.key, required this.child, required this.backgroundColor});

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: backgroundColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: child,
    );
  }
}
