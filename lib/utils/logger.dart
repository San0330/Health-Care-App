import 'package:logger/logger.dart';

Logger getLogger(String className) {
  return Logger(printer: SimpleLogger(className));
}

class SimpleLogger extends LogPrinter {
  final String className;

  SimpleLogger(this.className);

  @override
  List<String> log(LogEvent event) {
    final level = event.level;
    final color = PrettyPrinter.levelColors[level];
    final emoji = PrettyPrinter.levelEmojis[level];

    return [color("$emoji $className - ${event.message}")];
  }
}
