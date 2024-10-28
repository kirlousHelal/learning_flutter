import 'package:continuelearning/TODO%20APP/cubit/cubit.dart';
import 'package:continuelearning/TODO%20APP/cubit/states.dart';
import 'package:continuelearning/TODO%20APP/shared/components/components_shared.dart';
import 'package:continuelearning/TODO%20APP/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTasks extends StatelessWidget {
  var home;

  DoneTasks(home) {
    this.home = home;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoAppStates>(
        listener: (BuildContext context, TodoAppStates state) {},
        builder: (BuildContext context, TodoAppStates state) {
          List<Map> doneTasks = tasks
              .where((element) => element["status"] == "Done Task")
              .toList();

          if (doneTasks.isEmpty) return emptyScreen();

          return ListView.separated(
              itemBuilder: (context, index) => taskBuilder(
                  context: home.context, model: doneTasks[index], home: home),
              separatorBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
              itemCount: doneTasks.length);
        });
  }
}
