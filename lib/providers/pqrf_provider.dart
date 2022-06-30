import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

import 'package:pqrf_coonfie/models/matter_model.dart';
import 'package:pqrf_coonfie/models/municipio_model.dart';
import 'package:pqrf_coonfie/types/types.dart';
import 'package:pqrf_coonfie/utils/utils.dart';

class PQRSFProvider extends ChangeNotifier {
  PQRSFProvider() {
    bringMunicipio();
  }

  // Domains of Web Services
  final String _baseUrl = '10.10.2.75';
  final String _baseTokenDynamics = 'login.microsoftonline.com';
  final String _baseDevelopmentDynamics = 'coonfiedesarrollo.crm2.dynamics.com';

  // Method to bring data
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

  void bringMatter() async {
    final response = await _getJsonData(
        "PQRSF_back/serviciosparametria/TraerAsuntoTipos",
        {'AsuntoTipo': typeRequest});

    final List<DropdownMenuItem<String>> data = matterFromJson(response)
        .map(
          (e) => DropdownMenuItem<String>(
            value: e.asuntoTipoNom,
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
    TypeSelect('PETICIÓN', 'PETICIÓN'),
    TypeSelect('QUEJA', 'QUEJA'),
    TypeSelect('RECLAMO', 'RECLAMO'),
    TypeSelect('SUGERENCIA', 'SUGERENCIA'),
    TypeSelect('FELICITACIONES', 'FELICITACIONES'),
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

  String _documentNumber = '';
  String _fullName = '';
  String _phone = '';
  String _email = '';
  String _city = '';
  String _address = '';
  String _typeRequest = '';
  String _matter = '';
  String _medium = '';
  String _description = '';
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

  set documentNumber(String value) {
    _documentNumber = value;
    notifyListeners();
  }

  set fullName(String value) {
    _fullName = value;
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

  set filingNumber(String value) {
    _filingNumber = value;
    notifyListeners();
  }

  // Getters
  String get documentNumber => _documentNumber;
  String get fullName => _fullName;
  String get phone => _phone;
  String get email => _email;
  String get city => _city;
  String get address => _address;
  String get typeRequest => _typeRequest;
  String get matter => _matter;
  String get medium => _medium;
  String get description => _description;
  String get filingNumber => _filingNumber;

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
    Map body = {};
    /* final request = http.MultipartRequest('POST', uri, );
    request.headers['Content-Type'] = 'application/json';
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token'; */

    if (menu != 3) {
      if (picker != null) {
        int i = 0;
        picker!.files.forEach((element) async {
          Uint8List fileBytes = element.bytes!;
          String fileName = element.name;

          /*  final file =
              http.MultipartFile.fromBytes('file$i$fileName', fileBytes); 
          request.files.add(file);*/
          i++;
        });
      }
      if (menu == 1) {
        final Map name = extractName(fullName);
        body = {
          "API_Field_TipoDocumento": 'CC',
          "API_Field_Identificacion": documentNumber,

          "API_Field_FirstName": name['API_Field_FirstName'],
          "API_Field_SecondName": name['API_Field_SecondName'],
          "API_Field_LastName": name['API_Field_LastName'],
          "API_Field_SecondLastName": name['API_Field_SecondLastName'],

          "API_Field_Phone": '',
          "API_Field_Mobile": phone,
          "API_Field_Email": email,
          "API_Field_MedioResp": '134300001', //medium;

          "API_Field_FechaRadicacion": getDate(),
          "API_Field_FechaRemision": getDate(add: 1),
          "API_Field_FechaLimiteResp": getDate(add: 2),

          "API_Field_Asunto": matter, // Agradecimiento
          "API_Field_State": "1",
          "API_Field_Channel": "2",
          "API_Field_Oficina": "134300010",
          "API_Field_Partner": "true",
          "API_Field_Prioridad": "134300002",
          "API_Field_TipoSolicitud": typeRequest,
        };
        /* request.fields['API_Field_TipoDocumento'] = 'CC';
        request.fields['API_Field_Identificacion'] = documentNumber;

        request.fields['API_Field_FirstName'] = name['API_Field_FirstName'];
        request.fields['API_Field_SecondName'] = name['API_Field_SecondName'];
        request.fields['API_Field_LastName'] = name['API_Field_LastName'];
        request.fields['API_Field_SecondLastName'] =
            name['API_Field_SecondLastName'];

        request.fields['API_Field_Phone'] = telephone;
        request.fields['API_Field_Mobile'] = phone;
        request.fields['API_Field_Email'] = email;
        request.fields['API_Field_MedioResp'] = '134300001'; //medium;

        request.fields['API_Field_FechaRadicacion'] = getDate();
        request.fields['API_Field_FechaRemision'] = getDate(add: 1);
        request.fields['API_Field_FechaLimiteResp'] = getDate(add: 2);

        request.fields['API_Field_Asunto'] = matter; // Agradecimiento
        request.fields['API_Field_State'] = "1";
        request.fields['API_Field_Channel'] = "2";
        request.fields['API_Field_Oficina'] = "134300010";
        request.fields['API_Field_Partner'] = "true";
        request.fields['API_Field_Prioridad'] = "134300002";
        request.fields['API_Field_TipoSolicitud'] = typeRequest; // Felicitación */

        // request.fields['city'] = city;
        // request.fields['address'] = address;
        // request.fields['description'] = description;
      } else {
        body = {
          // No todos los datos deben ser requeridos
          "API_Field_TipoSolicitud": typeRequest,
          "API_Field_Asunto": matter,
          // "description":description,
          "API_Field_Partner": "false",
        };
        /* request.fields['API_Field_TipoSolicitud'] = typeRequest;
        request.fields['API_Field_Asunto'] = matter;
        // request.fields['description'] = description;
        request.fields['API_Field_Partner'] = "false"; */
      }

      // Makes send with a multipart method
      /* final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse); */

      try {
        final response =
            await http.post(uri, body: json.encode(body), headers: {
          "Content-Type": 'application/json',
          "Authorization": "Bearer $token",
        });

        print(response.body);
      } catch (e) {
        print(e.toString());
      }

      return true;
    } else {
      final uri =
          Uri.http(_baseDevelopmentDynamics, 'api/data/v9.2/incidents', {
        '\$select':
            'ticketnumber,ce_fecharadicacionsolicitud,ce_fechalimiterespuesta,_ce_tiposolicitud_value,statuscode,',
        '\$filter': "ticketnumber eq '$filingNumber'",
      });

      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        filingNumber = data['value'][0]['ticketnumber'];
        print(data);
      }

      // fullnameAnswer = data['fullname'];
      /* documentNumberAnswer = data['document_number'];
        typeRequestAnswer = data['type_request'];
        filingDateAnswer = data['filing_date'];
        proccessStateAnswer = data['proccess_state'];
        dateAnswer = data['ce_fecharadicacionsolicitud']; */

      notifyListeners();
      /* } else {
        print("Error has ocurred");
        return false;
      } */
    }

    return true;
  }
}
