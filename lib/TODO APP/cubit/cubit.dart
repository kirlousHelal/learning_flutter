import 'package:continuelearning/TODO%20APP/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodoAppStates> {
  TodoCubit() : super(InitialState());

  static TodoCubit get(context) => BlocProvider.of(context);

  void chageScreenBottomBar() {
    emit(ChangeScreenBottomBar());
  }

  void showBottomSheet() {
    emit(ShowBottomSheet());
  }

  void insertToDatabase() {
    emit(InsertToDatabase());
  }

  void updateToDatabase() {
    emit(UpdateToDatabase());
  }

  void deleteToDatabase() {
    emit(DeleteFromDatabase());
  }

  void getFromDatabase() {
    emit(GetFromDatabase());
  }

  void createDatabase() {
    emit(CreateToDatabase());
  }
}
