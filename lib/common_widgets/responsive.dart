import 'package:flutter/material.dart';

// A utility widget that stores the screen width
// and contains functions to check if the screen falls into set breakpoints
// largeScreen, mediumScreen, smallScreen
//
// Use a conditional if ternary statement to build an
// alternative version to accomdate screen sizes
//
// condition ? true widget : false widget
// Responsive.isSmallScreen(context) ? Container() : Row()
//
// also this might not need to be a stateless widget and just be a
// plain dart class...?
//
class Responsive extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const Responsive({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width <= 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return largeScreen;
        } else if (constraints.maxWidth <= 1200 &&
            constraints.maxWidth >= 800) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}
