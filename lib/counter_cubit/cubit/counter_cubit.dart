import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_state.dart';
part 'counter_cubit.freezed.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState());

  void init() async {
    try {
      emit(state.copyWith(status: BlocState.loading));
      //call api
      await Future.delayed(const Duration(seconds: 5));
      throw Exception("Noi lao leu");
      emit(state.copyWith(status: BlocState.success, counter: 1000));
    } catch (ex) {
      emit(state.copyWith(status: BlocState.error, message: ex.toString()));
    }
  }

  void increment(int step) {
    emit(state.copyWith(counter: state.counter + step));
  }
}
