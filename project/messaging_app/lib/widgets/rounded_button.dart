import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
  });

  final String title;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(30),
        color: color ?? Theme.of(context).colorScheme.primary,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 220,
          height: 48,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
