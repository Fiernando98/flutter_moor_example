import 'package:flutter_moor_example/translates/translates.dart';

class LanguageEs extends Translates {
  @override
  String get students => "Estudiantes";

  @override
  String get addStudent => "Agregar Estudiante";

  @override
  String get firstName => "Nombre";

  @override
  String get enterFirstName => "Introduce tu Nombre";

  @override
  String get invalidFirstName => "Nombre Inválido";

  @override
  String get lastName => "Apellido";

  @override
  String get enterLastName => "Introduce tu Apellido";

  @override
  String get invalidLastName => "Apellido Inválido";

  @override
  String get formError => "Error en Formulario";

  @override
  String get finish => "Finalizar";

  @override
  String get successfullyCreatedStudent => "Estudiante Creado Exitosamente";
}
