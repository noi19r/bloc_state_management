part of 'counter_cubit.dart';

enum BlocState { initial, loading, success, error }

@freezed
class CounterState with _$CounterState {
  const factory CounterState({
    @Default(0) int counter,
    @Default(BlocState.initial) status,
    @Default('') String message,
  }) = _CounterState;
}
