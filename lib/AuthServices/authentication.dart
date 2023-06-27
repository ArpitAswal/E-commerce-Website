
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication{

  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<String> signIn(String email, String pass) async{
    String errormsg='';
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      switch (e.message) {
        case 'An unknown error occurred: FirebaseError: Firebase: There is no user record corresponding to this identifier. The user may have been deleted. (auth/user-not-found).':
          errormsg= 'There is no user record by given E-mail_Id';
          break;
        case 'An unknown error occurred: FirebaseError: Firebase: The password is invalid or the user does not have a password. (auth/wrong-password).':
          errormsg = 'Password is wrong or invalid';
          break;
        case 'An unknown error occurred: FirebaseError: Firebase: The email address is badly formatted. (auth/invalid-email).':
          errormsg = 'Entered email format is wrong. It should be xxx...@gmail.com';
          break;
        case 'An unknown error occurred: FirebaseError: Firebase: Password should be at least 6 characters (auth/weak-password).':
          errormsg = 'Password is too short. It should be at least minimum 6 charcters';
          break;
        default:
          debugPrint('Case ${e.message} is not yet implemented');
      }
    }
    return errormsg;
  }

  static Future<String> signUp(String name, String email, String pass) async{
    String errormsg='';
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      String id =auth.currentUser!.uid;
      FirebaseFirestore.instance.collection('UsersAccountData').doc('UserId:$id').set(({'name':name, 'email':email, 'pass':pass})).onError((e, _) => debugPrint("Error writing document: $e"));
    }on FirebaseAuthException catch (e) {
      switch (e.message) {
        case 'An unknown error occurred: FirebaseError: Firebase: Password should be at least 6 characters (auth/weak-password).':
          errormsg = 'Password is too short. It should be at least minimum 6 charcters';
          break;
        case 'An unknown error occurred: FirebaseError: Firebase: The email address is badly formatted. (auth/invalid-email).':
          errormsg = 'Entered email format is wrong. It should be xxx...@gmail.com';
          break;
        case 'An unknown error occurred: FirebaseError: Firebase: The email address is already in use by another account. (auth/email-already-in-use).':
          errormsg= 'Given email is already in use by another account';
          break;
        default:
          debugPrint('Case ${e.message} is not yet implemented');
      }
    }
    return errormsg;
  }

  // function to implement the google signin


  static Future<User?> googleSignIn() async {
    User? user;
    String uid,name,userEmail,imageUrl;
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
      await auth.signInWithPopup(authProvider);
      user = userCredential.user;
    } catch (e) {
      debugPrint(e.toString());
    }

    if (user != null) {
      uid = user.uid;
      name = user.displayName!;
      userEmail = user.email!;
      imageUrl = user.photoURL!;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      prefs.setString('UserId',uid);
      prefs.setString('name', name);
      prefs.setString('userEmail', userEmail);
      prefs.setString('imageUrl',imageUrl);

      FirebaseFirestore.instance.collection('UsersAccountData').doc('UserId:$uid').set(({'name':name, 'email':userEmail, 'pass':'Not exist'})).onError((e, _) => debugPrint("Error writing document: $e"));

    }
    return user;
  }
}