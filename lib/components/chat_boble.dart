import 'package:flutter/material.dart';

class ChatBoble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMi;
  ChatBoble({this.text,this.sender,this.isMi});
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