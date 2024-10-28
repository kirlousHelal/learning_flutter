import 'package:continuelearning/ShopApp/models/login_model.dart';
import 'package:continuelearning/ShopApp/modules/login/cubit/states.dart';
import 'package:continuelearning/ShopApp/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;

  void changeFocus() {
    emit(LoginChangeFocusState());
  }

  void postData({required String email, required String password}) {
    emit(LoginPostLoadingState());
    DioHelper.postData(path: "login", data: {
      "email": email,
      "password": password,
    }).then(
      (value) {
        print(value.data);
        loginModel = LoginModel.fromJson(value.data);
        emit(LoginPostSuccessState(loginModel: loginModel));
      },
    ).catchError((error) {
      print(error.toString());
      emit(LoginPostErrorState());
    });
  }
}
