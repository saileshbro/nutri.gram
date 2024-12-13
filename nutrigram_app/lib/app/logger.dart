import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  final String className;
  SimpleLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter().levelColors?[event.level];
    final emoji = PrettyPrinter().levelEmojis?[event.level];
    return [
      if (color != null && emoji != null)
        '$emoji $className: ${event.message}'
      else
        '',
    ];
  }
}

Logger getLogger(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}
