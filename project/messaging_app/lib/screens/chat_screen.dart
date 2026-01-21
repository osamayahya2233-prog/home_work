import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatArgs {
  final String peerUid;
  final String peerName;
  final String peerEmail;

  ChatArgs({required this.peerUid, required this.peerName, required this.peerEmail});
}

class ChatScreen extends StatefulWidget {
  final ChatArgs args;
  const ChatScreen({super.key, required this.args});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _msg = TextEditingController();

  String _chatId(String a, String b) {
    final list = [a, b]..sort();
    return '${list[0]}_${list[1]}';
  }

  Future<void> _send(String chatId) async {
    final text = _msg.text.trim();
    if (text.isEmpty) return;

    final my = FirebaseAuth.instance.currentUser!;
    _msg.clear();

    final chatDoc = FirebaseFirestore.instance.collection('chats').doc(chatId);
    final msgCol = chatDoc.collection('messages');

    await chatDoc.set({
      'members': [my.uid, widget.args.peerUid],
      'updatedAt': FieldValue.serverTimestamp(),
      'lastMessage': text,
    }, SetOptions(merge: true));

    await msgCol.add({
      'from': my.uid,
      'to': widget.args.peerUid,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  void dispose() {
    _msg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final my = FirebaseAuth.instance.currentUser!;
    final chatId = _chatId(my.uid, widget.args.peerUid);

    final messagesStream = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.args.peerName),
            Text(widget.args.peerEmail, style: const TextStyle(fontSize: 12)),
          ],
        ),
        
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messagesStream,
              builder: (context, snap) {
                if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
                if (!snap.hasData) return const Center(child: CircularProgressIndicator());

                final docs = snap.data!.docs;
                if (docs.isEmpty) return const Center(child: Text('No messages yet'));

                return ListView.builder(
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    final d = docs[i].data() as Map<String, dynamic>;
                    final from = d['from'] as String?;
                    final text = d['text'] as String? ?? '';
                    final isMe = from == my.uid;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        constraints: const BoxConstraints(maxWidth: 320),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: isMe ? Colors.blue.shade100 : Colors.grey.shade200,
                        ),
                        child: Text(text),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _msg,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _send(chatId),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () => _send(chatId),
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
