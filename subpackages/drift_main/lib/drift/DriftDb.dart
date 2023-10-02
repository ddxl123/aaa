
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
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/share_enum.dart';

part 'dao/query/GeneralQueryDAO.dart';

part 'dao/insert/InsertDAO.dart';

part 'dao/RawDAO.dart';

part 'dao/RegisterOrLoginDAO.dart';

part 'dao/UpdateDAO.dart';

part 'dao/DeleteDAO.dart';

part 'table/Base.dart';

part 'custom/sync_tag.dart';

part 'drift_db_init.dart';

part 'DriftDb.drift.dart';

part 'DriftDb.crt.dart';


part 'table/entity/client/ClientSyncInfos.dart';

part 'table/entity/client/Syncs.dart';

part 'table/entity/info/FragmentMemoryInfos.dart';

part 'table/entity/other/FragmentGroupTags.dart';

part 'table/entity/r/RFragment2FragmentGroups.dart';

part 'table/entity/test/Test2s.dart';

part 'table/entity/test/Tests.dart';

part 'table/entity/unit/Fragments.dart';

part 'table/entity/unit/MemoryGroups.dart';

part 'table/entity/unit/MemoryModels.dart';

part 'table/entity/unit/Shorthands.dart';

part 'table/entity/unit_group/FragmentGroupBeSaveds.dart';

part 'table/entity/unit_group/FragmentGroupLikes.dart';

part 'table/entity/unit_group/FragmentGroups.dart';

part 'table/entity/user/UserComments.dart';

part 'table/entity/user/UserFollows.dart';

part 'table/entity/user/Users.dart';

const List<Type> tableClasses = [

  ClientSyncInfos,

  Syncs,

  FragmentMemoryInfos,

  FragmentGroupTags,

  RFragment2FragmentGroups,

  Test2s,

  Tests,

  Fragments,

  MemoryGroups,

  MemoryModels,

  Shorthands,

  FragmentGroupBeSaveds,

  FragmentGroupLikes,

  FragmentGroups,

  UserComments,

  UserFollows,

  Users,

];
        