import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/provider/todos.dart';
import 'package:todo/viewmodel/cubit/todo_cubit.dart';
import 'package:todo/widget/todo_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  final Todo? todo;

  const AddTodoDialogWidget({super.key, this.todo});
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  @override
  void initState() {
    if (widget.todo != null) {
      print(widget.todo!.title);
      print("object");
      title = widget.todo!.title;
      description = widget.todo!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Todo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            TodoFormWidget(
              title: title,
              description: description,
              todo: widget.todo,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: () {
                if (widget.todo == null) {
                  BlocProvider.of<TodoCubit>(
                    context,
                  ).addTodo(Todo(
                      createdTime: DateTime.now(),
                      title: title,
                      id: 0,
                      description: description));
                } else {
                  BlocProvider.of<TodoCubit>(context).edit(widget.todo!
                      .copyWith(title: title, description: description));
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}
