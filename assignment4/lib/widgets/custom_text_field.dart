import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final bool obscure;
  final Widget? suffix;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final VoidCallback? onDone;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.obscure = false,
    this.suffix,
    this.focusNode,
    this.nextFocus,
    this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscure,
      keyboardType: keyboardType,
      textInputAction: inputAction,
      validator: validator,
      onFieldSubmitted: (_) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        } else {
          onDone?.call();
          FocusScope.of(context).unfocus();
        }
      },
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
