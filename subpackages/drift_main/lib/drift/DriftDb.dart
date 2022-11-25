
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

part 'dao/InsertDAO.dart';

part 'dao/UpdateDAO.dart';

part 'dao/DeleteDAO.dart';

part 'table/Base.dart';

part 'custom/sync_tag.dart';

part 'custom/sync_curd.dart';

part 'drift_db_init.dart';

part 'DriftDb.drift.dart';

part 'DriftDb.ref.dart';

part 'DriftDb.ctr.dart';

part 'DriftDb.reset.dart';


part 'table/cloud/Users.dart';

part 'table/cloud/info/FragmentMemoryInfos.dart';

part 'table/cloud/monolayer_group/MemoryGroups.dart';

part 'table/cloud/r/RDocument2DocumentGroups.dart';

part 'table/cloud/r/RFragment2FragmentGroups.dart';

part 'table/cloud/r/RMemoryModel2MemoryModelGroups.dart';

part 'table/cloud/r/RNote2NoteGroups.dart';

part 'table/cloud/unit/Documents.dart';

part 'table/cloud/unit/Fragments.dart';

part 'table/cloud/unit/MemoryModels.dart';

part 'table/cloud/unit/Notes.dart';

part 'table/cloud/unit_group/DocumentGroups.dart';

part 'table/cloud/unit_group/FragmentGroups.dart';

part 'table/cloud/unit_group/MemoryModelGroups.dart';

part 'table/cloud/unit_group/NoteGroups.dart';

part 'table/local/AppInfos.dart';

part 'table/local/Selecteds.dart';

part 'table/local/Syncs.dart';

const List<Type> tableClasses = [

  Users,

  FragmentMemoryInfos,

  MemoryGroups,

  RDocument2DocumentGroups,

  RFragment2FragmentGroups,

  RMemoryModel2MemoryModelGroups,

  RNote2NoteGroups,

  Documents,

  Fragments,

  MemoryModels,

  Notes,

  DocumentGroups,

  FragmentGroups,

  MemoryModelGroups,

  NoteGroups,

  AppInfos,

  Selecteds,

  Syncs,

];
        