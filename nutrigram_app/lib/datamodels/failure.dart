class Failure {
  final String message;
  final int statusCode;
  Failure({
    this.message,
    this.statusCode,
  });

  @override
  String toString() => 'Failure(message: $message,code: $statusCode)';
}
