import 'dart:async';
import 'package:flutter/material.dart';

/// An opinionated version of [StreamBuilder] that has default actions for
/// handling an error (show the error in a Text widget), and awaiting data
/// (show a centered CirularProgressIndicator).
class StreamHandler<T> extends StreamBuilder<T> {
  StreamHandler(
      {@required Stream<T> stream,
      @required Widget Function(BuildContext context, T data) handler,
      T initialData,
      Widget Function(BuildContext context, Object error) onError,
      Widget waiting})
      : super(
            stream: stream,
            initialData: initialData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return handler(context, snapshot.data);
              } else if (snapshot.hasError) {
                return onError == null
                    ? Text('${snapshot.error}')
                    : onError(context, snapshot.error);
              }
              return waiting ?? Center(child: CircularProgressIndicator());
            });
}

/// An opinionated version of [FutureBuilder] that has default actions for
/// handling an error (show the error in a Text widget), and awaiting data
/// (show a centered CirularProgressIndicator).
class FutureHandler<T> extends FutureBuilder<T> {
  FutureHandler(
      {@required Future<T> future,
      @required Widget Function(BuildContext context, T data) handler,
      T initialData,
      Widget Function(BuildContext context, Object error) onError,
      Widget waiting})
      : super(
            future: future,
            initialData: initialData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return handler(context, snapshot.data);
              } else if (snapshot.hasError) {
                return onError == null
                    ? Text('${snapshot.error}')
                    : onError(context, snapshot.error);
              }
              return waiting ?? Center(child: CircularProgressIndicator());
            });
}
