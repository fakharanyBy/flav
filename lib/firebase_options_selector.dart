import 'package:firebase_core/firebase_core.dart';
import 'package:flav/core/flavor_utils/flavor_cinfigurations.dart';
import 'package:flav/firebase_options_development.dart' as dev;
import 'package:flav/firebase_options_staging.dart' as stg;
import 'package:flav/firebase_options_production.dart' as prod;

FirebaseOptions firebaseOptionsForFlavor() {
  switch (FlavorConfig.instance.flavor) {
    case Flavor.development:
      return dev.DefaultFirebaseOptions.currentPlatform;
    case Flavor.staging:
      return stg.DefaultFirebaseOptions.currentPlatform;
    case Flavor.production:
      return prod.DefaultFirebaseOptions.currentPlatform;
  }
}
