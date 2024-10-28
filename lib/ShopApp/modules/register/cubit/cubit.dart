import 'package:continuelearning/ShopApp/models/login_model.dart';
import 'package:continuelearning/ShopApp/modules/register/cubit/states.dart';
import 'package:continuelearning/ShopApp/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;

  void changeFocus() {
    emit(RegisterChangeFocusState());
  }

  void postData({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterPostLoadingState());
    DioHelper.postData(path: "register", data: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then(
      (value) {
        print(value.data);
        loginModel = LoginModel.fromJson(value.data);
        emit(RegisterPostSuccessState(loginModel: loginModel));
      },
    ).catchError((error) {
      print(error.toString());
      emit(RegisterPostErrorState());
    });
  }
}
