
library drift_db;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_custom/ReferenceTo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/share_common/share_enum.dart';

part 'dao/query/GeneralQueryDAO.dart';

part 'dao/insert/InsertDAO.dart';

part 'dao/RawDAO.dart';

part 'dao/UpdateDAO.dart';

part 'dao/DeleteDAO.dart';

part 'table/Base.dart';

part 'custom/sync_tag.dart';

part 'custom/sync_curd.dart';

part 'drift_db_init.dart';

part 'DriftDb.drift.dart';

part 'DriftDb.ref.dart';

part 'DriftDb.crt.dart';

part 'DriftDb.reset.dart';


part 'table/cloud/Users.dart';

part 'table/cloud/client/ClientSyncInfos.dart';

part 'table/cloud/client/Syncs.dart';

part 'table/cloud/info/FragmentMemoryInfos.dart';

part 'table/cloud/r/RDocument2DocumentGroups.dart';

part 'table/cloud/r/RFragment2FragmentGroups.dart';

part 'table/cloud/r/RNote2NoteGroups.dart';

part 'table/cloud/test/Test2s.dart';

part 'table/cloud/test/Tests.dart';

part 'table/cloud/unit/Documents.dart';

part 'table/cloud/unit/FragmentTemplates.dart';

part 'table/cloud/unit/Fragments.dart';

part 'table/cloud/unit/MemoryGroups.dart';

part 'table/cloud/unit/MemoryModels.dart';

part 'table/cloud/unit/Notes.dart';

part 'table/cloud/unit_group/DocumentGroups.dart';

part 'table/cloud/unit_group/FragmentGroups.dart';

part 'table/cloud/unit_group/NoteGroups.dart';

const List<Type> tableClasses = [

  Users,

  ClientSyncInfos,

  Syncs,

  FragmentMemoryInfos,

  RDocument2DocumentGroups,

  RFragment2FragmentGroups,

  RNote2NoteGroups,

  Test2s,

  Tests,

  Documents,

  FragmentTemplates,

  Fragments,

  MemoryGroups,

  MemoryModels,

  Notes,

  DocumentGroups,

  FragmentGroups,

  NoteGroups,

];
        