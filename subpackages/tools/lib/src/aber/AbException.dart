part of aber;

class AbException {
  final Object error;
  final StackTrace stackTrace;

  AbException({required this.error, required this.stackTrace});

  @override
  String toString() => '($hashCode=====>>>>>start:\nExceptionContent:\nerror:\n$error\nstackTrace:\n$stackTrace\n:end<<<<<=====$hashCode)\n';
}
