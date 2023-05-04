import 'package:aaa/algorithm_parser/parser.dart';

class DefaultAlgorithm {
  DefaultAlgorithm({
    required this.title,
    required this.buttonDataContent,
    required this.familiarityContent,
    required this.nextShowTimeContent,
  });

  final String title;
  final String buttonDataContent;
  final String familiarityContent;
  final String nextShowTimeContent;

  static final defaultList = <DefaultAlgorithm>[];

  static List<DefaultAlgorithm> initDefault() {
    defaultList.add(default1());
    return defaultList;
  }

  static DefaultAlgorithm default1() {
    return DefaultAlgorithm(
      title: "艾宾浩斯复习周期",
      buttonDataContent: """
      if(true){
        1,下一个
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
        if(aa=ddd){
          dddd
        }else{
          zzzzzz
        }
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
