import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_moor_example/databases/moor_database.dart';
import 'package:flutter_moor_example/main.dart';
import 'package:flutter_moor_example/translates/translates.dart';
import 'package:provider/provider.dart';

class CreateRatingPage extends StatefulWidget {
  final int idStudent;

  CreateRatingPage({required this.idStudent});

  @override
  _CreateRatingPageState createState() => _CreateRatingPageState();
}

class _CreateRatingPageState extends State<CreateRatingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _rating = "";

  Widget _inputRating() {
    return Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            initialValue: _rating,
            onSaved: (val) => _rating = val ?? "",
            style: TextStyle(fontWeight: FontWeight.bold),
            validator: (val) => val == null ||
                    val.isEmpty ||
                    double.tryParse(val) == null ||
                    double.parse(val) < 0 ||
                    double.parse(val) > 100
                ? "${Translates.of(context)?.invalidRating}"
                : null,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon:
                    Icon(Icons.school, color: Theme.of(context).accentColor),
                labelText: "${Translates.of(context)?.rating}",
                hintText: "${Translates.of(context)?.enterRating}")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("${Translates.of(context)?.addRating}")),
        body: Form(
            key: _formKey,
            child: ListView(
                padding: EdgeInsets.only(bottom: 60),
                children: [_inputRating()])),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _saveRating,
            label: Text("${Translates.of(context)?.finish}"),
            icon: Icon(Icons.done)));
  }

  void _saveRating() async {
    try {
      final FormState? formData = _formKey.currentState;
      if (formData != null && formData.validate()) {
        formData.save();
        final SchoolDatabase database =
            Provider.of<SchoolDatabase>(context, listen: false);
        final Rating rating = Rating(
            id: await database.ratingDao.getNextID(),
            idStudent: widget.idStudent,
            rating: double.tryParse(_rating) ?? 0,
            dateTimeCreated: DateTime.now().toLocal());
        await database.ratingDao.insertRating(rating);
        snackMessage(
            message: "${Translates.of(context)?.successfullyCreatedRating}",
            context: context);
        Navigator.of(context).maybePop();
      } else {
        snackMessage(
            message: "${Translates.of(context)?.formError}",
            context: context,
            isError: true);
      }
    } catch (error) {
      snackMessage(
          message: "${error.toString()}", context: context, isError: true);
    }
  }
}
