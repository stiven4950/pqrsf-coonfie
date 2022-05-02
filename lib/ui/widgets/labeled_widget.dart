import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/ui/decorations/input_decorations.dart';

class LabeledWidget extends StatelessWidget {
  final String data;
  final String hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int maxLines;

  const LabeledWidget(
    this.data, {
    Key? key,
    required this.hintText,
    required this.validator,
    required this.onChanged,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data, style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 5.0),
          TextFormField(
            style: const TextStyle(fontSize: 14.0),
            cursorColor: Theme.of(context).primaryColor,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authDecoration(
              hintText: hintText,
            ),
            onChanged: onChanged,
            validator: validator,
            maxLines: maxLines,
          ),
        ],
      ),
    );
  }
}

class LabeledSelect extends StatelessWidget {
  final String selected;
  final String data;
  final String hintText;
  final List<DropdownMenuItem<String>> dropdownItems;
  final void Function(String?)? onChanged;

  const LabeledSelect({
    Key? key,
    required this.selected,
    required this.data,
    required this.hintText,
    required this.dropdownItems,
    required this.onChanged,
  }) : super(key: key);

  //----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data, style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 5.0),
          DropdownButtonFormField<String>(
            decoration: InputDecorations.authDecoration(
              hintText: hintText,
            ),
            isExpanded: true,
            value: selected,
            style: const TextStyle(fontSize: 14.0, color: Colors.black),
            iconEnabledColor: Theme.of(context).primaryColor,
            icon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(Icons.keyboard_arrow_down),
            ),
            iconSize: 24,
            elevation: 16,
            onChanged: onChanged,
            items: dropdownItems,
          ),
        ],
      ),
    );
  }
}
