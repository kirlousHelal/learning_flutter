import 'package:continuelearning/ShopApp/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangeFocusState extends LoginStates {}

class LoginPostLoadingState extends LoginStates {}

class LoginPostSuccessState extends LoginStates {
  final LoginModel? loginModel;

  LoginPostSuccessState({required this.loginModel});
}

class LoginPostErrorState extends LoginStates {}
