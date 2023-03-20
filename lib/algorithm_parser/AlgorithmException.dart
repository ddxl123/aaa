import 'package:flutter/material.dart';

abstract class AlgorithmException {
  AlgorithmException(this.error, [this.stackTrace]);

  final String error;

  final StackTrace? stackTrace;
}

class KnownAlgorithmException extends AlgorithmException {
  KnownAlgorithmException(super.error, [super.stackTrace]);

  @override
  int get hashCode => error.hashCode;

  @override
  bool operator ==(Object other) {
    return (other is KnownAlgorithmException) ? other.error == error : other == this;
  }

  @override
  String toString() {
    return "Error:\n$error\nStackTrace:\n${stackTrace?.toString()}";
  }
}

class UnknownAlgorithmException extends KnownAlgorithmException {
  UnknownAlgorithmException(super.error, [super.stackTrace]);
}

class AlgorithmExceptionBackgroundWidget extends StatelessWidget {
  const AlgorithmExceptionBackgroundWidget({
    Key? key,
    required this.child,
    required this.algorithmException,
  }) : super(key: key);
  final Widget child;
  final AlgorithmException? algorithmException;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: algorithmException == null ? null : Color.fromRGBO(255, 0, 0, 0.1),
      child: child,
    );
  }
}

List<Widget> algorithmExceptionTextWidgetList({required AlgorithmException? algorithmException}) {
  return [
    ...algorithmException == null
        ? []
        : [
            SizedBox(width: 10),
            Text(algorithmException.error, style: TextStyle(color: Colors.red)),
          ]
  ];
}
