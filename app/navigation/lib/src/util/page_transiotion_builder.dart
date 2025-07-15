import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CupertinoPageTransitionWithFullGesture extends StatelessWidget {
  final Animation<double> primaryRouteAnimation;
  final Animation<double> secondaryRouteAnimation;
  final Widget child;
  final bool linearTransition;
  final double gestureWidth;

  const CupertinoPageTransitionWithFullGesture({
    super.key,
    required this.primaryRouteAnimation,
    required this.secondaryRouteAnimation,
    required this.child,
    this.linearTransition = false,
    this.gestureWidth = 1.0, // 100% of screen width
  });

  @override
  Widget build(BuildContext context) {
    final curvedAnimation = linearTransition
        ? primaryRouteAnimation
        : CurvedAnimation(
      parent: primaryRouteAnimation,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    return _CupertinoBackGestureDetector(
      gestureWidthFactor: gestureWidth,
      enabledCallback: () => Navigator.of(context).userGestureInProgress,
      onStartPopGesture: () => Navigator.of(context).pop(),
      child: CupertinoPageTransition(
        primaryRouteAnimation: curvedAnimation,
        secondaryRouteAnimation: secondaryRouteAnimation,
        child: child,
        linearTransition: linearTransition,
      ),
    );
  }
}

class _CupertinoBackGestureDetector extends StatelessWidget {
  final Widget child;
  final bool Function() enabledCallback;
  final VoidCallback onStartPopGesture;
  final double gestureWidthFactor;

  const _CupertinoBackGestureDetector({
    required this.child,
    required this.enabledCallback,
    required this.onStartPopGesture,
    required this.gestureWidthFactor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * gestureWidthFactor;

    return Stack(
      children: [
        child,
        Positioned(
          left: 0,
          width: width,
          top: 0,
          bottom: 0,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragStart: (details) {
              if (enabledCallback()) {
                onStartPopGesture();
              }
            },
          ),
        ),
      ],
    );
  }
}