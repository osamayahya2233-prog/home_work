import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class PasswordField extends StatefulWidget {

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?) validator;

  const PasswordField({
    super.key,
    required this.controller,
    required this.validator,
    this.focusNode,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      label: 'كلمة المرور',
      obscure: _obscure,
      keyboardType: TextInputType.visiblePassword,
      inputAction: TextInputAction.done,
      validator: widget.validator,
      suffix: IconButton(
        icon: Icon(
          _obscure ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() => _obscure = !_obscure);
        },
      ),
    );
  }
}
