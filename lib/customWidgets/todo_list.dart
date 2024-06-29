import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/app_provider.dart';

import '../utils/todo.dart';

class TodoList extends StatefulWidget {
  final List<Todo> todos;

  const TodoList({super.key, required this.todos});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return (widget.todos.isEmpty)
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'You have no tasks here!',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          )
        : Consumer<AppProvider>(
          builder: (context,appProvider,child) => ListView.builder(
            itemCount: widget.todos.length,
            itemBuilder: (context, index) => ListTile(
              leading: Checkbox(
                activeColor: Colors.pinkAccent,
                value: widget.todos[index].isDone,
                onChanged: (value) {
                  widget.todos[index].isDone = value!;
                  if (value!) {
                    appProvider.markAsDone(widget.todos[index]);
                  } else {
                    appProvider.markAsUndone(widget.todos[index]);
                  }


                },
              ),
              title: Text(widget.todos[index].name),
              subtitle: Text(widget.todos[index].dueDate.toString()),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                          'Are you sure you want to delete this Task?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.grey),
                            )),
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              appProvider.deleteTodo(widget.todos[index]);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

        );
  }
}
