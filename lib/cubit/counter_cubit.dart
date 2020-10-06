import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:replay_bloc/replay_bloc.dart';

class CounterCubit extends HydratedCubit<int> with ReplayCubitMixin {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);

  void reset() => emit(0);

  @override
  int fromJson(Map<String, dynamic> json) => json['counter'] as int;

  @override
  Map<String, dynamic> toJson(int state) => {'counter': state};
}
