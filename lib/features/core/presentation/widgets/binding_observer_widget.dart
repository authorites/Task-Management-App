import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_manage_management/features/passcode/presentation/screens/passcode_screen.dart';

class BindingObserverWidget extends StatefulWidget {
  const BindingObserverWidget({
    required this.child,
    this.inactiveTimeOutInSeconds = 10,
    super.key,
  });

  final Widget child;
  final int inactiveTimeOutInSeconds;

  @override
  State<BindingObserverWidget> createState() => _BindingObserverWidgetState();
}

class _BindingObserverWidgetState extends State<BindingObserverWidget>
    with WidgetsBindingObserver {
  DateTime? lastPausedTime;
  Timer? inactivityTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    inactivityTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        lastPausedTime = DateTime.now();
      case AppLifecycleState.resumed:
        if (lastPausedTime != null &&
            DateTime.now().difference(lastPausedTime!).inSeconds >
                widget.inactiveTimeOutInSeconds) {
          _handleInactivity();
        }
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
    }
  }

  // start/restart timer
  void _initializeTimer() {
    if (inactivityTimer != null) {
      inactivityTimer?.cancel();
    }
    inactivityTimer = Timer(
      Duration(seconds: widget.inactiveTimeOutInSeconds),
      _handleInactivity,
    );
  }

  void _handleInactivity() {
    inactivityTimer?.cancel();
    inactivityTimer = null;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const PasscodeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _initializeTimer(),
      onPointerMove: (_) => _initializeTimer(),
      onPointerUp: (_) => _initializeTimer(),
      child: widget.child,
    );
  }
}
