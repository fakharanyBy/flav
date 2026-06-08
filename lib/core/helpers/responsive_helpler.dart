import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

Widget responsiveFrameWork(widget) => ScrollConfiguration(
  behavior: const ScrollBehaviorModified(),
  child: ResponsiveWrapper.builder(
    //ClampingScrollWrapper(child: widget!),
    widget,
    minWidth: 360.0,
    defaultScale: true,
    breakpoints: const [
      ResponsiveBreakpoint.autoScale(480, name: MOBILE),
      ResponsiveBreakpoint.autoScale(800, name: TABLET, scaleFactor: 1.5),
      ResponsiveBreakpoint.autoScale(1000,
          name: 'L TABLET', scaleFactor: 1.6),
      ResponsiveBreakpoint.autoScale(1500, name: DESKTOP, scaleFactor: 1.7),
    ],
    breakpointsLandscape: const [
      ResponsiveBreakpoint.autoScaleDown(480, name: MOBILE),
      ResponsiveBreakpoint.autoScaleDown(800,
          name: TABLET, scaleFactor: 1.5),
      ResponsiveBreakpoint.autoScaleDown(1000,
          name: 'L TABLET', scaleFactor: 1.2),
      ResponsiveBreakpoint.autoScaleDown(1500,
          name: DESKTOP, scaleFactor: 1.3),
    ],
  ),
);

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return StretchingOverscrollIndicator(
      axisDirection: details.direction,
      child: child,
    );
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}
