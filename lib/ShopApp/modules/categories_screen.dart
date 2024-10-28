import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:continuelearning/ShopApp/cubit/cubit.dart';
import 'package:continuelearning/ShopApp/cubit/states.dart';
import 'package:continuelearning/ShopApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoryModel != null,
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async {
                cubit.getCategoryData();
              },
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return categoryItemBuilder(cubit: cubit, index: index);
                },
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: Colors.grey,
                ),
                itemCount: cubit.categoryModel!.data!.data.length,
              ),
            );
          },
          fallback: (context) =>
              Center(child: CircularProgressIndicator(color: defaultColor)),
        );
      },
    );
  }

  Widget categoryItemBuilder({required cubit, required index}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
                "${cubit.categoryModel?.data?.data[index]?.image}"),
            fit: BoxFit.cover,
            height: 120,
            width: 120,
          ),
          const SizedBox(width: 15),
          Text(
            "${cubit.categoryModel?.data?.data[index]?.name}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
