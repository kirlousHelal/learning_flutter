import 'package:continuelearning/NewsApp/cubit/cubit.dart';
import 'package:continuelearning/NewsApp/cubit/states.dart';
import 'package:continuelearning/NewsApp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> list = NewsCubit.get(context).sports;
        list = list.where((item) => item['urlToImage'] != null).toList();
        return articleBuilder(
          list: list,
          function: () {
            return NewsCubit.get(context).getSportsData();
          },
        );
      },
    );
  }
}
