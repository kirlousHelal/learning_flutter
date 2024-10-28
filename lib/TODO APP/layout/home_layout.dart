import 'package:continuelearning/TODO%20APP/cubit/cubit.dart';
import 'package:continuelearning/TODO%20APP/cubit/states.dart';
import 'package:continuelearning/TODO%20APP/modules/archiveTasks_screen.dart';
import 'package:continuelearning/TODO%20APP/modules/doneTasks_screen.dart';
import 'package:continuelearning/TODO%20APP/modules/newTasks_screen.dart';
import 'package:continuelearning/TODO%20APP/shared/components/components_shared.dart';
import 'package:continuelearning/TODO%20APP/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  /// The Attributes Of the Class......
  var context;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  int currentIndex = 0;
  bool isBottomSheetShown = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Database? database;

  /// ............................................

  /// Constructor
  HomeLayout({super.key}) {
    print("I am The Constructor ");
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      NewTasks(this),
      DoneTasks(this),
      ArchiveTasks(this)
    ];
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: BlocConsumer<TodoCubit, TodoAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            this.context = context;
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                title: const Text(
                  "TODO APP",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  TodoCubit.get(context).showBottomSheet();
                  if (isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      insertToDatabase(context, titleController.text,
                              timeController.text, dateController.text)
                          .then((value) {
                        Navigator.pop(context);
                        cleanData();
                        isBottomSheetShown = false;
                      });
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) {
                            return Container(
                              color: Colors.grey[200],
                              padding: const EdgeInsets.all(20),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    textField_titleTask(),
                                    const SizedBox(height: 15),
                                    textField_timeTask(context),
                                    const SizedBox(height: 15),
                                    textField_dateTask(context),
                                    const SizedBox(height: 15),
                                    buttonClose(context)
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                        .closed
                        .then((value) {
                          isBottomSheetShown = false;
                          TodoCubit.get(context).showBottomSheet();
                        });
                    isBottomSheetShown = true;
                  }
                },
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(isBottomSheetShown ? Icons.add : Icons.edit),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Tasks"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.done_outline), label: "Done"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: "Archive"),
                ],
                currentIndex: currentIndex,
                onTap: (value) {
                  currentIndex = value;
                  TodoCubit.get(context).chageScreenBottomBar();
                },
                backgroundColor: Colors.grey[100],
              ),
              body: screens[currentIndex],
            );
          }),
    );
  }

  Widget textField_titleTask() => defaultTextField(
      prefixIcon: Icons.title,
      titleController: titleController,
      validateError: "Must Enter The Title",
      keyboardType: TextInputType.text,
      label: "Title");

  Widget textField_timeTask(context) => defaultTextField(
        prefixIcon: Icons.timer_outlined,
        titleController: timeController,
        validateError: "Must Enter The Time",
        keyboardType: TextInputType.none,
        label: "Time",
        onTap: () {
          showTimePicker(context: context, initialTime: TimeOfDay.now())
              .then((value) {
            timeController.text = value!.format(context).toString();
          });
        },
      );

  Widget textField_dateTask(context) => defaultTextField(
        prefixIcon: Icons.date_range_outlined,
        titleController: dateController,
        validateError: "Must Enter The Date",
        keyboardType: TextInputType.none,
        label: "Date",
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2026))
              .then((value) {
            dateController.text = DateFormat.yMMMd().format(value!).toString();
          });
        },
      );

  Widget buttonClose(context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      child: MaterialButton(
        child: const Text(
          "Close",
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          Navigator.pop(context);
          isBottomSheetShown = false;
        },
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase(
      "todo 2.db",
      version: 1,
      onCreate: (db, version) {
        print("Database Created");
        db
            .execute(
                "CREATE TABLE tasks(id INTEGER primary key,title text,time text ,date text,status text)")
            .then((value) {
          print("Table Created");
        });
      },
      onOpen: (db) async {
        print("Database Opened");
        await getDataFromDatabase(db);
      },
    );
  }

  void cleanData() {
    dateController.text = "";
    timeController.text = "";
    titleController.text = "";
  }

  Future insertToDatabase(context, title, time, date) async {
    database
        ?.rawInsert(
            'Insert Into tasks(title,time,date,status) Values("$title","$time","$date","New Task")')
        .then((value) {
      print("$value is inserted Successfully");
      TodoCubit.get(context).insertToDatabase();
      getDataFromDatabase(database, context);
    });
  }

  Future getDataFromDatabase(database, [context = null]) async {
    print("I am here in the get data");
    database.rawQuery("SELECT * FROM tasks").then(
      (value) {
        print("Get The Data Successfully");
        print("The Data are : $value");
        tasks = value;
        if (context != null) TodoCubit.get(context).getFromDatabase();
      },
    );
  }

  Future updateDatabase(
      BuildContext context, String statusValue, int id) async {
    database?.rawUpdate(
      "UPDATE tasks SET status = ? WHERE id = ?",
      [statusValue, id], // Provide the values as a list
    ).then((value) {
      print("$value row(s) updated successfully");
      TodoCubit.get(context).updateToDatabase();
      getDataFromDatabase(database, context);
    }).catchError((error) {
      print("Error updating database: $error");
    });
  }

  Future<void> deleteFromDatabase(BuildContext context, int id) async {
    await database?.rawDelete(
      "DELETE FROM tasks WHERE id = ?",
      [id], // Pass the id as an argument
    ).then((value) {
      print("$value deleted successfully from the database");

      // Notify the cubit about the deletion
      TodoCubit.get(context).deleteToDatabase();

      // Fetch the updated data from the database
      getDataFromDatabase(database, context);
    }).catchError((error) {
      print("Error while deleting task: $error");
    });
  }
}
