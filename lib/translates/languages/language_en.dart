import 'package:flutter_moor_example/translates/translates.dart';

class LanguageEn extends Translates {
  @override
  String get students => "Students";

  @override
  String get addStudent => "Add Student";

  @override
  String get firstName => "First Name";

  @override
  String get enterFirstName => "Enter your First Name";

  @override
  String get invalidFirstName => "Invalid First Name";

  @override
  String get lastName => "Last Name";

  @override
  String get enterLastName => "Enter your Last Name";

  @override
  String get invalidLastName => "Invalid Last Name";

  @override
  String get formError => "Form Error";

  @override
  String get finish => "Finish";

  @override
  String get successfullyCreatedStudent => "Successfully Created Student";
}
