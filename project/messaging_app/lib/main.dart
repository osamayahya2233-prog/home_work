import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constants.dart';
import 'firebase_options.dart';

import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MessagingApp());
}

class MessagingApp extends StatelessWidget {
  const MessagingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'messaging_app',
      debugShowCheckedModeBanner: false,
      initialRoute: kSplashRoute,
      routes: {
        kSplashRoute: (_) => const SplashScreen(),
        kWelcomeRoute: (_) => const WelcomeScreen(),
        kSignInRoute: (_) => const SignInScreen(),
        kRegisterRoute: (_) => const RegistrationScreen(),
        kHomeRoute: (_) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == kChatRoute) {
          final args = settings.arguments as ChatArgs;
          return MaterialPageRoute(builder: (_) => ChatScreen(args: args));
        }
        return null;
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: true,
      ),
    );
  }
}
