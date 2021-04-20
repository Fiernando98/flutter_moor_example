import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_moor_example/databases/moor_database.dart';
import 'package:flutter_moor_example/main.dart';
import 'package:provider/provider.dart';

class CreateStudentsPage extends StatefulWidget {
  @override
  _CreateStudentsPageState createState() => _CreateStudentsPageState();
}

class _CreateStudentsPageState extends State<CreateStudentsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _firstName = "", _lastName = "";

  Widget _inputFirstName() {
    return Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
            keyboardType: TextInputType.name,
            initialValue: _firstName,
            onSaved: (val) => _firstName = val ?? "",
            style: TextStyle(fontWeight: FontWeight.bold),
            validator: (val) =>
                val == null || val.isEmpty ? "Invalid first name" : null,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                prefixIcon:
                    Icon(Icons.person, color: Theme.of(context).accentColor),
                labelText: "First Name",
                hintText: "Enter your first name")));
  }

  Widget _inputLastName() {
    return Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
            keyboardType: TextInputType.name,
            initialValue: _lastName,
            onSaved: (val) => _lastName = val ?? "",
            style: TextStyle(fontWeight: FontWeight.bold),
            validator: (val) =>
                val == null || val.isEmpty ? "Invalid last name" : null,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                prefixIcon:
                    Icon(Icons.person, color: Theme.of(context).accentColor),
                labelText: "Last Name",
                hintText: "Enter your last name")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Student")),
        body: Form(
            key: _formKey,
            child: ListView(
                padding: EdgeInsets.only(bottom: 60),
                children: [_inputFirstName(), _inputLastName()])),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _saveStudent,
            label: Text("Finish"),
            icon: Icon(Icons.done)));
  }

  void _saveStudent() async {
    try {
      final FormState? formData = _formKey.currentState;
      if (formData != null && formData.validate()) {
        formData.save();
        final SchoolDatabase database =
            Provider.of<SchoolDatabase>(context, listen: false);
        final Student student = Student(
            id: await database.studentDao.getNextID(),
            firstName: _firstName,
            lastName: _lastName);
        await database.studentDao.insertStudent(student);
        snackMessage(message: "Successfully Created Student", context: context);
        Navigator.of(context).maybePop();
      } else {
        snackMessage(message: "Form Error", context: context, isError: true);
      }
    } catch (error) {
      snackMessage(
          message: "${error.toString()}", context: context, isError: true);
    }
  }
}
