import 'package:continuelearning/TODO APP/layout/home_layout.dart';
import 'package:flutter/material.dart';

Widget defaultTextField(
    {required TextEditingController titleController,
    required String validateError,
    required TextInputType keyboardType,
    required String label,
    Function()? onTap,
    required IconData prefixIcon}) {
  return TextFormField(
    onTap: onTap,
    keyboardType: keyboardType,
    controller: titleController,
    validator: (value) {
      if (value!.isEmpty) {
        return validateError;
      }
      return null;
    },
    decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        label: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
  );
}

Widget taskBuilder(
        {required Map model, required context, required HomeLayout home}) =>
    Dismissible(
      key: Key("kiro"),
      onDismissed: (direction) {
        home.deleteFromDatabase(context, model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              radius: 30,
              child: Text(
                model['time'],
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    model['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    model['date'],
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  home.updateDatabase(context, "New Task", model['id']).then(
                    (value) {
                      print("Transfered to New Tasks");
                    },
                  );
                },
                icon: const Icon(
                  Icons.task,
                  color: Colors.blueAccent,
                )),
            const SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {
                  home.updateDatabase(context, "Done Task", model['id']).then(
                    (value) {
                      print("Transfered to Done Tasks");
                    },
                  );
                },
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            const SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {
                  home
                      .updateDatabase(context, "Archive Task", model['id'])
                      .then(
                    (value) {
                      print("Transerfed to Archive tasks  ");
                    },
                  );
                },
                icon: const Icon(
                  Icons.archive,
                  color: Colors.grey,
                ))
          ],
        ),
      ),
    );

Widget emptyScreen() {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          color: Colors.grey,
          size: 60,
        ),
        Text(
          "There is No Tasks Yet...",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
