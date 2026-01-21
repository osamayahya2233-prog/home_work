import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';
import 'chat_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myUid = FirebaseAuth.instance.currentUser?.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error}'));
        }
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snap.data!.docs.where((d) => d.id != myUid).toList();

        if (docs.isEmpty) {
          return const Center(
            child: Text('No other users yet. Create another account to chat.'),
          );
        }

        return ListView.separated(
          itemCount: docs.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final data = docs[i].data() as Map<String, dynamic>;
            final uid = data['uid'] as String? ?? docs[i].id;
            final email = data['email'] as String? ?? 'unknown';
            final name = data['displayName'] as String? ?? email.split('@').first;

            return ListTile(
              leading: CircleAvatar(child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?')),
              title: Text(name),
              subtitle: Text(email),
              trailing: const Icon(Icons.chat_bubble_outline),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  kChatRoute,
                  arguments: ChatArgs(peerUid: uid, peerName: name, peerEmail: email),
                );
              },
            );
          },
        );
      },
    );
  }
}
