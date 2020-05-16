import 'dart:convert';

class Log {
  static const String _defesc = '\x1B[';
  static const String _defColor = '0m';
  static int logLevel;

  static String _verbose = '';
  static String _debug = '🐛';
  static String _info = '💡';
  static String _warning = '⚠';
  static String _error = '⛔';

//  static String _wtf = '👾';

  static const int log_level_verbose = 4;
  static const int log_level_debug = 3;
  static const int log_level_info = 2;
  static const int log_level_warning = 1;
  static const int log_level_error = 0;

  static String _fg(int color256) => "38;5;${color256}m";

  static e(string) {
    if (logLevel < log_level_error) return;
    if (string is Map) {
      string = json.encode(string);
    }
    _print(9, "$_error error!", string.toString(), StackTrace.current, 4);
  }

  static w(string) {
    if (logLevel < log_level_warning) return;
    if (string is Map) {
      string = json.encode(string);
    }
    _print(226, "$_warning warning!", string.toString(), StackTrace.current, 4);
  }

  static i(string) {
    if (logLevel < log_level_info) return;
    if (string is Map) {
      string = json.encode(string);
    }
    _print(93, "$_info info", string.toString(), StackTrace.current, 1);
  }

  static d(string) {
    if (logLevel < log_level_debug) return;
    if (string is Map) {
      string = json.encode(string);
    }
    _print(46, "$_debug debug", string.toString(), StackTrace.current, 1);
  }

  static v(string) {
    if (logLevel < log_level_verbose) return;
    if (string is Map) {
      string = json.encode(string);
    }
    _print(0, "$_verbose verbose", string.toString(), StackTrace.current, 1);
  }

  // Level.debug: AnsiColor.none(),
  // Level.info: AnsiColor.fg(12),
  // Level.warning: AnsiColor.fg(208),
  // Level.error: AnsiColor.fg(196),
  // Level.wtf: AnsiColor.fg(199),

  static final stackTraceRegex = RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');

  static String formatStackTrace(StackTrace stackTrace, int methodCount) {
    var lines = stackTrace.toString().split("\n");

    var formatted = <String>[];
    var count = 0;
    for (var line in lines) {
      var match = stackTraceRegex.matchAsPrefix(line);
      if (match != null) {
        if (match.group(2).contains('utils/log.dart')) {
          continue;
        }
        var newLine = "";
        if (count > 0) newLine += "flutter: ";
        newLine += "│\t#$count   ${match.group(1)} (${match.group(2)})";
        formatted.add(newLine.replaceAll('<anonymous closure>', '()'));
        if (++count == methodCount) {
          break;
        }
      } else {
        formatted.add(line);
      }
    }

    if (formatted.isEmpty) {
      return null;
    } else {
      return formatted.join('\n');
    }
  }

  static _print(int color256, String level, String string,
      [StackTrace stackTrace, int methodCount = 1]) {
    int len = string.length;

    bool end = false;
    int times = (len ~/ 100).toInt();
    int last = len % 100;
    if (last != 0) {
      end = true;
    }
    print(
        "$_defesc${_fg(color256)}┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────$_defesc$_defColor");
    print("$_defesc${_fg(color256)}│\t$level$_defesc$_defColor");
    print(
        "$_defesc${_fg(color256)}├───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────$_defesc$_defColor");

    if (stackTrace != null) {
      print(
          "$_defesc${_fg(color256)}${formatStackTrace(stackTrace, methodCount)}$_defesc$_defColor");
      print(
          "$_defesc${_fg(color256)}├───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────$_defesc$_defColor");
    }

    for (int i = 0; i < times; i++) {
      print(
          "$_defesc${_fg(color256)}│\t${string.substring(i * 100, (i + 1) * 100)}");
    }
    if (end)
      print(
          "$_defesc${_fg(color256)}│\t${string.substring(times * 100, (times * 100) + last)}");

    print(
        "$_defesc${_fg(color256)}└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────$_defesc$_defColor");
  }
}
