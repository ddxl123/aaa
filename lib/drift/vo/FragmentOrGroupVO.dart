abstract class FragmentOrGroupVO {}

class FragmentVO extends FragmentOrGroupVO {
  FragmentVO({
    required this.id,
    required this.cloudId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? cloudId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
}

class FragmentGroupVO extends FragmentOrGroupVO {
  FragmentGroupVO({
    required this.id,
    required this.cloudId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? cloudId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
}
