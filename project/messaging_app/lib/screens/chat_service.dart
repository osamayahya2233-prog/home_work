import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get myUid => _auth.currentUser!.uid;

  String chatId(String a, String b) {
    final ids = [a, b]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  Future<void> sendMessage(String peerId, String text) async {
    final id = chatId(myUid, peerId);
    await _db.collection('chats').doc(id).collection('messages').add({
      'senderId': myUid,
      'text': text,
      'time': FieldValue.serverTimestamp(),
    });
  }
}
