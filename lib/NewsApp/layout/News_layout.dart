import 'package:continuelearning/NewsApp/cubit/cubit.dart';
import 'package:continuelearning/NewsApp/cubit/states.dart';
import 'package:continuelearning/NewsApp/modules/search_screen.dart';
import 'package:continuelearning/NewsApp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("News App"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    navigateTo(context: context, widget: SearchScreen());
                  },
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 15),
                  child: IconButton(
                    icon: const Icon(Icons.brightness_4_outlined),
                    onPressed: () {
                      NewsCubit.get(context).changeModeApp();
                    },
                  ),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: NewsCubit.get(context).currentIndex,
              items: NewsCubit.get(context).bottomItems,
              onTap: (index) {
                NewsCubit.get(context).changeBottomNav(index);
              },
            ),
            body: NewsCubit.get(context)
                .screens[NewsCubit.get(context).currentIndex],
          );
        });
  }
}
