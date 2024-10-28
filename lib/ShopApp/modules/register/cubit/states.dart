import 'package:continuelearning/ShopApp/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangeFocusState extends RegisterStates {}

class RegisterPostLoadingState extends RegisterStates {}

class RegisterPostSuccessState extends RegisterStates {
  final LoginModel? loginModel;

  RegisterPostSuccessState({required this.loginModel});
}

class RegisterPostErrorState extends RegisterStates {}
