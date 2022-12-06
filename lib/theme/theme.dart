import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/pages/to_do_list_page_widget.dart';

class ThemeToDoList extends StatelessWidget {
  const ThemeToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF0C6980),
        buttonTheme: ButtonThemeData(buttonColor: theme.primaryColor),
      ),
      home: const TodoListPage(),
    );
  }
}
