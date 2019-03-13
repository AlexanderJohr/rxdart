library test.rx;

import 'futures/as_observable_future_test.dart' as as_observable_future_test;
import 'futures/stream_max_test.dart' as stream_max_test;
import 'futures/stream_min_test.dart' as stream_min_test;
import 'futures/wrapped_future_test.dart' as wrapped_future_test;
import 'observables/composite_subscription_test.dart'
    as composite_subscription_test;
import 'observables/publish_connectable_observable_test.dart'
    as publish_connectable_observable_test;
import 'observables/replay_connectable_observable_test.dart'
    as replay_connectable_observable_test;
import 'observables/value_connectable_observable_test.dart'
    as value_connectable_observable_test;
import 'streams/combine_latest_test.dart' as combine_latest_test;
import 'streams/concat_eager_test.dart' as concat_eager_test;
import 'streams/concat_test.dart' as concat_test;
import 'streams/defer_test.dart' as defer_test;
import 'streams/empty_test.dart' as empty_test;
import 'streams/error_test.dart' as error_test;
import 'streams/event_transformed_test.dart' as event_transformed_test;
import 'streams/from_future_test.dart' as from_future_test;
import 'streams/from_iterable_test.dart' as from_iterable_test;
import 'streams/just_test.dart' as just_test;
import 'streams/merge_test.dart' as merge_test;
import 'streams/never_test.dart' as never_test;
import 'streams/periodic_test.dart' as periodic_test;
import 'streams/race_test.dart' as race_test;
import 'streams/range_test.dart' as range_test;
import 'streams/repeat_test.dart' as repeat_test;
import 'streams/retry_test.dart' as retry_test;
import 'streams/retry_when_test.dart' as retry_when_test;
import 'streams/stream_test.dart' as stream_test;
import 'streams/switch_latest_test.dart' as switch_latest_test;
import 'streams/timer_test.dart' as timer_test;
import 'streams/zip_test.dart' as zip_test;
import 'subject/behavior_subject_test.dart' as behaviour_subject_test;
import 'subject/publish_subject_test.dart' as publish_subject_test;
import 'subject/replay_subject_test.dart' as replay_subject_test;
import 'transformers/any_test.dart' as any_test;
import 'transformers/as_broadcast_stream.dart' as as_broadcast_stream;
import 'transformers/async_expand_test.dart' as async_expand_test;
import 'transformers/async_map_test.dart' as async_map_test;
import 'transformers/concat_map_test.dart' as concat_map_test;
import 'transformers/concat_with_test.dart' as concat_with_test;
import 'transformers/contains_test.dart' as contains_test;
import 'transformers/default_if_empty_test.dart' as default_if_empty_test;
import 'transformers/delay_test.dart' as delay_test;
import 'transformers/dematerialize_test.dart' as dematerialize_test;
import 'transformers/distinct_test.dart' as distinct_test;
import 'transformers/distinct_unique_test.dart' as distinct_unique_test;
import 'transformers/do_test.dart' as do_test;
import 'transformers/drain_test.dart' as drain_test;
import 'transformers/element_at_test.dart' as element_at_test;
import 'transformers/every_test.dart' as every_test;
import 'transformers/exhaust_map_test.dart' as exhaust_map_test;
import 'transformers/expand_test.dart' as expand_test;
import 'transformers/first_test.dart' as first_test;
import 'transformers/first_where_test.dart' as first_where_test;
import 'transformers/flat_map_iterable_test.dart' as flat_map_iterable_test;
import 'transformers/flat_map_test.dart' as flat_map_test;
import 'transformers/fold_test.dart' as fold_test;
import 'transformers/for_each_test.dart' as for_each_test;
import 'transformers/group_by_test.dart' as group_by_test;
import 'transformers/handle_error_test.dart' as handle_error_test;
import 'transformers/ignore_elements_test.dart' as ignore_elements_test;
import 'transformers/interval_test.dart' as interval_test;
import 'transformers/is_empty_test.dart' as is_empty_test;
import 'transformers/join_test.dart' as join_test;
import 'transformers/last_test.dart' as last_test;
import 'transformers/last_where_test.dart' as last_where_test;
import 'transformers/map_to_test.dart' as map_to_test;
import 'transformers/materialize_test.dart' as materialize_test;
import 'transformers/merge_with_test.dart' as merge_with_test;
import 'transformers/of_type_test.dart' as of_type_test;
import 'transformers/on_error_return_test.dart' as on_error_resume_test;
import 'transformers/on_error_return_test.dart' as on_error_return_test;
import 'transformers/on_error_return_with_test.dart'
    as on_error_return_with_test;
