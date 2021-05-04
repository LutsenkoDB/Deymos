import 'package:firebase_auth/firebase_auth.dart';

class Register {
  String email;
  String password;
  Register({this.email,this.password});

 registerNewUser()async{
   try {
      final newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email,
         password: password
     );
   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
     }
   } catch (e) {
     print(e);
   }
 }
}