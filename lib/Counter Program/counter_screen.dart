import 'package:continuelearning/Counter%20Program/cubit/cubit.dart';
import 'package:continuelearning/Counter%20Program/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Center(
                  child: Text(
                "Welcome Back Kiro",
                style: TextStyle(color: Colors.white),
              )),
              backgroundColor: Colors.blueAccent,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    color: Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            count++;
                            CounterCubit.get(context).plus();
                          },
                          child: const Text("Plus",
                              style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 15),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 35.0),
                          child: Text(
                            "$count",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 15),
                        TextButton(
                            onPressed: () {
                              count--;
                              CounterCubit.get(context).minus();
                            },
                            child: const Text("Mins",
                                style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    count = 0;
                    CounterCubit.get(context).reset();
                  },
                  color: Colors.blueAccent,
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
