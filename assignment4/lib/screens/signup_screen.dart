import 'package:flutter/material.dart';
import '../models/app_localizations.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onChangeLanguage;
  const RegisterScreen({super.key, required this.onChangeLanguage});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  bool _showPassword = false;
  bool _showConfirm = false;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  bool _isValidEmail(String v) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v);
  }

  void _submit(AppLocalizations tr) {
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr.tr('accept_terms'))),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr.tr('success_register'))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: widget.onChangeLanguage,
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                Text(
                  tr.tr('register_title'),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                const SizedBox(height: 40),

                CustomTextField(
                  controller: _email,
                  focusNode: _emailFocus,
                  nextFocus: _passwordFocus,
                  label: tr.tr('email'),
                  keyboardType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.isEmpty) return tr.tr('email_required');
                    if (!_isValidEmail(v)) return tr.tr('email_invalid');
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  controller: _password,
                  focusNode: _passwordFocus,
                  nextFocus: _confirmFocus,
                  label: tr.tr('password'),
                  keyboardType: TextInputType.visiblePassword,
                  inputAction: TextInputAction.next,
                  obscure: !_showPassword,
                  suffix: IconButton(
                    icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _showPassword = !_showPassword),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return tr.tr('password_required');
                    if (v.length < 6) return tr.tr('password_short');
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  controller: _confirm,
                  focusNode: _confirmFocus,
                  label: tr.tr('confirm_password'),
                  keyboardType: TextInputType.visiblePassword,
                  inputAction: TextInputAction.done,
                  obscure: !_showConfirm,
                  suffix: IconButton(
                    icon: Icon(_showConfirm ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _showConfirm = !_showConfirm),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return tr.tr('confirm_required');
                    if (v != _password.text) return tr.tr('passwords_not_match');
                    return null;
                  },
                  onDone: () => _submit(tr),
                ),

                const SizedBox(height: 10),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _acceptTerms,
                      onChanged: (v) => setState(() => _acceptTerms = v ?? false),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(tr.tr('terms')),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _submit(tr),
                    child: Text(tr.tr('register')),
                  ),
                ),

                const Spacer(),

                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(tr.tr('have_account')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
