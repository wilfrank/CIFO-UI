import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatelessWidget {
  const CustomPasswordFormField({super.key, 
    required this.textController,
    FocusNode? focusNodeEmail,
    required this.labelText,
    required this.iconData,
    required this.validator,
    required this.keyboardType,
    required this.obscureText,
    required this.suffixIcon,
  }) : _focusNode = focusNodeEmail;

  final TextEditingController textController;
  final FocusNode? _focusNode;
  final String labelText;
  final IconData iconData;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconButton suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(iconData),
        suffixIcon: suffixIcon,
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