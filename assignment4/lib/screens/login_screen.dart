import 'package:flutter/material.dart';
import '../models/app_localizations.dart';
import '../widgets/custom_text_field.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onChangeLanguage;
  const LoginScreen({super.key, required this.onChangeLanguage});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _rememberMe = false;
  bool _showPassword = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  bool _isValidEmail(String v) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v);
  }

  void _submit(AppLocalizations tr) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr.tr('success_login'))),
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
                  tr.tr('login_title'),
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
                  label: tr.tr('password'),
                  keyboardType: TextInputType.visiblePassword,
                  inputAction: TextInputAction.done,
                  obscure: !_showPassword,
                  suffix: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => _showPassword = !_showPassword),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return tr.tr('password_required');
                    if (v.length < 6) return tr.tr('password_short');
                    return null;
                  },
                  onDone: () => _submit(tr),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (v) => setState(() => _rememberMe = v ?? false),
                    ),
                    Text(tr.tr('remember_me')),
                  ],
                ),

                const SizedBox(height: 8),

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
                    child: Text(tr.tr('login')),
                  ),
                ),

                const SizedBox(height: 20),
                Center(child: Text(tr.tr('or'))),
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(tr.tr('login_google')),
                  ),
                ),

                const Spacer(),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterScreen(
                            onChangeLanguage: widget.onChangeLanguage,
                          ),
                        ),
                      );
                    },
                    child: Text(tr.tr('no_account')),
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
