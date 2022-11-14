
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'AAA.g.dart';
@JsonSerializable()
class AAA {

    /// 
    DateTime created_at;

AAA({

    required this.created_at,

});
    factory AAA.fromJson(Map<String, dynamic> json) => _$AAAFromJson(json);
    Map<String, dynamic> toJson() => _$AAAToJson(this);
}
