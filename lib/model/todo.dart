// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  static int counter=0;
  DateTime createdTime;
  String title;
  String? id;
  String description;
  bool isDone;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
     
    this.isDone = false,
  }){
    this.id=(++counter).toString();
  }
  

  Todo copyWith({
    DateTime? createdTime,
    String? title,
    String? id,
    String? description,
    bool? isDone,
  }) {
    return Todo(
      createdTime: createdTime ?? this.createdTime,
      title: title ?? this.title,
    
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}
