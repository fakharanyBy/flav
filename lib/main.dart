import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flav/core/flavor_utils/flavor_cinfigurations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'bootstrap.dart';
import 'firebase_options_selector.dart';

void main() async {
  runZonedGuarded<Future<void>>(initializeAndRunApp, handleStartupError);
}

Future<void> initializeAndRunApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeAppServices();
  await bootstrap();
}

Future<void> initializeAppServices() async {
  FlavorConfig.initFromEnv();
  await initializeFirebaseForCurrentFlavor();
}

Future<void> initializeFirebaseForCurrentFlavor() async {
  if (Firebase.apps.isNotEmpty) {
    Firebase.apps;
    return;
  }
  try {
    await Firebase.initializeApp(options: firebaseOptionsForFlavor());
  } on FirebaseException catch (error) {
    if (error.code == 'duplicate-app') {
      Firebase.app();
      return;
    }

    rethrow;
  }
}

Future<void> handleStartupError(Object error, StackTrace stackTrace) async {
  FlutterNativeSplash.remove();
  log('Unhandled startup error', error: error, stackTrace: stackTrace);
}

