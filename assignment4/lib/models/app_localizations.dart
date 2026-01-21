import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _values = {
    'en': {
      // Titles
      'login_title': 'Login to your\naccount',
      'register_title': 'Register new\naccount',

      // Labels
      'email': 'Email',
      'password': 'Password',
      'confirm_password': 'Password Confirmation',

      // Buttons
      'login': 'Login',
      'register': 'Register',
      'login_google': 'Login with Google',

      // Texts
      'remember_me': 'Remember me',
      'terms': 'By creating an account, you agree to our\nTerms & Conditions',
      'or': 'OR',
      'no_account': "Don't have an account? Register",
      'have_account': 'Already have an account? Login',

      // Validation
      'email_required': 'Email is required',
      'email_invalid': 'Invalid email format',
      'password_required': 'Password is required',
      'password_short': 'Password must be at least 6 characters',
      'confirm_required': 'Confirmation is required',
      'passwords_not_match': 'Passwords do not match',
      'accept_terms': 'Please accept Terms & Conditions',
      'success_login': 'Login successful ✅',
      'success_register': 'Registered successfully ✅',
    },
    'ar': {
      // Titles
      'login_title': 'تسجيل الدخول\nإلى حسابك',
      'register_title': 'إنشاء حساب\nجديد',

      // Labels
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirm_password': 'تأكيد كلمة المرور',

      // Buttons
      'login': 'دخول',
      'register': 'تسجيل',
      'login_google': 'تسجيل الدخول باستخدام Google',

      // Texts
      'remember_me': 'تذكرني',
      'terms': 'بإنشائك حساباً فأنت توافق على\nالشروط والأحكام',
      'or': 'أو',
      'no_account': 'ليس لديك حساب؟ سجل الآن',
      'have_account': 'لديك حساب؟ تسجيل الدخول',

      // Validation
      'email_required': 'البريد الإلكتروني مطلوب',
      'email_invalid': 'صيغة البريد الإلكتروني غير صحيحة',
      'password_required': 'كلمة المرور مطلوبة',
      'password_short': 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
      'confirm_required': 'تأكيد كلمة المرور مطلوب',
      'passwords_not_match': 'كلمتا المرور غير متطابقتين',
      'accept_terms': 'يجب الموافقة على الشروط والأحكام',
      'success_login': 'تم تسجيل الدخول بنجاح ✅',
      'success_register': 'تم إنشاء الحساب بنجاح ✅',
    },
  };

  String tr(String key) => _values[locale.languageCode]![key]!;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
