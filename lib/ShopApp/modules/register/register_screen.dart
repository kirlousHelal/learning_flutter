import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:continuelearning/ShopApp/layout/shop_layout.dart';
import 'package:continuelearning/ShopApp/modules/register/cubit/cubit.dart';
import 'package:continuelearning/ShopApp/modules/register/cubit/states.dart';
import 'package:continuelearning/ShopApp/shared/components/components.dart';
import 'package:continuelearning/ShopApp/shared/constatns/constants.dart';
import 'package:continuelearning/ShopApp/shared/network/local/cache_helper.dart';
import 'package:continuelearning/ShopApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  TextEditingController userController = TextEditingController();

  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();

  FocusNode userFocusNode = FocusNode();

  FocusNode passFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();

  bool isPassword = true;

  bool emailError = false;
  bool userError = false;
  bool passError = false;
  bool phoneError = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  void handleKeyPress(RawKeyEvent event, context) {
    // Check if the pressed key is the "Tab" key
    if (event.logicalKey == LogicalKeyboardKey.tab) {
      print("Tab key pressed!");
      RegisterCubit.get(context).changeFocus();
      // You can perform actions here if Tab is pressed
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterPostSuccessState) {
            if (state.loginModel?.status == true) {
              showToast(
                  message: state.loginModel!.message ?? "",
                  backgroundColor: ToastColors.success);

              CacheHelper.saveData(
                  key: "token", value: state.loginModel?.data?.token);
              token = state.loginModel?.data?.token;
              print(token);
              CacheHelper.saveData(key: "login", value: true);
              navigateTo(
                  context: context,
                  widget: const ShopLayout(),
                  removeAllPrevious: true);
            } else {
              showToast(
                  message: state.loginModel!.message ?? "",
                  backgroundColor: ToastColors.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: const Text(
                "Register Screen",
              ),
            ),
            body: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (value) => handleKeyPress(value, context),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        Form(
                          key: formKey,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              userTextForm(context),
                              const SizedBox(height: 20),
                              emailTextForm(context),
                              const SizedBox(height: 20),
                              passwordTextForm(context),
                              const SizedBox(height: 20),
                              phoneTextForm(context),
                              const SizedBox(height: 50),
                              ConditionalBuilder(
                                  condition: state is! RegisterPostLoadingState,
                                  builder: (context) => RegisterButton(context),
                                  fallback: (context) => Center(
                                        child: CircularProgressIndicator(
                                            color: defaultColor),
                                      )),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget userTextForm(context) => defaultTextForm(
        focusColor: userError ? const Color(0xFFB00020) : defaultColor,
        unFocusColor: userError ? const Color(0xFFB00020) : Colors.black54,
        focusNode: userFocusNode,
        onTap: () {
          // setState(() {});
          RegisterCubit.get(context).changeFocus();
        },
        onSubmit: (value) {
          // setState(() {});
          RegisterCubit.get(context).changeFocus();
        },
        controller: userController,
        validator: (value) {
          if (value!.isEmpty) {
            userError = true;
            return "must enter the User Name";
          }
          userError = false;
          return null;
        },
        label: "User",
        prefixIcon: Icons.person,
      );

  Widget passwordTextForm(context) => defaultTextForm(
        focusColor: passError ? const Color(0xFFB00020) : defaultColor,
        unFocusColor: passError ? const Color(0xFFB00020) : Colors.black54,
        focusNode: passFocusNode,
        onTap: () {
          RegisterCubit.get(context).changeFocus();
        },
        onSubmit: (value) {
          RegisterCubit.get(context).changeFocus();
          FocusScope.of(context).unfocus(); // dismiss to keyboard
          if (formKey.currentState!.validate()) {
            RegisterCubit.get(context).postData(
                name: userController.text,
                phone: phoneController.text,
                email: emailController.text,
                password: passController.text);
          }
        },
        controller: passController,
        validator: (value) {
          if (value!.isEmpty) {
            passError = true;
            return "must enter the Password";
          }
          passError = false;
          return null;
        },
        label: "Password",
        prefixIcon: Icons.lock_outline_sharp,
        keyboardType: TextInputType.visiblePassword,
        suffixIcon: isPassword ? Icons.visibility : Icons.visibility_off,
        suffixPressed: () {
          // setState(() {});
          RegisterCubit.get(context).changeFocus();

          if (isPassword) {
            isPassword = false;
          } else {
            isPassword = true;
          }
        },
        isPassword: isPassword,
      );

  Widget emailTextForm(context) => defaultTextForm(
        focusColor: emailError ? const Color(0xFFB00020) : defaultColor,
        unFocusColor: emailError ? const Color(0xFFB00020) : Colors.black54,
        focusNode: emailFocusNode,
        onTap: () {
          RegisterCubit.get(context).changeFocus();

          // setState(() {});
        },
        onSubmit: (value) {
          RegisterCubit.get(context).changeFocus();

          // setState(() {});
        },
        controller: emailController,
        validator: (value) {
          if (value!.isEmpty) {
            emailError = true;
            return "must enter the Email";
          }
          emailError = false;
          return null;
        },
        label: "Email",
        prefixIcon: Icons.email_outlined,
      );

  Widget phoneTextForm(context) => defaultTextForm(
        focusColor: phoneError ? const Color(0xFFB00020) : defaultColor,
        unFocusColor: phoneError ? const Color(0xFFB00020) : Colors.black54,
        focusNode: phoneFocusNode,
        onTap: () {
          RegisterCubit.get(context).changeFocus();
        },
        onSubmit: (value) {
          RegisterCubit.get(context).changeFocus();
        },
        controller: phoneController,
        validator: (value) {
          if (value!.isEmpty) {
            phoneError = true;
            return "must enter the phone";
          }
          phoneError = false;
          return null;
        },
        label: "phone",
        prefixIcon: Icons.phone_outlined,
      );

  Widget RegisterButton(context) => ElevatedButton(
        onPressed: () {
          RegisterCubit.get(context).changeFocus();
          FocusScope.of(context).unfocus(); // dismiss to keyboard

          if (formKey.currentState!.validate()) {
            RegisterCubit.get(context).postData(
              name: userController.text,
              email: emailController.text,
              password: passController.text,
              phone: phoneController.text,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite),
          backgroundColor: defaultColor,
          foregroundColor: Colors.white,
        ),
        child: const Text("Register"),
      );
}
