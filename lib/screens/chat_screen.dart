
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance.currentUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String messageText;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async{
                 await FirebaseAuth.instance.signOut();
                 Navigator.popAndPushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
        streamBuilder(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                       messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                     _firestore.collection('messages').add({
                       'Text': messageText,'sender':_auth.email
                     });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> streamBuilder() {
    return StreamBuilder(
      stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          List messageBoubles = [];
          if (snapshot.hasData) {
            final messages = snapshot.data.docs.reversed;
            for (var message in messages) {
              final messageText = message.data()['Text'];
              final messageSender = message.data()['sender'];
              final currentUser = _auth.email;

              final messageBouble = ChatBouble(
                  text: messageText, sender: messageSender,isMi: currentUser==messageSender,);
              messageBoubles.add(messageBouble);
            }
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                children: messageBoubles),
          );
        });
  }
}
class ChatBouble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMi;
  ChatBouble({this.text,this.sender,this.isMi});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMi ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
        children: [
          Text(sender),
          Material(
            elevation: 6.0,
            borderRadius: BorderRadius.circular(20.0),
            color: isMi ? Colors.teal : Colors.green,
              child:
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(text, style: TextStyle(
                  color: isMi? Colors.black54 : Colors.black
                ),),
              )),
        ],
      ),
    );
  }
}
