import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, 
    required this.textController,
    FocusNode? focusNode,
    required this.labelText,
    required this.iconData,
    required this.validator,
    required this.keyboardType,
  }) : _focusNode = focusNode;

  final TextEditingController textController;
  final FocusNode? _focusNode;
  final String labelText;
  final IconData iconData;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      onEditingComplete: () => _focusNode?.requestFocus(),
    );
  }
}