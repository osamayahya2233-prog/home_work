import 'package:flutter/material.dart';
import '../models/api_user.dart';
import '../services/api_service.dart';

class ApiUsersScreen extends StatefulWidget {
  const ApiUsersScreen({super.key});

  @override
  State<ApiUsersScreen> createState() => _ApiUsersScreenState();
}

class _ApiUsersScreenState extends State<ApiUsersScreen> {
  late Future<List<ApiUser>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ApiUser>>(
      future: _future,
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(child: Text('API Error: ${snap.error}'));
        }
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final users = snap.data!;
        return ListView.separated(
          itemCount: users.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final u = users[i];
            return ListTile(
              leading: CircleAvatar(child: Text(u.id.toString())),
              title: Text(u.name),
              subtitle: Text('${u.email} • ${u.city}'),
            );
          },
        );
      },
    );
  }
}
