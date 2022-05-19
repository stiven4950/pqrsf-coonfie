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

  final String _baseUrl = '10.10.2.75';
  Future<String> _getJsonData(
    String endpoint, [
    Map<String, dynamic>? queryParameters,
  ]) async {
    final uri = Uri.http(_baseUrl, endpoint, queryParameters);
    final response = await http.get(uri);
    return response.body;
  }

  // ---------------------------------------------------------------------------
  // Peticiones a Web Service

  void bringMunicipio() async {
    final response =
        await _getJsonData("PQRSF_back/serviciosparametria/traermunicipios");

    /* final List<DropdownMenuItem<String>> data = municipiosFromJson(response)
        .map(
          (e) => DropdownMenuItem<String>(
            value: e.municipioId,
            child: Text(e.municipioDepartamento),
          ),
        )
        .toList(); */

    cityItems.addAll(municipiosFromJson(response));
    notifyListeners();
  }

  void bringAgency() async {
    final response =
        await _getJsonData("PQRSF_back/serviciosparametria/Traeragencias");

    final List<DropdownMenuItem<String>> data = agencyFromJson(response)
        .map(
          (e) => DropdownMenuItem<String>(
            value: e.agenciaId.toString(),
            child: Text(e.agenciaNombre),
          ),
        )
        .toList();

    agencyItems.addAll(data);
    notifyListeners();
  }

  void bringMatter() async {
    final response = await _getJsonData(
        "PQRSF_back/serviciosparametria/TraerAsuntoTipos",
        {'AsuntoTipo': typeRequest});

    final List<DropdownMenuItem<String>> data = matterFromJson(response)
        .map(
          (e) => DropdownMenuItem<String>(
            value: e.asuntoTipoId,
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
  /* List<DropdownMenuItem<String>> cityItems = [
    const DropdownMenuItem<String>(
      value: '',
      child: Text('Seleccione'),
    ),
  ]; */

  List<Municipios> cityItems = [];

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
  String _documentNumber = '';
  String _fullName = '';
  String _telephone = '';
  String _phone = '';
  String _email = '';
  String _city = '';
  String _address = '';
  String _agency = '';
  String _asociated = "0";
  String _typeRequest = '';
  String _matter = '';
  String _medium = '';
  String _description = '';
  String _regExpDocumentType = r'^(\d{4,10})$';
  String _filingNumber = '';

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
  // Setters

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

  set documentNumber(String value) {
    _documentNumber = value;
    notifyListeners();
  }

  set fullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  set telephone(String value) {
    _telephone = value;
    notifyListeners();
  }

  set phone(String value) {
    _phone = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set city(String value) {
    _city = value;
    notifyListeners();
  }

  set address(String value) {
    _address = value;
    notifyListeners();
  }

  set agency(String value) {
    _agency = value;
    notifyListeners();
  }

  set typeRequest(String value) {
    _typeRequest = value;
    notifyListeners();
  }

  set matter(String value) {
    _matter = value;
    notifyListeners();
  }

  set medium(String value) {
    _medium = value;
    notifyListeners();
  }

  set description(String value) {
    _description = value;
    notifyListeners();
  }

  set regExpDocumentType(String value) {
    _regExpDocumentType = value;
    notifyListeners();
  }

  set filingNumber(String value) {
    _filingNumber = value;
    notifyListeners();
  }

  set asociated(String value) {
    _asociated = value;
    notifyListeners();
  }

  // Getters
  String get documentType => _documentType;
  String get documentNumber => _documentNumber;
  String get fullName => _fullName;
  String get telephone => _telephone;
  String get phone => _phone;
  String get email => _email;
  String get city => _city;
  String get address => _address;
  String get agency => _agency;
  String get typeRequest => _typeRequest;
  String get matter => _matter;
  String get medium => _medium;
  String get description => _description;
  String get regExpDocumentType => _regExpDocumentType;
  String get filingNumber => _filingNumber;
  String get asociated => _asociated;

  // Process Data
  void sendData() {}

  // RESPUESTA
  String filingNumberAnswer = 'CGK-754875-1AY589';
  String fullnameAnswer = 'OMAR STIVEN RIVERA CALDERÓN';
  String documentNumberAnswer = '1083931052';
  String typeRequestAnswer = 'QUEJA';
  String filingDateAnswer = '12/03/2022';
  String proccessStateAnswer = 'RESUELTO';
  String dateAnswer = '04/05/2022';
}
