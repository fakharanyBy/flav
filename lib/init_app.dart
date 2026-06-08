import 'package:flav/core/helpers/responsive_helpler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/flavor_utils/flavor_banner.dart';
import 'core/flavor_utils/flavor_cinfigurations.dart';

class InitApp extends StatefulWidget {
  const InitApp({super.key});

  @override
  State<InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        // Apply the responsive framework
        widget = responsiveFrameWork(widget);
        // Add the flavor banner for non-production builds
        if (!FlavorConfig.isProduction()) {
          widget = FlavorBanner(child: widget);
        }
        // Return the final widget
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: widget,
        );
      },
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(FlavorConfig.instance.values.appName),
        ),

        body: const Center(
          child: Text('InitApp'),
        ),
      ),
    );
  }
}
