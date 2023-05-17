import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  const TextInputField(
      {super.key, required this.hintText, required this.textInputType});

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
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        // FilteringTextInputFormatter.allow(),
      ],
    );
  }
}
