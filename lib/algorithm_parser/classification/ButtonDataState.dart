part of algorithm_parser;

class ButtonDataState extends ClassificationState {
  ButtonDataState({required super.content});

  double? resultMin;
  double? resultMax;
  final List<double> resultButtonValues = [];

  bool get isSlidable => resultMin == null || resultMax == null;

  @override
  ButtonDataState parse({required String content, required AlgorithmParser algorithmParser}) {
    final trim = content.trim();
    final blank = trim.split(' ')..removeWhere((element) => element.trim() == '');
    if (blank.length == 1) {
      _parseComma(comma: blank.first, algorithmParser: algorithmParser);
    } else if (blank.length == 3) {
      resultMin = double.tryParse(blank.first) ??
          () {
            algorithmParser.throwAssert(isThrow: true, message: '${blank.first} 数值解析失败！');
            return null;
          }();
      resultMax = double.tryParse(blank.last) ??
          () {
            algorithmParser.throwAssert(isThrow: true, message: '${blank.last} 数值解析失败！');
            return null;
          }();
      _parseComma(comma: blank[1], algorithmParser: algorithmParser);
    }
    algorithmParser.throwAssert(isThrow: true, message: '"use:$content" 内容书写不规范！');
    return this;
  }

  void _parseComma({required String comma, required AlgorithmParser algorithmParser}) {
    final bvs = comma.split(',')..removeWhere((element) => element.trim() == '');
    resultButtonValues.addAll(
      bvs.map(
        (e) {
          final double? result = double.tryParse(e.trim());
          algorithmParser.throwAssert(isThrow: result == null, message: '$comma 数值解析失败！');
          return result!;
        },
      ),
    );
  }
}
