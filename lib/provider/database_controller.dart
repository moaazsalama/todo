import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo.dart';
//CRUD
//Create Read Update Delete
class DatabaseController {
  static Database? _db;
  static Future<void> init() async {
    _db = await openDatabase("${await getDatabasesPath()}/todo.db", version: 1,
        onCreate: (db, version) {
      db.execute(
          'CREATE TABLE todos (id INTEGER PRIMARY KEY, title TEXT,description TEXT, time DATETIME, isDone TEXT)');
    });
  }
//id title description time isDone


  Future<List<Todo>> getTodos(bool isDone) async {
    var query = await _db!.query('todos', where: 'isDone=?', whereArgs: [isDone?1:0]);
    var list = query
        .map((row) {
           return Todo(
            id: row['id'] as int,
            createdTime: DateTime.parse(row['time'].toString()),
            title: row['title'] as String,
            description: row['description'] as String,
            isDone: int.parse(row['isDone'].toString()) == 1 ? true : false);
        })
        .toList();
    return list;
  }
  Future<int> delete(int id)async{
   return await _db!.delete('todos',where: 'id=?',whereArgs: [id]);
  }
 Future<void> edit(Todo todo)async{
   await _db!.update('todos', {
      
      'title': todo.title,
      'description': todo.description,
      'time': todo.createdTime.toIso8601String(),
      'isDone': todo.isDone
    },where: "id=?",whereArgs: [todo.id]);
  }
 Future<int> append(Todo todo) async{
   return await _db!.insert('todos', {
      'title': todo.title,
      'description': todo.description,
      'time': todo.createdTime.toIso8601String(),
      'isDone': todo.isDone
    });
  }
}
