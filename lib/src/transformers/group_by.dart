import 'dart:async';

import 'package:rxdart/src/utils/forwarding_sink.dart';
import 'package:rxdart/src/utils/forwarding_stream.dart';

class _GroupByStreamSink<T, K> extends ForwardingSink<T, GroupByStream<T, K>> {
  final K Function(T event) grouper;
  final Stream<void> Function(GroupByStream<T, K>)? duration;

  final groups = <K, StreamController<T>>{};
  Map<K, StreamSubscription<void>>? subscriptions;

  _GroupByStreamSink(this.grouper, this.duration);

  void _closeAll() {
    groups.values.forEach((c) => c.close());
    groups.clear();
  }

  StreamController<T> _controllerBuilder(K key) {
    final groupedController = StreamController<T>.broadcast(sync: true);
    final groupByStream = GroupByStream<T, K>(key, groupedController.stream);

    if (duration != null) {
      subscriptions?.remove(key)?.cancel();
      (subscriptions ??= {})[key] = duration!(groupByStream).take(1).listen(
        null,
        onDone: () {
          subscriptions!.remove(key);
          groups.remove(key)?.close();
        },
        onError: onError,
      );
    }

    sink.add(groupByStream);
    return groupedController;
  }

  @override
  void onData(T data) {
    final K key;
    try {
      key = grouper(data);
    } catch (e, s) {
      sink.addError(e, s);
      return;
    }

    groups.putIfAbsent(key, () => _controllerBuilder(key)).add(data);
  }

  @override
  void onError(e, st) => sink.addError(e, st);

  @override
  void onDone() {
    _closeAll();
    sink.close();
  }

  @override
  FutureOr<void> onCancel() {
    scheduleMicrotask(_closeAll);

    if (subscriptions?.isNotEmpty == true) {
      final future = Future.wait(subscriptions!.values.map((s) => s.cancel()));
      subscriptions?.clear();
      subscriptions = null;
      return future;
    } else {
      return null;
    }
  }

  @override
  FutureOr<void> onListen() {}

  @override
  void onPause() => subscriptions?.values.forEach((s) => s.pause());

  @override
  void onResume() => subscriptions?.values.forEach((s) => s.resume());
}

/// The GroupBy operator divides a [Stream] that emits items into
/// a [Stream] that emits [GroupByStream],
/// each one of which emits some subset of the items
/// from the original source [Stream].
///
/// [GroupByStream] acts like a regular [Stream], yet
/// adding a 'key' property, which receives its [Type] and value from
/// the [_grouper] Function.
///
/// All items with the same key are emitted by the same [GroupByStream].
class GroupByStreamTransformer<T, K>
    extends StreamTransformerBase<T, GroupByStream<T, K>> {
  /// Method which converts incoming events into a new [GroupByStream]
  final K Function(T event) grouper;

  /// A function that returns an [Stream] to determine how long each group should exist.
  /// When the returned [Stream] emits its first data or done event,
  /// the group will be closed and removed.
  final Stream<void> Function(GroupByStream<T, K> grouped)? duration;

  /// Constructs a [StreamTransformer] which groups events from the source
  /// [Stream] and emits them as [GroupByStream].
  GroupByStreamTransformer(this.grouper, [this.duration]);

  @override
  Stream<GroupByStream<T, K>> bind(Stream<T> stream) =>
      forwardStream(stream, () => _GroupByStreamSink<T, K>(grouper, duration));
}

/// The [Stream] used by [GroupByStreamTransformer], it contains events
/// that are grouped by a key value.
class GroupByStream<T, K> extends StreamView<T> {
  /// The key is the category to which all events in this group belong to.
  final K key;

  /// Constructs a [Stream] which only emits events that can be
  /// categorized under [key].
  GroupByStream(this.key, Stream<T> stream) : super(stream);

  @override
  String toString() => 'GroupByStream{key: $key}';
}

/// Extends the Stream class with the ability to convert events into Streams
/// of events that are united by a key.
extension GroupByExtension<T> on Stream<T> {
  /// The GroupBy operator divides a [Stream] that emits items into a [Stream]
  /// that emits [GroupByStream], each one of which emits some subset of the
  /// items from the original source [Stream].
  ///
  /// [GroupByStream] acts like a regular [Stream], yet adding a 'key' property,
  /// which receives its [Type] and value from the [grouper] Function.
  ///
  /// All items with the same key are emitted by the same [GroupByStream].
  ///
  /// Optionally, `groupBy` takes a second argument [duration].
  /// [duration] is a function that returns an [Stream] to determine how long
  /// each group should exist. When the returned [Stream] emits its first data or done event,
  /// the group will be closed and removed.
  Stream<GroupByStream<T, K>> groupBy<K>(K Function(T value) grouper,
          [Stream<void> Function(GroupByStream<T, K> grouped)? duration]) =>
      transform(GroupByStreamTransformer<T, K>(grouper, duration));
}
