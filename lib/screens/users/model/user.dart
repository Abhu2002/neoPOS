import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? userid;
  final String? firstname;
  final String? lastname;
  final String? password;
  final String? userrole;
  final String? addedon;
  final String? updatedon;
  final int? sr;

  UserModel({
    this.id,
    this.firstname,
    this.userid,
    this.lastname,
    this.password,
    this.userrole,
    this.addedon,
    this.updatedon,
    this.sr,
  });

  factory UserModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot, int sr) {
    final data = snapshot;
    return UserModel(
        id: data.id,
        firstname: data['first_name'],
        lastname: data['last_name'],
        userid: data['user_id'],
        password: data['password'],
        userrole: data['user_role'],
        addedon: data['added_on'],
        updatedon: data['updated_on'],
        sr: sr);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userid != null) "user_id": userid,
      if (firstname != null) "first_name": firstname,
      if (lastname != null) "last_name": lastname,
      if (password != null) "password": password,
      if (addedon != null) "added_on": addedon,
      if (updatedon != null) "updated_on": updatedon,
      if (userrole != null) "user_role": userrole
    };
  }
}
