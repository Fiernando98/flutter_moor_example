import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_moor_example/data/moor_database.dart';
import 'package:provider/provider.dart';

class NewTaskInput extends StatefulWidget {
  @override
  _NewTaskInputState createState() => _NewTaskInputState();
}

class _NewTaskInputState extends State<NewTaskInput> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[_buildTextField()]));
  }

  Expanded _buildTextField() {
    return Expanded(
        child: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Task Name'),
            onSubmitted: (inputName) async {
              try {
                final AppDatabase database =
                    Provider.of<AppDatabase>(context, listen: false);
                final Task task =
                    Task(id: await database.getNextID(), name: inputName);
                await database.insertTask(task);
                resetValuesAfterSubmit();
              } catch (error) {
                print(error.toString());
              }
            }));
  }

  void resetValuesAfterSubmit() {
    setState(() {
      controller.clear();
    });
  }
}
