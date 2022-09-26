import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/provider/database_controller.dart';

import '../../model/todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  List<Todo> todos = [];
  TodoCubit() : super(TodoInitial());
  fetchTodos(bool completed) async{
    emit( TodoLoading());
  var list = await DatabaseController().getTodos(completed);
  print(list);
  todos = list;
  Future.delayed(Duration(seconds: 2),(){
    emit(TodoLoaded());
  });
  
  }
  addTodo(Todo todo) async{
    var i = await DatabaseController().append(todo);
    todos.add(todo.copyWith(id: i));
    emit(TodoAdded());
  }
  edit(Todo todo) async{
    await DatabaseController().edit(todo);
    var index = todos.indexWhere((element) => element.id == todo.id);
    todos[index] = todo;
    emit(TodoUpdated());
  }
  delete(int id) async{
    await DatabaseController().delete(id);
    todos.removeWhere((element) => element.id == id);
    emit(TodoDelete());
  }
  completeTodo(int id,bool value) async{
    var todo=todos.firstWhere((element) => element.id == id);
   await DatabaseController().edit(todo.copyWith(isDone: value));
   var index =todos.indexWhere((element) => element.id==id);
   todos[index]=todo.copyWith(isDone: value);
   if(value){
     emit(TodoCompleted());
   }
   else{
     emit(TodoUnCompleted());
   }
  }

}
