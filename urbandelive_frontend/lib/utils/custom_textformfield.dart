import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final Icon icon;
  const TextInputField(
      {super.key, required this.hintText, required this.textInputType, required this.icon});

  @override
  Widget build(BuildContext context) {
    final inputborder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: inputborder,
        focusedBorder: inputborder,
        enabledBorder: inputborder,
        fillColor: Colors.green,
        prefixIcon: icon,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      inputFormatters: const <TextInputFormatter>[
        // FilteringTextInputFormatter.digitsOnly,
        // FilteringTextInputFormatter.allow(),
      ],
    );
  }
}