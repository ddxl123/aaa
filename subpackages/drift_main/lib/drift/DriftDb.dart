
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

import '../httper/httper.dart';

part 'dao/query/GeneralQueryDAO.dart';

part 'dao/insert/InsertDAO.dart';

part 'dao/RawDAO.dart';

part 'dao/RegisterOrLoginDAO.dart';

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


part 'table/entity/KnowledgeBaseCategorys.dart';

part 'table/entity/client/ClientSyncInfos.dart';

part 'table/entity/client/Syncs.dart';

part 'table/entity/info/FragmentMemoryInfos.dart';

part 'table/entity/r/RDocument2DocumentGroups.dart';

part 'table/entity/r/RFragment2FragmentGroups.dart';

part 'table/entity/r/RNote2NoteGroups.dart';

part 'table/entity/test/Test2s.dart';

part 'table/entity/test/Tests.dart';

part 'table/entity/unit/Documents.dart';

part 'table/entity/unit/FragmentTemplates.dart';

part 'table/entity/unit/Fragments.dart';

part 'table/entity/unit/MemoryGroups.dart';

part 'table/entity/unit/MemoryModels.dart';

part 'table/entity/unit/Notes.dart';

part 'table/entity/unit_group/DocumentGroups.dart';

part 'table/entity/unit_group/FragmentGroups.dart';

part 'table/entity/unit_group/NoteGroups.dart';

part 'table/entity/user/UserComments.dart';

part 'table/entity/user/UserLikes.dart';

part 'table/entity/user/Users.dart';

const List<Type> tableClasses = [

  KnowledgeBaseCategorys,

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

  UserComments,

  UserLikes,

  Users,

];
        