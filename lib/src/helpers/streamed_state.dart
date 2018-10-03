import 'dart:async';
import 'package:flutter/widgets.dart';

/// A base class for the [State] of a widget that manages stream(s).
abstract class StreamedState<T extends StatefulWidget> extends State<T> {
  /// Create [Stream]s and [StreamController]s, setup [StreamSubscription]s.
  ///
  /// This is called during [initState()] and [didUpdateWidget()].
  void initStreams();

  /// Cancel [StreamSubscription]s, dispose of [Stream]s and [StreamController]s.
  ///
  /// This is called during [dispose()] and [didUpdateWidget()].
  void disposeStreams();

  @override
  @mustCallSuper
  @protected
  void initState() {
    super.initState();
    initStreams();
  }

  @override
  @mustCallSuper
  @protected
  void dispose() {
    disposeStreams();
    super.dispose();
  }

  @override
  @mustCallSuper
  @protected
  void didUpdateWidget(StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    disposeStreams();
    initStreams();
  }
}
