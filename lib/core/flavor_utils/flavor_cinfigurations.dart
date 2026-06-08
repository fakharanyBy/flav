import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

enum Flavor { development, staging, production }

class FlavorValues {
  final String apiBaseUrl;
  final String appName;
  final Flavor usingFlavor;
  final Color bannerColor;

  FlavorValues({
    required this.apiBaseUrl,
    required this.appName,
    required this.usingFlavor,
    required this.bannerColor,
  });

  /// Reads API_BASE_URL from --dart-define-from-file.
  factory FlavorValues.fromEnv(Flavor flavor) {
    const apiBaseUrl = String.fromEnvironment("API_BASE_URL");

    assert(
      apiBaseUrl.isNotEmpty,
      'API_BASE_URL must be provided via --dart-define-from-file',
    );

    final (bannerColor, appName) = switch (flavor) {
      Flavor.development => (Colors.red, 'Flav Deveeeeeeeeeee'),
      Flavor.staging => (Colors.blue, 'Flav Staging'),
      Flavor.production => (Colors.transparent, 'Flav'),
    };

    return FlavorValues(
      apiBaseUrl: apiBaseUrl,
      appName: appName,
      usingFlavor: flavor,
      bannerColor: bannerColor,
    );
  }
}

class FlavorConfig {
  final Flavor flavor;
  final FlavorValues values;
  static FlavorConfig? _instance;

  FlavorConfig._internal(this.flavor, this.values);

  factory FlavorConfig({required Flavor flavor, required FlavorValues values}) {
    _instance = FlavorConfig._internal(flavor, values);
    return _instance!;
  }

  static FlavorConfig get instance {
    assert(
      _instance != null,
      'FlavorConfig.initFromEnv() must be called before accessing instance',
    );
    return _instance!;
  }

  /// Reads FLAVOR from --dart-define-from-file, initialises the singleton,
  /// and returns the resolved [Flavor]. Call once at app start.
  static Flavor initFromEnv() {
    const name = String.fromEnvironment("FLAVOR", defaultValue: "development");
    final flavor = switch (name) {
      'development' => Flavor.development,
      'staging' => Flavor.staging,
      'production' => Flavor.production,
      _ => () {
        log('Unknown FLAVOR "$name" — defaulting to development');
        return Flavor.development;
      }(),
    };

    FlavorConfig(flavor: flavor, values: FlavorValues.fromEnv(flavor));
    return flavor;
  }

  static bool isDevelopment() => _instance?.flavor == Flavor.development;
  static bool isStaging() => _instance?.flavor == Flavor.staging;
  static bool isProduction() => _instance?.flavor == Flavor.production;
}
