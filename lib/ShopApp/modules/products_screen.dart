import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:continuelearning/ShopApp/cubit/cubit.dart';
import 'package:continuelearning/ShopApp/cubit/states.dart';
import 'package:continuelearning/ShopApp/models/category_model.dart';
import 'package:continuelearning/ShopApp/models/home_model.dart';
import 'package:continuelearning/ShopApp/shared/components/components.dart';
import 'package:continuelearning/ShopApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  // ScrollController to maintain the scroll position
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopPostFavoriteDataSuccessSate) {
          if (state.favoritesPostModel?.status == false) {
            showToast(
                message: state.favoritesPostModel!.message ?? "",
                backgroundColor: ToastColors.error);
          } else {
            showToast(
                message: state.favoritesPostModel!.message ?? "",
                backgroundColor: ToastColors.success);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoryModel != null,
          builder: (context) =>
              homeBuilder(cubit!.homeModel, cubit.categoryModel!.data, context),
          fallback: (context) =>
              Center(child: CircularProgressIndicator(color: defaultColor)),
        );
      },
    );
  }

  // Use this to tell Flutter that the widget should be kept alive
  @override
  bool get wantKeepAlive => true;

  Widget homeBuilder(HomeModel? model, CategoryData? categoryModel, context) =>
      RefreshIndicator(
        onRefresh: () async {
          ShopCubit.get(context).getHomeData();
          ShopCubit.get(context).getCategoryData();
        },
        child: SingleChildScrollView(
          // controller: _scrollController, // Attach the scroll controller
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: model?.data?.banners
                    .map((e) => Image(image: NetworkImage('${e?.image}')))
                    .toList(),
                options: CarouselOptions(
                    height: 250,
                    enableInfiniteScroll: true,
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.easeInOutCirc,
                    autoPlayInterval: const Duration(seconds: 3),
                    initialPage: 0,
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    scrollPhysics: const BouncingScrollPhysics()),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            categoryBuilder(categoryModel.data[index]),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemCount: categoryModel!.data.length,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "New Products",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              Container(
                color: Colors.grey[400],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1 / 1.61,
                  children: List.generate(
                    model!.data!.products.length,
                    (index) => productBuilder(
                        model: model.data!.products[index]!,
                        index: index,
                        context: context),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget productBuilder(
      {required ProductModel model, required index, required context}) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200,
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
          Padding(
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
          )
        ],
      ),
    );
  }

  Widget categoryBuilder(DataCategoryModel? model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${model?.image}'),
          fit: BoxFit.cover,
          height: 120,
          width: 120,
        ),
        Container(
          width: 120,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            "${model?.name}",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
