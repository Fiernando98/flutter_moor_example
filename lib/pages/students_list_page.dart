import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_moor_example/databases/moor_database.dart';
import 'package:flutter_moor_example/pages/create/create_students_page.dart';
import 'package:flutter_moor_example/translates/translates.dart';
import 'package:provider/provider.dart';

class StudentsListPage extends StatefulWidget {
  @override
  _StudentsListPageState createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  StreamBuilder<List<Student>> _buildStudentsList() {
    final SchoolDatabase database =
        Provider.of<SchoolDatabase>(context, listen: true);
    return StreamBuilder(
        stream: database.studentDao.watchAllStudents(),
        builder: (context, AsyncSnapshot<List<Student>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          final List<Student> listData = snapshot.data ?? [];
          if (listData.isEmpty)
            return Center(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("No Students Available")));
          return ListView.builder(
              itemCount: listData.length,
              itemBuilder: (_, index) {
                final Student item = listData[index];
                return _buildListStudentItem(
                    title: "${item.firstName} ${item.lastName}",
                    onTap: () async =>
                        await database.studentDao.deleteStudent(item));
              });
        });
  }

  Widget _buildListStudentItem(
      {required final String title, final GestureTapCallback? onTap}) {
    return ListTile(title: Text(title), onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("${Translates.of(context)?.students}")),
        body: _buildStudentsList(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateStudentsPage()));
            },
            label: Text("${Translates.of(context)?.addStudent}"),
            icon: Icon(Icons.add)));
  }
}
