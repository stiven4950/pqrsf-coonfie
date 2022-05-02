import 'package:flutter/material.dart';

import 'package:pqrf_coonfie/types/types.dart';

class PQRSFProvider extends ChangeNotifier {
  // Document Type
  static List<TypeSelect> documentTypeM = [
    TypeSelect('Seleccione...', ''),
    TypeSelect('CÉDULA DE CIUDADANÍA', 'C'),
    TypeSelect('CÉDULA DE EXTRANJERÍA', 'E'),
    TypeSelect('NIT', 'N'),
    TypeSelect('PASAPORTE', 'P'),
    TypeSelect('REGISTRO CIVIL', 'R'),
    TypeSelect('TARJETA DE IDENTIDAD', 'T'),
  ];

  final List<DropdownMenuItem<String>> documentTypeItems = documentTypeM
      .map(
        (e) => DropdownMenuItem<String>(
          value: e.value,
          child: Text(e.key),
        ),
      )
      .toList();

  // City
  static List<TypeSelect> cityM = [
    TypeSelect('Seleccione...', ''),
    TypeSelect('NEIVA CENTRO', 'NC'),
    TypeSelect('PITALITO CENTRO', 'PC'),
    TypeSelect('CAMPOALEGRE HUILA', 'CH'),
  ];

  final List<DropdownMenuItem<String>> cityItems = cityM
      .map(
        (e) => DropdownMenuItem<String>(
          value: e.value,
          child: Text(e.key),
        ),
      )
      .toList();

  // Agency
  static List<TypeSelect> agencyM = [
    TypeSelect('Seleccione...', ''),
    TypeSelect('AGENCIA A', 'A'),
    TypeSelect('AGENCIA B', 'B'),
    TypeSelect('AGENCIA C', 'C'),
  ];

  final List<DropdownMenuItem<String>> agencyItems = agencyM
      .map(
        (e) => DropdownMenuItem<String>(
          value: e.value,
          child: Text(e.key),
        ),
      )
      .toList();

  // Request
  static List<TypeSelect> requestM = [
    TypeSelect('Seleccione...', ''),
    TypeSelect('PETICIÓN', 'P'),
    TypeSelect('QUEJA', 'Q'),
    TypeSelect('RECLAMO', 'R'),
    TypeSelect('SUGERENCIA', 'S'),
    TypeSelect('FELICITACIONES', 'F'),
  ];

  final List<DropdownMenuItem<String>> requestItems = requestM
      .map(
        (e) => DropdownMenuItem<String>(
          value: e.value,
          child: Text(e.key),
        ),
      )
      .toList();

  // Matter
  static List<TypeSelect> matterM = [
    TypeSelect('Seleccione...', ''),
    TypeSelect('CRÉDITO FINANCIERO', 'F'),
    TypeSelect('CRÉDITO NORMAL', 'N'),
    TypeSelect('PRÉSTAMO', 'P'),
  ];

  final List<DropdownMenuItem<String>> matterItems = matterM
      .map(
        (e) => DropdownMenuItem<String>(
          value: e.value,
          child: Text(e.key),
        ),
      )
      .toList();

  // medium
  static List<TypeSelect> mediumM = [
    TypeSelect('Seleccione...', ''),
    TypeSelect('CORREO ELECTRÓNICO', 'C'),
    TypeSelect('FÍSICO', 'F'),
  ];

  final List<DropdownMenuItem<String>> mediumItems = mediumM
      .map(
        (e) => DropdownMenuItem<String>(
          value: e.value,
          child: Text(e.key),
        ),
      )
      .toList();

  String _documentType = '';
  String documentNumber = '';
  String fullName = '';
  String telephone = '';
  String phone = '';
  String email = '';
  String city = '';
  String address = '';
  String agency = '';
  bool asociated = false;
  String typeRequest = '';
  String matter = '';
  String medium = '';
  String description = '';
  String regExpDocumentType = '';

  final GlobalKey<FormState> _formKey = GlobalKey();
  get formKey => _formKey;
  bool isValidForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  void validateForm() {
    _formKey.currentState!.validate();
  }

  set documentType(String value) {
    _documentType = value;
    switch (value) {
      case 'C':
        regExpDocumentType = r'\b\d{8,10}\b';
        break;
      case "E":
        regExpDocumentType = r'\b\d{6,7}\b';
        break;
      case "N":
        regExpDocumentType = r'\b(\d{9}-\d{1})\b';
        break;
      case "P":
        regExpDocumentType = r'\b[a-zA-Z]{2}\d{6}\b';
        break;
      case "R":
      case "T":
        regExpDocumentType = r'\b\d{10}\b';
        break;
      default:
        regExpDocumentType = r'\b\d{10}\b';
    }
    notifyListeners();
    print(regExpDocumentType);
  }
}
