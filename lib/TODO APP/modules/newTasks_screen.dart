import 'package:continuelearning/TODO%20APP/cubit/cubit.dart';
import 'package:continuelearning/TODO%20APP/cubit/states.dart';
import 'package:continuelearning/TODO%20APP/shared/components/components_shared.dart';
import 'package:continuelearning/TODO%20APP/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasks extends StatelessWidget {
  late var home;

  NewTasks(home) {
    this.home = home;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoAppStates>(
        listener: (BuildContext context, TodoAppStates state) {},
        builder: (BuildContext context, TodoAppStates state) {
          List<Map> newTasks = tasks
              .where((element) => element["status"] == "New Task")
              .toList();

          if (newTasks.isEmpty) return emptyScreen();

          return ListView.separated(
              itemBuilder: (context, index) => taskBuilder(
                  context: home.context,
                  model: newTasks[index],
                  home: this.home),
              separatorBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
              itemCount: newTasks.length);
        });
  }
}
