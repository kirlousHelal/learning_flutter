import 'package:continuelearning/ShopApp/cubit/cubit.dart';
import 'package:continuelearning/ShopApp/modules/search_screen.dart';
import 'package:continuelearning/ShopApp/shared/components/components.dart';
import 'package:continuelearning/ShopApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // ShopCubit.get(context).setUP();

    return BlocProvider(
      create: (context) => ShopCubit()..setUP(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Shop APP"),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(
                        context: context,
                        widget: SearchScreen(cubit: cubit),
                      );
                    },
                    icon: const Icon(Icons.search))
              ],
              // backgroundColor: Colors.grey[400],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.grey[300],
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              selectedItemColor: defaultColor,
              items: cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                // cubit.changeBottomItem(index);
                cubit.pageController.jumpToPage(index);
              },
            ),
            body: PageView(
              physics: const BouncingScrollPhysics(),
              controller: cubit.pageController,
              onPageChanged: (index) {
                cubit.changeBottomItem(index);
              },
              children: cubit.bottomScreens,
            ),

            // body: IndexedStack(
            //   index: cubit.currentIndex,
            //   children: cubit.bottomScreens,
            // ),
          );
        },
      ),
    );
  }
}
