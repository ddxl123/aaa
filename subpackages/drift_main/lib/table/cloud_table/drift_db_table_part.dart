
library drift_db_table_part;

import 'package:drift/drift.dart';
import 'package:drift_custom/ReferenceTo.dart';


part 'Users.dart';
            
part 'info/FragmentMemoryInfos.dart';
            
part 'monolayer_group/MemoryGroups.dart';
            
part 'r/RDocument2DocumentGroups.dart';
            
part 'r/RFragment2FragmentGroups.dart';
            
part 'r/RMemoryModel2MemoryModelGroups.dart';
            
part 'r/RNote2NoteGroups.dart';
            
part 'unit/Documents.dart';
            
part 'unit/Fragments.dart';
            
part 'unit/MemoryModels.dart';
            
part 'unit/Notes.dart';
            
part 'unit_group/DocumentGroups.dart';
            
part 'unit_group/FragmentGroups.dart';
            
part 'unit_group/MemoryModelGroups.dart';
            
part 'unit_group/NoteGroups.dart';
            
const List<Type> cloudTableClasses = [

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

];
        