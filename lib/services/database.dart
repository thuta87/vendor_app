import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String email, String fname, String lname, String mobile, int theme) async {
    return await userCollection.document(uid).setData({
      'email': email,
      'fname': fname,
      'lname': lname,
      'mobile': mobile,
      'theme': theme
    });
  }

  Stream<QuerySnapshot> get users{
    return userCollection.snapshots();
  }
}