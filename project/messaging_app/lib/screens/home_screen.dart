import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';
import 'users_screen.dart';
import 'api_users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, kWelcomeRoute, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final pages = const [
      UsersScreen(),
      ApiUsersScreen(), // ✅ لا نحذف API الخارجي
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_index == 0 ? 'Users' : 'API Users'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (v) => setState(() => _index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.people), label: 'Users'),
          NavigationDestination(icon: Icon(Icons.api), label: 'API'),
        ],
      ),
    );
  }
}
