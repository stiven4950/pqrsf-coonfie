import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/models/agency_model.dart';
import 'package:pqrf_coonfie/models/matter_model.dart';
import 'package:pqrf_coonfie/models/municipio_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'package:pqrf_coonfie/types/types.dart';

class PQRSFProvider extends ChangeNotifier {
  PQRSFProvider() {
    bringMunicipio();
    bringAgency();
  }

  final String _baseUrl = '10.10.2.75';
  final String _baseTokenDynamics = 'login.microsoftonline.com';
  final String _baseDevelopmentDynamics = 'coonfiedesarrollo.crm2.dynamics.com';

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
        child: Text('Seleccione...'),
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
      child: Text('Seleccione...'),
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
      child: Text('Seleccione...'),
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
  FilePickerResult? picker;
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

  // RESPUESTA
  String filingNumberAnswer = 'CGK-754875-1AY589';
  String fullnameAnswer = 'OMAR STIVEN RIVERA CALDERÓN';
  String documentNumberAnswer = '1083931052';
  String typeRequestAnswer = 'QUEJA';
  String filingDateAnswer = '12/03/2022';
  String proccessStateAnswer = 'RESUELTO';
  String dateAnswer = '04/05/2022';

  bool _thereIsAnswer = false;
  set thereIsAnswer(bool value) {
    _thereIsAnswer = value;
    notifyListeners();
  }

  bool get thereIsAnswer => _thereIsAnswer;

  // Obtain token
  Future<String> _obtainToken() async {
    final uri = Uri.https(
      _baseTokenDynamics,
      'ac6b4b78-6fab-4fa5-8d7e-cc1075ab6fb3/oauth2/token',
    );
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "client_Id": "4372bc64-9fcd-4ff7-b27e-e01d625e1f63",
          "client_Secret": "BOh7Q~kWP3JKz6LMyWqJtVtztLAVCqAYydiRF",
          "resource": "https://coonfiedesarrollo.crm2.dynamics.com/",
          "grant_type": "client_credentials",
        },
      );

      final data = json.decode(response.body);

      return data['access_token'];
    } catch (e) {
      print(e.toString());
    }
    return 'Falló la petición al sitio';
  }

  // Process Data

  Future<bool> sendData(int menu) async {
    /*
      // 
      var formData = FormData.fromMap({
      "client_Id": "4372bc64-9fcd-4ff7-b27e-e01d625e1f63",
      "client_Secret": "BOh7Q~kWP3JKz6LMyWqJtVtztLAVCqAYydiRF",
      "resource": "https://coonfiedesarrollo.crm2.dynamics.com/",
      "grant_type": "client_credentials",
    });

    try {
      var response = await Dio().post(
        'https://login.microsoftonline.com/ac6b4b78-6fab-4fa5-8d7e-cc1075ab6fb3/oauth2/token',
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print(response.data);
    } catch (e) {
      print(e.toString());
    } */

    final token = await _obtainToken();
    final uri =
        Uri.https(_baseDevelopmentDynamics, 'api/data/v9.2/API_REQUEST');
    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';

    if (menu != 3) {
      if (picker != null) {
        int i = 0;
        picker!.files.forEach((element) async {
          Uint8List fileBytes = element.bytes!;
          String fileName = element.name;

          final file =
              http.MultipartFile.fromBytes('file$i$fileName', fileBytes);
          request.files.add(file);
          i++;
        });
      }
      if (menu == 1) {
        request.fields['API_Field_TipoDocumento'] = 'CC';
        request.fields['API_Field_Identificacion'] = documentNumber;

        request.fields['API_Field_FirstName'] = fullName;
        request.fields['API_Field_SecondName'] = fullName;
        request.fields['API_Field_LastName'] = fullName;
        request.fields['API_Field_SecondLastName'] = fullName;

        request.fields['API_Field_Phone'] = telephone;
        request.fields['API_Field_Mobile'] = phone;
        request.fields['API_Field_Email'] = email;
        request.fields['API_Field_MedioResp'] = '134300001'; //medium;

        request.fields['API_Field_FechaRadicacion'] =
            DateTime.now().toIso8601String();
        request.fields['API_Field_FechaLimiteResp'] =
            DateTime.now().toIso8601String();
        request.fields['API_Field_FechaRemision'] =
            DateTime.now().toIso8601String();

        request.fields['API_Field_Asunto'] = matter; // Agradecimiento
        request.fields['API_Field_State'] = "1";
        request.fields['API_Field_Channel'] = "2";
        request.fields['API_Field_Oficina'] = "134300010";
        request.fields['API_Field_Partner'] = "true";
        request.fields['API_Field_Prioridad'] = "134300002";
        request.fields['API_Field_TipoSolicitud'] = typeRequest; // Felicitación

        request.fields['city'] = city;
        request.fields['address'] = address;
        request.fields['description'] = description;
      } else {
        request.fields['API_Field_TipoSolicitud'] = typeRequest;
        request.fields['API_Field_Asunto'] = matter;
        request.fields['description'] = description;
        request.fields['API_Field_Partner'] = "false";
      }

      // Makes send
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
    } else {
      final uri = Uri.http('data.com', 'consult/state', {
        'type_request': typeRequest,
        'matter': matter,
      });
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        filingNumber = data['filing_number'];
        fullnameAnswer = data['fullname'];
        documentNumberAnswer = data['document_number'];
        typeRequestAnswer = data['type_request'];
        filingDateAnswer = data['filing_date'];
        proccessStateAnswer = data['proccess_state'];
        dateAnswer = data['date_answer'];

        notifyListeners();
      } else {
        print("Error has ocurred");
      }
    }

    return true;
  }
}
