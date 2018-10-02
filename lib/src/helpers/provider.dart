import 'package:flutter/widgets.dart';
import 'package:async_resource/async_resource.dart';
import 'package:async_resource_flutter/src/helpers/streamed_state.dart';
import 'package:async_resource_flutter/src/helpers/async_handlers.dart';

/// An [InheritedWidget] that follows the provider pattern in Flutter.
/// `InheritedModel` is not yet in the beta channel, but when it is this will
/// be deprecated and a class named `ResourceModel` take its place.
class ResourceProvider<T> extends InheritedWidget {
  ResourceProvider({Key key, @required this.resource, @required Widget child})
      : super(key: key, child: child);

  final StreamedResource<T> resource;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static StreamedResource of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ResourceProvider)
              as ResourceProvider)
          .resource;
}

/// Introduces [ResourceProvider] into the widget tree and manages its state.
class ResourceProviderRoot<T> extends StatefulWidget {
  ResourceProviderRoot({Key key, @required this.onInit, @required this.child})
      : super(key: key);

  /// Passed to [StreamedState.initStreams()].
  final StreamedResource<T> Function() onInit;
  final Widget child;
  _ResourceProviderRootState createState() => _ResourceProviderRootState();
}

class _ResourceProviderRootState<T>
    extends StreamedState<ResourceProviderRoot<T>> {
  StreamedResource<T> resource;

  @override
  Widget build(BuildContext context) =>
      ResourceProvider<T>(resource: resource, child: widget.child);

  @override
  void initStreams() => resource = widget.onInit();

  @override
  void disposeStreams() => resource.dispose();
}

/// Uses the stream of data from a [StreamedResource] by accessing a
/// [ResourceProvider] ancestor.
class ResourceWidget<T> extends StatelessWidget {
  ResourceWidget(this.builder, {this.waiting});
  final Widget Function(BuildContext context, T data) builder;
  final Widget waiting;
  @override
  Widget build(BuildContext context) {
    final res = ResourceProvider.of(context);
    return StreamHandler<T>(
      stream: res.stream,
      initialData: res.resource.data,
      handler: builder,
      waiting: waiting,
    );
  }
}

class ResourceReloader<T> extends
