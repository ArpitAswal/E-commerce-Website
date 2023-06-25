
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../Global/message.dart';

class Authentication{

  static final FirebaseAuth auth = FirebaseAuth.instance;
  static signIn(String email, String pass) async{
    try{
      auth.signInWithEmailAndPassword(email: email, password: pass);
     // Alert.toastmessage("Login Succesfully");
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        Alert.toastmessage('No user found with this e-mail');
      }
      else if(e.code == 'wrong-password'){
        Alert.toastmessage('Password did not match');
      }
    } catch(e){
      Alert.toastmessage(e.toString());
      debugPrint(e.toString());
    }
  }

  static signUp(String name, String email, String pass) async{
     try{
       auth.createUserWithEmailAndPassword(email: email, password: pass);
       await auth.currentUser!.updateDisplayName(name);
       await auth.currentUser!.updateEmail(email);
       await auth.currentUser!.updatePassword(pass);
       //await CloudFirestore.save(name,email,pass,auth.currentUser!.uid);
       Alert.toastmessage('SignUp Done');
     } on FirebaseAuthException catch(e){
       if(e.code == 'weak-password'){
         Alert.toastmessage('Password must be strong');
       }
       else if(e.code == 'email-already-in-use'){
         Alert.toastmessage('This e-mail is already exist');
       }
     }
     catch(e){
       Alert.toastmessage('Connection Error');
     }
  }
}