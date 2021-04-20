import 'package:flutter/cupertino.dart';

Iterable<String> get languagesSupported => ['en', 'es'];

abstract class Translates {
  static Translates? of(BuildContext context) {
    return Localizations.of<Translates>(context, Translates);
  }

  String get students;

  String get addStudent;

  String get firstName;

  String get enterFirstName;

  String get invalidFirstName;

  String get lastName;

  String get enterLastName;

  String get invalidLastName;

  String get formError;

  String get finish;

  String get successfullyCreatedStudent;
}
