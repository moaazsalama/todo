// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  int id;
  String description;
  bool isDone;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
     required this.id,
    this.isDone = false,
  });
  

  Todo copyWith({
    DateTime? createdTime,
    String? title,
    int? id,
    String? description,
    bool? isDone,
  }) {
    return Todo(
      createdTime: createdTime ?? this.createdTime,
      title: title ?? this.title,
      id: id??this.id,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}
