import 'dart:async';

import 'package:rxdart/src/utils/forwarding_sink.dart';
import 'package:rxdart/src/utils/forwarding_stream.dart';

class _OnErrorResumeStreamSink<S> extends ForwardingSink<S, S> {
  final Stream<S> Function(Object error, StackTrace stackTrace) _recoveryFn;
  var _inRecovery = false;
  final List<StreamSubscription<S>> _recoverySubscriptions = [];

  _OnErrorResumeStreamSink(this._recoveryFn);

  @override
  void onData(S data) {
    if (!_inRecovery) {
      sink.add(data);
    }
  }

  @override
  void onError(Object e, StackTrace st) {
    _inRecovery = true;

    final recoveryStream = _recoveryFn(e, st);
    late StreamSubscription<S> subscription;

    subscription = recoveryStream.listen(
      sink.add,
      onError: sink.addError,
      onDone: () {
        _recoverySubscriptions.remove(subscription);
        sink.close();
      },
    );

    _recoverySubscriptions.add(subscription);
  }

  @override
  void onDone() {
    if (!_inRecovery) {
      sink.close();
    }
  }

  @override
  FutureOr<void> onCancel() {
    return _recoverySubscriptions.isEmpty
        ? null
        : Future.wait<void>(
            _recoverySubscriptions.map((subscription) => subscription.cancel()),
          );
  }

  @override
  void onListen() {}

  @override
  void onPause() =>
      _recoverySubscriptions.forEach((subscription) => subscription.pause());

  @override
  void onResume() =>
      _recoverySubscriptions.forEach((subscription) => subscription.resume());
}

/// Intercepts error events and switches to a recovery stream created by the
/// provided recoveryFn Function.
///
/// The OnErrorResumeStreamTransformer intercepts an onError notification from
/// the source Stream. Instead of passing the error through to any
/// listeners, it replaces it with another Stream of items created by the
/// recoveryFn.
///
/// The recoveryFn receives the emitted error and returns a Stream. You can
/// perform logic in the recoveryFn to return different Streams based on the
/// type of error that was emitted.
///
/// ### Example
///
///     Stream<int>.error(Exception())
///       .onErrorResume((dynamic e) =>
///           Stream.value(e is StateError ? 1 : 0)
///       .listen(print); // prints 0
class OnErrorResumeStreamTransformer<S> extends StreamTransformerBase<S, S> {
  /// Method which returns a [Stream], based from the error.
  final Stream<S> Function(Object error, StackTrace stackTrace) recoveryFn;

  /// Constructs a [StreamTransformer] which intercepts error events and
  /// switches to a recovery [Stream] created by the provided [recoveryFn] Function.
  OnErrorResumeStreamTransformer(this.recoveryFn);

  @override
  Stream<S> bind(Stream<S> stream) => forwardStream(
        stream,
        () => _OnErrorResumeStreamSink<S>(recoveryFn),
      );
}

/// Extends the Stream class with the ability to recover from errors in various
/// ways
extension OnErrorExtensions<T> on Stream<T> {
  /// Intercepts error events and switches to the given recovery stream in
  /// that case
  ///
  /// The onErrorResumeNext operator intercepts an onError notification from
  /// the source Stream. Instead of passing the error through to any
  /// listeners, it replaces it with another Stream of items.
  ///
  /// If you need to perform logic based on the type of error that was emitted,
  /// please consider using [onErrorResume].
  ///
  /// ### Example
  ///
  ///     ErrorStream(Exception())
  ///       .onErrorResumeNext(Stream.fromIterable([1, 2, 3]))
  ///       .listen(print); // prints 1, 2, 3
  Stream<T> onErrorResumeNext(Stream<T> recoveryStream) =>
      transform(OnErrorResumeStreamTransformer<T>((_, __) => recoveryStream));

  /// Intercepts error events and switches to a recovery stream created by the
  /// provided [recoveryFn].
  ///
  /// The onErrorResume operator intercepts an onError notification from
  /// the source Stream. Instead of passing the error through to any
  /// listeners, it replaces it with another Stream of items created by the
  /// [recoveryFn].
  ///
  /// The [recoveryFn] receives the emitted error and returns a Stream. You can
  /// perform logic in the [recoveryFn] to return different Streams based on the
  /// type of error that was emitted.
  ///
  /// If you do not need to perform logic based on the type of error that was
  /// emitted, please consider using [onErrorResumeNext] or [onErrorReturn].
  ///
  /// ### Example
  ///
  ///     ErrorStream(Exception())
  ///       .onErrorResume((e, st) =>
  ///           Stream.fromIterable([e is StateError ? 1 : 0]))
  ///       .listen(print); // prints 0
  Stream<T> onErrorResume(
          Stream<T> Function(Object error, StackTrace stackTrace) recoveryFn) =>
      transform(OnErrorResumeStreamTransformer<T>(recoveryFn));

  /// Instructs a Stream to emit a particular item when it encounters an
  /// error, and then terminate normally
  ///
  /// The onErrorReturn operator intercepts an onError notification from
  /// the source Stream. Instead of passing it through to any observers, it
  /// replaces it with a given item, and then terminates normally.
  ///
  /// If you need to perform logic based on the type of error that was emitted,
  /// please consider using [onErrorReturnWith].
  ///
  /// ### Example
  ///
  ///     ErrorStream(Exception())
  ///       .onErrorReturn(1)
  ///       .listen(print); // prints 1
  Stream<T> onErrorReturn(T returnValue) => transform(
      OnErrorResumeStreamTransformer<T>((_, __) => Stream.value(returnValue)));

  /// Instructs a Stream to emit a particular item created by the
  /// [returnFn] when it encounters an error, and then terminate normally.
  ///
  /// The onErrorReturnWith operator intercepts an onError notification from
  /// the source Stream. Instead of passing it through to any observers, it
  /// replaces it with a given item, and then terminates normally.
  ///
  /// The [returnFn] receives the emitted error and returns a value. You can
  /// perform logic in the [returnFn] to return different value based on the
  /// type of error that was emitted.
  ///
  /// If you do not need to perform logic based on the type of error that was
  /// emitted, please consider using [onErrorReturn].
  ///
  /// ### Example
  ///
  ///     ErrorStream(Exception())
  ///       .onErrorReturnWith((e, st) => e is Exception ? 1 : 0)
  ///       .listen(print); // prints 1
  Stream<T> onErrorReturnWith(
          T Function(Object error, StackTrace stackTrace) returnFn) =>
      transform(OnErrorResumeStreamTransformer<T>(
          (e, st) => Stream.value(returnFn(e, st))));
}
