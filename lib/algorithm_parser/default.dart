import 'package:aaa/algorithm_parser/parser.dart';

/// 注意接收的是 if-else 原生语句。
class DefaultAlgorithmOfRaw {
  DefaultAlgorithmOfRaw({
    required this.title,
    required this.buttonDataContent,
    required this.familiarityContent,
    required this.nextShowTimeContent,
  });

  final String title;
  final String buttonDataContent;
  final String familiarityContent;
  final String nextShowTimeContent;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DefaultAlgorithmOfRaw &&
        other.title == title &&
        other.buttonDataContent == buttonDataContent &&
        other.familiarityContent == familiarityContent &&
        other.nextShowTimeContent == nextShowTimeContent;
  }

  @override
  int get hashCode {
    return Object.hash(title, buttonDataContent, familiarityContent, nextShowTimeContent);
  }

  static final defaultList = <DefaultAlgorithmOfRaw>[];

  static List<DefaultAlgorithmOfRaw> getDefaults() {
    final default1 = DefaultAlgorithmOfRaw.default1();
    if (!defaultList.contains(default1)) {
      defaultList.add(default1);
    }
    return defaultList;
  }

  static DefaultAlgorithmOfRaw default1() {
    return DefaultAlgorithmOfRaw(
      title: "艾宾浩斯复习周期",
      buttonDataContent: """
      if(true){
        1;下一个
      }
      """,
      familiarityContent: """
      if(true){
        1
      }
      """,
      nextShowTimeContent: """
      StudiedTimes = ${InternalVariableConstantHandler.k3StudiedTimesConst.name}
      if(StudiedTimes == 0){
        5*60
      }else if(StudiedTimes == 1){
        20*60
      }else if(StudiedTimes == 2){
        60*60*8
      }else if(StudiedTimes == 3){
        60*60*24
      }else if(StudiedTimes == 4){
        60*60*24*2
      }else if(StudiedTimes == 5){
        60*60*24*4
      }else if(StudiedTimes == 6){
        60*60*24*7
      }else if(StudiedTimes == 7){
        60*60*24*16
      }else{
        60*60*24*30
      }
      """,
    );
  }
}
