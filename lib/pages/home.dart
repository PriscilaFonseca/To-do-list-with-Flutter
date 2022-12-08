import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/pages/to_do_list_page_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodoListPage());
  }
}
