
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStore{

  static save(String name, email, pass, uid) async{
    await FirebaseFirestore.instance.collection('UsersAccount').doc('$uid').set({'name':name, 'email':email, 'password':pass});
  }
}