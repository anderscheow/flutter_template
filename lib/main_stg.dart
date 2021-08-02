import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/my_app.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  runApp(App());
}
