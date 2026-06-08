import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'core/flavor_utils/flavor_cinfigurations.dart';
import 'init_app.dart';

Future <void> bootstrap() async {
  final flavor = FlavorConfig.initFromEnv();
  log('bootstrap: flavor=$flavor  api=${FlavorConfig.instance.values.apiBaseUrl}');

  final Widget app = const InitApp();
  runApp(app);
}