import 'transformers/reduce_test.dart' as reduce_test;
import 'transformers/scan_test.dart' as scan_test;
import 'transformers/single_test.dart' as single_test;
import 'transformers/single_where_test.dart' as single_where_test;
import 'transformers/skip_test.dart' as skip_test;
import 'transformers/skip_until_test.dart' as skip_until_test;
import 'transformers/skip_while_test.dart' as skip_while_test;
import 'transformers/start_with_many_test.dart' as start_with_many_test;
import 'transformers/start_with_test.dart' as start_with_test;
import 'transformers/switch_if_empty_test.dart' as switch_if_empty_test;
import 'transformers/switch_map_test.dart' as switch_map_test;
import 'transformers/take_until_test.dart' as take_until_test;
import 'transformers/take_while_test.dart' as take_while_test;
import 'transformers/time_interval_test.dart' as time_interval_test;
import 'transformers/timeout_test.dart' as timeout_test;
import 'transformers/timestamp_test.dart' as timestamp_test;
import 'transformers/to_list_test.dart' as to_list_test;
import 'transformers/to_set_test.dart' as to_set_test;
import 'transformers/transform_test.dart' as transform_test;
import 'transformers/where_test.dart' as where_test;
import 'transformers/with_latest_from_test.dart' as with_latest_from_test;
import 'transformers/zip_with_test.dart' as zip_with_test;

import 'transformers/backpressure/buffer_count_test.dart' as buffer_count_test;
import 'transformers/backpressure/buffer_test.dart' as buffer_test;
import 'transformers/backpressure/buffer_test_test.dart' as buffer_test_test;
import 'transformers/backpressure/buffer_time_test.dart' as buffer_time_test;
import 'transformers/backpressure/debounce_test.dart' as debounce_test;
import 'transformers/backpressure/debounce_time_test.dart'
    as debounce_time_test;
import 'transformers/backpressure/pairwise_test.dart' as pairwise_test;
import 'transformers/backpressure/sample_test.dart' as sample_test;
import 'transformers/backpressure/sample_time_test.dart' as sample_time_test;
/*import 'transformers/backpressure/throttle_test.dart' as throttle_test;
import 'transformers/backpressure/throttle_time_test.dart'
    as throttle_time_test;
    */
import 'transformers/backpressure/window_count_test.dart' as window_count_test;
import 'transformers/backpressure/window_test.dart' as window_test;
import 'transformers/backpressure/window_test_test.dart' as window_test_test;
import 'transformers/backpressure/window_time_test.dart' as window_time_test;

void main() {
  // Streams
  combine_latest_test.main();
  concat_eager_test.main();
  concat_test.main();
  defer_test.main();
  empty_test.main();
  error_test.main();
  event_transformed_test.main();
  from_future_test.main();
  from_iterable_test.main();
  just_test.main();
  merge_test.main();
  never_test.main();
  periodic_test.main();
  range_test.main();
  race_test.main();
  repeat_test.main();
  retry_test.main();
  retry_when_test.main();
  stream_test.main();
  switch_latest_test.main();
  zip_test.main();

  // StreamTransformers
  any_test.main();
  as_broadcast_stream.main();
  as_broadcast_stream.main();
  async_expand_test.main();
  async_map_test.main();
  concat_map_test.main();
  concat_with_test.main();
  contains_test.main();
  default_if_empty_test.main();
  delay_test.main();
  dematerialize_test.main();
  distinct_test.main();
  distinct_unique_test.main();
  do_test.main();
  drain_test.main();
  element_at_test.main();
  every_test.main();
  exhaust_map_test.main();
  expand_test.main();
  first_test.main();
  first_where_test.main();
  first_where_test.main();
  flat_map_test.main();
  flat_map_iterable_test.main();
  fold_test.main();
  for_each_test.main();
  group_by_test.main();
  handle_error_test.main();
  ignore_elements_test.main();
  interval_test.main();
  is_empty_test.main();
  join_test.main();
  last_test.main();
  last_where_test.main();
  map_to_test.main();
  materialize_test.main();
  merge_with_test.main();
  of_type_test.main();
  on_error_resume_test.main();
  on_error_return_test.main();
  on_error_return_with_test.main();
  reduce_test.main();
  scan_test.main();
  single_test.main();
  single_where_test.main();
  skip_test.main();
  skip_until_test.main();
  skip_while_test.main();
  start_with_many_test.main();
  start_with_test.main();
  switch_if_empty_test.main();
  switch_map_test.main();
  take_until_test.main();
  take_while_test.main();
  time_interval_test.main();
  timeout_test.main();
  timestamp_test.main();
  to_list_test.main();
  to_set_test.main();
  transform_test.main();
  timer_test.main();
  where_test.main();
  with_latest_from_test.main();
  zip_with_test.main();

  // Backpressure
  buffer_test.main();
  buffer_count_test.main();
  buffer_test_test.main();
  buffer_time_test.main();
  debounce_test.main();
  debounce_time_test.main();
  pairwise_test.main();
  sample_test.main();
  sample_time_test.main();
  //throttle_test.main();
  //throttle_time_test.main();
  window_test.main();
  win1dow_count_test.main();
  window_test_test.main();
  window_time_test.main();

  // Subjects
  behaviour_subject_test.main();
  publish_subject_test.main();
  replay_subject_test.main();

  // Futures
  as_observable_future_test.main();
  stream_max_test.main();
  stream_min_test.main();
  wrapped_future_test.main();

  // Observables
  value_connectable_observable_test.main();
  replay_connectable_observable_test.main();
  publish_connectable_observable_test.main();
  composite_subscription_test.main();
}
