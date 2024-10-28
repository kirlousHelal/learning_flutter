import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:continuelearning/ShopApp/cubit/cubit.dart';
import 'package:continuelearning/ShopApp/cubit/states.dart';
import 'package:continuelearning/ShopApp/modules/login/login_screen.dart';
import 'package:continuelearning/ShopApp/shared/components/components.dart';
import 'package:continuelearning/ShopApp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var nameFocusNode = FocusNode();
  var emailFocusNode = FocusNode();
  var phoneFocusNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userDataModel;
        if (model != null) {
          nameController.text = model!.data!.name;
          emailController.text = model!.data!.email;
          phoneController.text = model!.data!.phone;
        }

        return ConditionalBuilder(
            condition: model != null,
            builder: (context) {
              return Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          defaultTextForm(
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Must Enter The Name";
                              }
                              return null;
                            },
                            focusNode: nameFocusNode,
                            onTap: () => ShopCubit.get(context).changeFocus(),
                            onSubmit: (value) =>
                                ShopCubit.get(context).changeFocus(),
                            label: "User Name",
                            prefixIcon: Icons.person,
                            keyboardType: TextInputType.name,
                            focusColor: defaultColor,
                          ),
                          const SizedBox(height: 30),
                          defaultTextForm(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Must Enter The Email";
                              }
                              return null;
                            },
                            onTap: () => ShopCubit.get(context).changeFocus(),
                            onSubmit: (value) =>
                                ShopCubit.get(context).changeFocus(),
                            label: "Email Address",
                            prefixIcon: Icons.email_outlined,
                            focusNode: emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            focusColor: defaultColor,
                          ),
                          const SizedBox(height: 30),
                          defaultTextForm(
                            controller: phoneController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Must Enter The Phone";
                              }
                              return null;
                            },
                            onTap: () => ShopCubit.get(context).changeFocus(),
                            onSubmit: (value) =>
                                ShopCubit.get(context).changeFocus(),
                            focusNode: phoneFocusNode,
                            label: "Phone",
                            prefixIcon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            focusColor: defaultColor,
                          ),
                          const SizedBox(height: 50),
                          if (state is ShopPutProfileDataLoadingSate)
                            LinearProgressIndicator(color: defaultColor),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFocus();
                              FocusScope.of(context)
                                  .unfocus(); // dismiss to keyboard

                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).putProfileData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size.fromWidth(double.maxFinite),
                              backgroundColor: defaultColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Update Data"),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              CacheHelper.removeData(key: 'login');
                              CacheHelper.removeData(key: 'token');
                              navigateTo(
                                  context: context,
                                  widget: LoginScreen(),
                                  removeAllPrevious: true);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size.fromWidth(double.maxFinite),
                              backgroundColor: defaultColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("LogOut"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
