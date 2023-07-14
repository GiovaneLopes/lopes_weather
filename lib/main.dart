import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lopes_weather/app_module.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'app_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  tz.initializeTimeZones();
  await dotenv.load(fileName: ".env");
  runApp(
    ModularApp(
      module: AppModdule(),
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const AppWidget(),
      ),
    ),
  );
}
