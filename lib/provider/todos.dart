  import 'package:flutter/cupertino.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/provider/database_controller.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [
   ];
  Future<void> addToList(String title, String description) async {
    var databaseController = DatabaseController();
    var todo = Todo(createdTime: DateTime.now(), title: title, id: 5,description: description,isDone: false);
   var id = await databaseController.append(Todo(createdTime: DateTime.now(), title: title, id: 5,description: description,isDone: false));
    todo=todo.copyWith(id: id);
     _todos.add(todo);
    notifyListeners();
  }

  Future<void> edit(int id, Todo todo) async {
   await DatabaseController().edit(todo);
    var index = _todos.indexWhere((element) => element.id == id);
    _todos[index] = todo;
    notifyListeners();
  }

  void delete(int id) async{
   await DatabaseController().delete(id);
    _todos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  getData() async {
    var databaseController = DatabaseController();
   var list = await databaseController.getTodos(true);
   list.sort((todo1,todo2){
    if(todo1.createdTime.isBefore(todo2.createdTime)){
      return -1;
    }
    else {
      return 1;
    }
   });
   _todos=list;
   notifyListeners();
  }
}
