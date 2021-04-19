import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_moor_example/data/moor_database.dart';
import 'package:flutter_moor_example/new_task_input_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tasks'),
        ),
        body: Column(children: <Widget>[
          Expanded(child: _buildTaskList(context)),
          NewTaskInput()
        ]));
  }

  StreamBuilder<List<Task>> _buildTaskList(BuildContext context) {
    final AppDatabase database =
        Provider.of<AppDatabase>(context, listen: true);
    return StreamBuilder(
        stream: database.watchAllTasks(),
        builder: (context, AsyncSnapshot<List<Task>> snapshot) {
          final List<Task> tasks = snapshot.data ?? [];
          return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                final Task itemTask = tasks[index];
                return _buildListItem(itemTask, database);
              });
        });
  }

  Widget _buildListItem(Task itemTask, AppDatabase database) {
    return ListTile(
        title: Text(itemTask.name),
        onTap: () async => await database.deleteTask(itemTask));
  }
}
