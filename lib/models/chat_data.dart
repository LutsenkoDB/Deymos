import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/chat_boble.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance.currentUser;

StreamBuilder<QuerySnapshot> streamBuilder() {
  return StreamBuilder(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        List messageBobles = [];
        if (snapshot.hasData) {
          final messages = snapshot.data.docs.reversed;
          for (var message in messages) {
            final messageText = message.data()['Text'];
            final messageSender = message.data()['sender'];
            final currentUser = _auth.email;

            final messageBoble = ChatBoble(
              text: messageText,
              sender: messageSender,
              isMi: currentUser == messageSender,
            );
            messageBobles.add(messageBoble);
          }
        }
        return Expanded(
          child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              children: messageBobles),
        );
      });
}
