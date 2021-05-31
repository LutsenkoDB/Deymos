import 'package:firebase_auth/firebase_auth.dart';

class ChatUser {
  final _auth = FirebaseAuth.instance;
  final String email;
  final String password;

  ChatUser({this.email, this.password});
  registerNewUser(email, password) async {
    try {
      final newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (newUser != null) {
        // Navigator.pushNamed(context, ChatScreen.id);
      }
    } catch (e) {}
  }

  loginUser(email, password) async {
    try {
      final loggedUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return loggedUser;
    } catch (e) {
      print(e);
    }
  }

  logOffUser() async {
    await FirebaseAuth.instance.signOut();
    //Navigator.popAndPushNamed(context, WelcomeScreen.id);
  }
}
