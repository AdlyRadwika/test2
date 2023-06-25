import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
    this.length,
    this.allowSpecialChars = false,
    this.keyboardType,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String hint;
  final String label;
  final int? length;
  final bool? allowSpecialChars;
  final bool? enabled;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Example: $hint',
        labelText: label,
      ),
      inputFormatters: allowSpecialChars == true
          ? null
          : [
              FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
            ],
      maxLength: length,
      keyboardType: keyboardType,
      enabled: enabled,
    );
  }
}
