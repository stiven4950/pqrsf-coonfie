import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:pqrf_coonfie/models/filling_model.dart';

import 'package:pqrf_coonfie/models/models.dart';
import 'package:pqrf_coonfie/types/types.dart';

class PQRSFProvider extends ChangeNotifier {
  PQRSFProvider() {
    bringMunicipio();
  }

  // Domains of Web Services
  final String _baseUrl = 'pqrsf.herokuapp.com';

  // Method to bring data
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
    final response = await _getJsonData("/api/city");

    cityItems.addAll(citiesFromJson(response));
    notifyListeners();
  }

  void bringMatter() async {
    final response = await _getJsonData(
      "/api/matter/" + typeRequest,
    );

    final List<DropdownMenuItem<String>> data = matterFromJson(response)
        .map(
          (e) => DropdownMenuItem<String>(
            value: e.id,
            child: Text(e.name),
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

  List<City> cityItems = [];

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
    TypeSelect('CORREO ELECTRÓNICO', 'Correo'),
    TypeSelect('FÍSICO', 'Fisico'),
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
      _baseUrl,
      '/api/auth/login-uid',
    );

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "uid": "62e88f894aa7bd143d96ff9e",
          "password": "654321##@#",
        }),
      );

      final data = json.decode(response.body);

      return data['token'];
    } catch (e) {
      return 'Falló la petición al sitio';
    }
  }

  // Process Data
  Future<bool> registerIdentifiedUser() async {
    final token = await _obtainToken();
    final uri = Uri.https(_baseUrl, '/api/filling/identified');
    Map body = {};

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
    body = {
      "document_number": documentNumber,
      "fullname": fullName,
      "phone": phone,
      "email": email,
      "city": city,
      "address": address,
      "matter": matter,
      "medium": medium,
      "description": description,
    };

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          "Content-Type": 'application/json',
          "x-token": token,
        },
      );
      final dataEncoded = json.decode(response.body);
      filingNumberAnswer = dataEncoded['ticket'];
    } catch (e) {
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> registerAnonimousUser() async {
    final token = await _obtainToken();
    final uri = Uri.https(_baseUrl, '/api/filling/anonimous');
    Map body = {};

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

    body = {
      "matter": matter,
      "description": description,
    };

    try {
      await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          "Content-Type": 'application/json',
          "x-token": token,
        },
      );
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> consult() async {
    final uri = Uri.https(_baseUrl, '/api/filling/' + filingNumber);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final filling = Filling.fromRawJson(response.body);

      fullnameAnswer = filling.user.fullname.toUpperCase();
      documentNumberAnswer = filling.user.documentNumber.toString();
      typeRequestAnswer = filling.matter.name;
      filingDateAnswer = filling.fillingDate.toIso8601String();
      filingNumberAnswer = filingNumber;
      proccessStateAnswer = filling.state;
      dateAnswer = /* filling.responseDate != null
          ? filling.responseDate!.toIso8601String()
          :  */
          'AÚN NO SE HA DEFINIDO FECHA';
    }
    notifyListeners();
    return true;
  }
}
