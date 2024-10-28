import 'package:continuelearning/Counter%20Program/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(IntialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  void plus() {
    emit(PlusState());
  }

  void minus() {
    emit(MinusState());
  }

  void reset() {
    emit(ResetState());
  }
}
