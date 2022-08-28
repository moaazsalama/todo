import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/page/home_page.dart';
import 'package:todo/provider/database_controller.dart';
import 'package:todo/provider/todos.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await DatabaseController.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Todo App';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TodosProvider()..getData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primarySwatch: Colors.pink,
            scaffoldBackgroundColor: Color(0xFFf6f5ee),
          ),
          home: HomePage(),
        ),
      );
}
