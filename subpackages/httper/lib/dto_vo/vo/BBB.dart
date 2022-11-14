
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'BBB.g.dart';
@JsonSerializable()
class BBB {

    /// 
    int id;

BBB({

    required this.id,

});
    factory BBB.fromJson(Map<String, dynamic> json) => _$BBBFromJson(json);
    Map<String, dynamic> toJson() => _$BBBToJson(this);
}
