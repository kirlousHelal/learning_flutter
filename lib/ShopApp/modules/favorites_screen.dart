import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:continuelearning/ShopApp/cubit/cubit.dart';
import 'package:continuelearning/ShopApp/cubit/states.dart';
import 'package:continuelearning/ShopApp/models/favorites_get_model.dart';
import 'package:continuelearning/ShopApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.favoritesGetModel != null,
          builder: (context) {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return favoriteBuilder(
                      model: cubit.favoritesGetModel!.data.data[index].product,
                      context: context);
                },
                separatorBuilder: (context, index) => Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                itemCount: cubit.favoritesGetModel?.data.data.length ?? 0);
          },
          fallback: (context) => const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "There is No Favorite Items Added Yet...",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.grey),
              ),
              Icon(
                Icons.category_outlined,
                color: Colors.grey,
                size: 40,
              )
            ],
          )),
        );
      },
    );
  }

  Widget favoriteBuilder({required Product model, required context}) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 120,
                height: 120,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  child: const Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white),
                  ),
                )
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
                    model.name,
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
                      const SizedBox(width: 5),
                      if (model.discount != 0)
                        Text(
                          "${model.oldPrice}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
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
