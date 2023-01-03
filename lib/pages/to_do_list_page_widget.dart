import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/tasks.dart';
import 'package:lista_de_tarefas/widgets/tasksListItem.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController tasksController = TextEditingController();

  final List<Tasks> _tasks = [];
  Tasks? deletedTasks;
  int? deletedTasksPosition;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: tasksController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF20ADD0),
                            ),
                          ),
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
                        setState(
                          () {
                            Tasks newTasks = Tasks(
                              title: text,
                              dateTime: DateTime.now(),
                            );
                            _tasks.add(newTasks);
                          },
                        );
                        tasksController.clear();
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
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Tasks task in _tasks)
                        TasksListItemWidget(
                          tasks: task,
                          onDelete: () => onDelete(task),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('You have ${_tasks.length} pending tasks'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () => showDeleteDialog(),
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
      ),
    );
  }

  showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clean Everthing?'),
        content: const Text('Are you sure you want to clear everything?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteEverything();
            },
            child: const Text(
              'Clean',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w300, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void deleteEverything() {
    setState(
      () {
        _tasks.clear();
      },
    );
  }

  onDelete(Tasks tasks) {
    deletedTasks = tasks;
    deletedTasksPosition = _tasks.indexOf(tasks);
    setState(
      () {
        _tasks.remove(tasks);
      },
    );

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Undo',
          textColor: const Color(0xFF20ADD0),
          onPressed: () {
            setState(() {
              _tasks.insert(deletedTasksPosition!, deletedTasks!);
            });
          },
        ),
        content: Text(
          'Task ${tasks.title} removed',
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
    );
  }
}
