import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/models/agency_model.dart';
import 'package:pqrf_coonfie/models/matter_model.dart';
import 'package:pqrf_coonfie/models/municipio_model.dart';
import 'package:http/http.dart' as http;

import 'package:pqrf_coonfie/types/types.dart';

class PQRSFProvider extends ChangeNotifier {
  PQRSFProvider() {
    bringMunicipio();
    bringAgency();
  }

  final String _baseUrl = 'cushyrifle.backendless.app';
  Future<String> _getJsonData(
    String endpoint, [
    Map<String, dynamic>? queryParameters,
  ]) async {
    final uri = Uri.https(_baseUrl, endpoint, queryParameters);
    final response = await http.get(uri);
    return response.body;
  }

  // ---------------------------------------------------------------------------
  // Peticiones a Web Service

  void bringMunicipio() async {
    final response = await _getJsonData("api/data/city", {"pageSize": '100'});

    final List<DropdownMenuItem<String>> data = municipiosFromJson(response)
        .map(
          (e) => DropdownMenuItem<String>(
            value: e.municipioId,
            child: Text(e.municipioDepartamento),
          ),
        )
        .toList();

    cityItems.addAll(data);
    notifyListeners();
  }

  void bringAgency() async {
    final response = await _getJsonData("api/data/agency", {"pageSize": '100'});

    final List<DropdownMenuItem<String>> data = agencyFromJson(response)
        .map(
          (e) => DropdownMenuItem<String>(
            value: e.objectId,
            child: Text(e.agenciaNombre),
          ),
        )
        .toList();

    agencyItems.addAll(data);
    notifyListeners();
  }

  void bringMatter() async {
    final response = await _getJsonData("api/data/matter",
        {'where': "asuntoTipo='$typeRequest'", "pageSize": '100'});

    final List<DropdownMenuItem<String>> data = matterFromJson(response)
        .map(
          (e) => DropdownMenuItem<String>(
            value: e.objectId,
            child: Text(e.asuntoTipoNom),
          ),
        )
        .toList();

    matter = '';

    matterItems = [
      const DropdownMenuItem<String>(
        value: '',
        child: Text('Seleccione'),
      ),
    ];
    matterItems.addAll(data);
    notifyListeners();
  }

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
  List<DropdownMenuItem<String>> cityItems = [
    const DropdownMenuItem<String>(
      value: '',
      child: Text('Seleccione'),
    ),
  ];

  // Asociated
  final List<TypeSelect> asociatedValues = [
    TypeSelect("No", "0"),
    TypeSelect("Sí", "1"),
  ];

  // Agency

  final List<DropdownMenuItem<String>> agencyItems = [
    const DropdownMenuItem<String>(
      value: '',
      child: Text('Seleccione'),
    ),
  ];

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

  List<DropdownMenuItem<String>> matterItems = [
    const DropdownMenuItem<String>(
      value: '',
      child: Text('Seleccione'),
    ),
  ];

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
  String _asociated = "0";
  String typeRequest = '';
  String matter = '';
  String medium = '';
  String description = '';
  String regExpDocumentType = r'^(\d{4,10})$';

  // Upload variable
  FilePickerResult? result;
  // ---------------------------------------------------------------------------
  // Validaciones del formulario

  final GlobalKey<FormState> _formKey = GlobalKey();
  get formKey => _formKey;
  bool isValidForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  void validateForm() {
    _formKey.currentState!.validate();
  }

  // ---------------------------------------------------------------------------
  // Getters y Setters

  set documentType(String value) {
    _documentType = value;
    switch (value) {
      case 'C':
        regExpDocumentType = r'^(\d{4,10})$';
        break;
      case "E":
        regExpDocumentType = r'^(\d{6,7})$';
        break;
      case "N":
        regExpDocumentType = r'^(\d{9}-\d{1})$';
        break;
      case "P":
        regExpDocumentType = r'^([a-zA-Z]{2}\d{6})$';
        break;
      case "R":
      case "T":
        regExpDocumentType = r'^(\d{10})$';
        break;
      default:
        regExpDocumentType = r'^(\d{4,10})$';
    }
    notifyListeners();
  }

  String get asociated => _asociated;

  set asociated(String value) {
    _asociated = value;
    notifyListeners();
  }
}
