import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

import '../../tool/freebox/FreeBox.dart';
import '../DriftDb.dart';

class DriftViewer extends StatefulWidget {
  const DriftViewer({Key? key, required this.database}) : super(key: key);
  final drift.GeneratedDatabase database;

  @override
  State<DriftViewer> createState() => _DriftViewerState();
}

class _DriftViewerState extends State<DriftViewer> {
  final List<drift.TableInfo> tableInfos = [];
  final List<String> _triggers = [];
  final List<String> _sqls = [];

  @override
  void initState() {
    super.initState();
    tableInfos.addAll(DriftDb.instance.allTables);
    tableInfos.sort((a, b) => a.actualTableName.compareTo(b.actualTableName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tables'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(1, 0, 0, 0),
                items: [
                  PopupMenuItem(
                    child: const Text('显示/隐藏 sql'),
                    onTap: () async {
                      if (_sqls.isNotEmpty) {
                        _sqls.clear();
                        if (mounted) setState(() {});
                        return;
                      }
                      for (int i = 0; i < tableInfos.length; i++) {
                        final tableResult = await widget.database
                            .customSelect("SELECT * FROM sqlite_master WHERE type = 'table' AND name = '${tableInfos[i].actualTableName}'")
                            .get();
                        _sqls.add(tableResult.first.data['sql']);
                      }
                      if (mounted) setState(() {});
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('显示/隐藏 trigger'),
                    onTap: () async {
                      if (_triggers.isNotEmpty) {
                        _triggers.clear();
                        if (mounted) setState(() {});
                        return;
                      }
                      for (int i = 0; i < tableInfos.length; i++) {
                        final triggerResult = await widget.database
                            .customSelect("SELECT * FROM sqlite_master WHERE type = 'trigger' AND tbl_name = '${tableInfos[i].actualTableName}'")
                            .get();
                        _triggers.add(
                          'trigger_name: ${triggerResult.isEmpty ? null : triggerResult.first.data['name'].toString()}'
                          '\n'
                          'trigger_sql: ${triggerResult.isEmpty ? null : triggerResult.first.data['sql'].toString()}',
                        );
                        if (mounted) setState(() {});
                      }
                    },
                  ),
                ],
              );
            },
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: _tableInfoWidget(),
      ),
    );
  }

  List<Widget> _tableInfoWidget() {
    List<Widget> children = [];
    for (int i = 0; i < tableInfos.length; i++) {
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: TextButton(
                  child: Text(tableInfos[i].actualTableName),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => ColumnRow(tableInfo: tableInfos[i], database: widget.database)));
                  },
                )),
              ],
            ),
            _sqls.isEmpty ? Container() : Text(_sqls[i]),
            _triggers.isNotEmpty && _sqls.isNotEmpty ? const Divider(thickness: 0.5) : Container(),
            _triggers.isEmpty ? Container() : Text(_triggers[i]),
            const Divider(thickness: 2),
          ],
        ),
      );
    }
    return children;
  }
}

class ColumnRow extends StatefulWidget {
  const ColumnRow({Key? key, required this.tableInfo, required this.database}) : super(key: key);

  final drift.GeneratedDatabase database;
  final drift.TableInfo tableInfo;

  @override
  State<ColumnRow> createState() => _ColumnRowState();
}

class _ColumnRowState extends State<ColumnRow> {
  final FreeBoxController _freeBoxController = FreeBoxController();

  final List<String> _columnNames = [];
  final List<List<dynamic>> _body = [];

  @override
  void dispose() {
    _freeBoxController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _query();
  }

  Future<void> _query() async {
    _body.addAll((await widget.database.customSelect('select * from ${widget.tableInfo.actualTableName}').get()).map<List<dynamic>>((e) {
      return e.data.values.toList();
    }));

    _columnNames.addAll(widget.tableInfo.columnsByName.keys);

    // 一次性重建，以便每行长度一样。
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FreeBox(
        freeBoxController: _freeBoxController,
        moveScaleLayerWidgets: FreeBoxMoveScaleLayerStack(
          children: [
            FreeBoxMoveScaleLayerPositioned(
              expectPosition: Offset.zero,
              child: Table(
                border: TableBorder.all(),
                defaultColumnWidth: const IntrinsicColumnWidth(),
                children: [
                  ..._columnNames.isEmpty
                      ? []
                      : [
                          TableRow(
                            children: _columnNames
                                .map(
                                  (e) => TextButton(
                                    child: Text(e),
                                    onPressed: () {},
                                  ),
                                )
                                .toList(),
                          )
                        ],
                  ..._body.map(
                    (e) => TableRow(
                      children: e
                          .map(
                            (e) => TextButton(
                              child: Text(e.toString()),
                              onPressed: () {},
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  // TableRow(children: columnNames.map((e) => Text(e)).toList()),
                ],
              ),
            ),
          ],
        ),
        fixedLayerWidgets: const [],
      ),
    );
  }
}
