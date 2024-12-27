import 'package:flutter/material.dart';

TextField customTextField(TextEditingController controller, String labelText,
    {bool? numerical}) {
  numerical ??= false;
  return TextField(
    controller: controller,
    keyboardType: numerical ? TextInputType.number : TextInputType.text,
    decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)))),
  );
}
