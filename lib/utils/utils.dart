Map extractName(String fullname) {
  final List arrayName = fullname.split(' ');
  final filtered = arrayName.where((e) => e.isNotEmpty).toList();

  return filtered.length == 3
      ? {
          "API_Field_FirstName": filtered[0],
          "API_Field_SecondName": '',
          "API_Field_LastName": filtered[1],
          "API_Field_SecondLastName": filtered[2],
        }
      : {
          "API_Field_FirstName": filtered[0],
          "API_Field_SecondName": filtered[1],
          "API_Field_LastName": filtered[2],
          "API_Field_SecondLastName": filtered[3],
        };
}

String getDate({int add = 0}) {
  final time = DateTime.now().add(Duration(days: add));
  return "${time.month < 10 ? '0${time.month}' : time.month}/${time.day < 10 ? '0${time.day}' : time.day}/${time.year}";
}
