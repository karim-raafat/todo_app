import 'package:flutter/cupertino.dart';

import '../utils/todo.dart';

class AppProvider extends ChangeNotifier{
  String shownPage = '';
  List<Todo> _allTodos =[];
  List<Todo> _pending = [];
  List<Todo> _done = [];
  List<Todo> _dueToday = [];
  List<Todo> _dueMonth = [];

  List<Todo> get allTodos => _allTodos;
  List<Todo> get pending => _pending;
  List<Todo> get done => _done;
  List<Todo> get dueToday => _dueToday;
  List<Todo> get dueMonth => _dueMonth;
  String month = DateTime.now().toString().split(' ')[0].substring(5,6);


  void addNewTodo(Todo todo){
    allTodos.add(todo);
    pending.add(todo);
    if(todo.dueDate != ''){
      if(todo.dueDate == DateTime.now().toString().split(' ')[0]){
        dueToday.add(todo);
      }
      if(todo.dueDate!.substring(5,6) == month){
        dueMonth.add(todo);
      }
    }
    notifyListeners();
  }

  void markAsDone(Todo todo){
    pending.remove(todo);
    done.add(todo);
    notifyListeners();
  }

  void markAsUndone(Todo todo){
    pending.add(todo);
    done.remove(todo);
    notifyListeners();
  }


  void deleteTodo (Todo todo){
    if (allTodos.contains(todo)) {
      allTodos.remove(todo);
    }

    if (pending.contains(todo)) {
      pending.remove(todo);
    }

    if (done.contains(todo)) {
      done.remove(todo);
    }
    if (dueToday.contains(todo)) {
      dueToday.remove(todo);
    }
    if (dueMonth.contains(todo)) {
      dueMonth.remove(todo);
    }

    notifyListeners();
  }


}