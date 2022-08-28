import 'package:flutter/cupertino.dart';
import 'package:todo/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Buy Food 😋',
      description: '''- Eggs
- Milk
- Bread
- Water''',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Plan family trip to Norway',
      description: '''- Rent some hotels
- Rent a car
- Pack suitcase''',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the Dog 🐕',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Plan Jacobs birthday party 🎉🥳',
    ),
  ];
  void addToList(String title, String description) {
    _todos.add(Todo(
      createdTime: DateTime.now(),
      title: title,
      description: description,
    ));
    notifyListeners();
  }

  void edit(String id, Todo todo) {
    var index = _todos.indexWhere((element) => element.id == id);
    _todos[index] = todo;
    notifyListeners();
  }

  void delete(String id) {
    _todos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();
}
