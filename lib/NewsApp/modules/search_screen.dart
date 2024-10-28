import 'package:continuelearning/NewsApp/cubit/cubit.dart';
import 'package:continuelearning/NewsApp/cubit/states.dart';
import 'package:continuelearning/NewsApp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> list = NewsCubit.get(context).search;
        list = list.where((item) => item['urlToImage'] != null).toList();
        print(list.length);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(
                    color: NewsCubit.get(context).appMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  controller: NewsCubit.get(context).searchController,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearchData(value: value);
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text("Search"),
                    prefixIcon: Icon(Icons.search_rounded),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: articleBuilder(
                    list: list,
                    isSearch: true,
                    function: () {
                      return NewsCubit.get(context).getSearchData(
                        value: NewsCubit.get(context).searchController.text,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
