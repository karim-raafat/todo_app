import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/customWidgets/sidebar_menu.dart';
import 'package:todo_app/customWidgets/todo_list.dart';
import 'package:todo_app/provider/app_provider.dart';

import '../utils/todo.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController? dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('Todo System Management'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              // backgroundColor: Colors.pinkAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              // isScrollControlled: true,
              builder: (context) => SafeArea(child: StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.pinkAccent,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'New Task',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Theme(
                                data: ThemeData(
                                    primaryColor: Colors.pinkAccent,
                                    primaryColorDark: Colors.pinkAccent,
                                    inputDecorationTheme:
                                        const InputDecorationTheme(
                                            labelStyle:
                                                TextStyle(color: Colors.pink),
                                            focusColor: Colors.pinkAccent,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.pinkAccent),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.pinkAccent),
                                            ))),
                                child: TextField(
                                  controller: nameController,
                                  cursorColor: Colors.pinkAccent,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.edit_note_outlined,
                                        color: Colors.pinkAccent,
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                      labelText: 'Task Name'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Theme(
                                data: ThemeData(
                                    primarySwatch: Colors.pink,
                                    primaryColor: Colors.pinkAccent,
                                    primaryColorDark: Colors.pinkAccent,
                                    inputDecorationTheme:
                                        const InputDecorationTheme(
                                            labelStyle:
                                                TextStyle(color: Colors.pink),
                                            focusColor: Colors.pinkAccent,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.pinkAccent),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.pinkAccent),
                                            ))),
                                child: TextField(
                                  cursorColor: Colors.pinkAccent,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    labelText: 'Due Date (Optional)',
                                    prefixIcon: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                  controller: dateController,
                                  readOnly: true,
                                  onTap: () {
                                    selectDate(context);
                                  },
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                TextButton(
                                  onPressed: () {
                                    if (nameController.text == '') {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Please write a name for the Task',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color: Colors.pinkAccent),
                                                )),
                                          ],
                                        ),
                                      );
                                    } else {
                                      if (dateController == null) {
                                        appProvider.addNewTodo(Todo(
                                            name: nameController.text,
                                            isDone: false));
                                        nameController.clear();
                                        Navigator.pop(context);
                                      } else {
                                        appProvider.addNewTodo(Todo(
                                            name: nameController.text,
                                            isDone: false,
                                            dueDate: dateController?.text));
                                        nameController.clear();
                                        dateController?.clear();
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.pinkAccent),
                                  child: const Text(
                                    'Add Task',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )));
        },
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add),
      ),
      drawer: NavMenu(
        appProvider: appProvider,
      ),
      body: Consumer<AppProvider>(
        builder:(context,appProvider,child) => TodoList(
          todos: (appProvider.shownPage == 'All Tasks')
              ? appProvider.allTodos
              : (appProvider.shownPage == 'Pending Tasks')
                  ? appProvider.pending
                  : (appProvider.shownPage == 'Done Tasks')
                      ? appProvider.done
                      : (appProvider.shownPage == 'Due Today')
                          ? appProvider.dueToday
                          : appProvider.dueMonth
        ),
      ),
    );
  }

  //[All Tasks,Pending Tasks,Done Tasks,Due Today,Due This Month]

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100),
        builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
                dialogTheme: DialogTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                colorScheme: const ColorScheme.light(
                  primary: Colors.pinkAccent,
                )),
            child: child!));
    setState(() {
      dateController!.text = picked.toString().split(' ')[0];
    });
  }
}
