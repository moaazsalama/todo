import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/provider/todos.dart';
import 'package:todo/viewmodel/cubit/todo_cubit.dart';
import 'package:todo/widget/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  final bool isDone;

  const TodoListWidget({super.key, required this.isDone});
  @override
  Widget build(BuildContext context) {
    var todoCubit = BlocProvider.of<TodoCubit>(context);
    todoCubit.fetchTodos(isDone);
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoLoaded) {
          if (state is TodoAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Todo Added"),
                duration: Duration(milliseconds: 500),
              ),
            );
          } else if (state is TodoUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Todo Updated"),
                duration: Duration(milliseconds: 500),
              ),
            );
          } else if (state is TodoDelete) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Todo Deleted"),
                duration: Duration(milliseconds: 500),
              ),
            );
          } else if (state is TodoCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Todo Completed"),
                duration: Duration(milliseconds: 500),
              ),
            );
          }else if (state is TodoUnCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Todo UnCompleted"),
                duration: Duration(milliseconds: 500),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Todo Loaded"),
                duration: Duration(milliseconds: 500),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        if (state is TodoLoaded) {
          if (todoCubit.todos.isEmpty) {
            return Center(
              child: Text(
                'No todos.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: todoCubit.todos.length,
            itemBuilder: (context, index) {
              final todo = todoCubit.todos[index];

              return TodoWidget(todo: todo);
            },
          );
        } else if (state is TodoLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
