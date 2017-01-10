import 'package:benchmark_harness/benchmark_harness.dart';

import 'package:rxdart/rxdart.dart' as rx;

import 'benchmark_utils.dart';

void main() => ZipBenchmark.main();

class ZipBenchmark extends BenchmarkBase {

  ZipBenchmark() : super("zip");

  static void main() => new ZipBenchmark().report();

  @override void run() {
    rx.Observable.zipTwo(
        range(),
        range(),
            (int x, int y) => x + y
    )
        .listen(null);
  }
}