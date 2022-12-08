import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController tasksController = TextEditingController();

  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: tasksController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Add task',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(14),
                      backgroundColor: const Color(0xFF20ADD0),
                    ),
                    onPressed: () {
                      String text = tasksController.text;
                      setState(() {
                        tasks.add(text);
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  for (String task in tasks)
                    ListTile(
                      title: Text(task),
                    ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text('Do you have 0 tasks to do'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF20ADD0),
                      padding: const EdgeInsets.all(14),
                    ),
                    child: const Text('Clean All'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
