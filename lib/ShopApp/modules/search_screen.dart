import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:continuelearning/ShopApp/cubit/cubit.dart';
import 'package:continuelearning/ShopApp/cubit/states.dart';
import 'package:continuelearning/ShopApp/models/search_model.dart';
import 'package:continuelearning/ShopApp/shared/components/components.dart';
import 'package:continuelearning/ShopApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  final ShopCubit cubit;
  SearchScreen({super.key, required this.cubit});

  var searchController = TextEditingController();
  var searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Search",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultTextForm(
                  controller: searchController,
                  validator: (value) {
                    return null;
                  },
                  label: "Search",
                  prefixIcon: Icons.search_rounded,
                  focusNode: searchFocus,
                  onTap: () => cubit.changeFocus(),
                  onSubmit: (v) => cubit.changeFocus(),
                  onChange: (value) {
                    cubit.postSearchData(value: value);
                  },
                  focusColor: defaultColor,
                ),
                const SizedBox(height: 20),
                if (state is ShopPostSearchDataLoadingSate)
                  LinearProgressIndicator(color: defaultColor),
                const SizedBox(height: 30),
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.searchModel != null,
                    builder: (context) {
                      return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: searchBuilder(
                                model: cubit.searchModel!.data!.data![index],
                                context: context,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                          itemCount:
                              cubit.searchModel?.data?.data?.length ?? 0);
                    },
                    fallback: (context) => Container(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget searchBuilder({required Product model, required context}) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage("${model.image}"),
                width: 120,
                height: 120,
              ),
            ],
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.1,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${model.price}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .postFavoriteData(productId: model.id);
                          },
                          icon: Icon(
                            ShopCubit.get(context).favorites[model.id] ?? false
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: ShopCubit.get(context).favorites[model.id] ??
                                    false
                                ? defaultColor
                                : null,
                            size: 20,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
