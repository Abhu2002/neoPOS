import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? password;
  final String? userrole;
  final String? addedon;
  final String? updatedon;

  UserModel( {this.firstname,
    this.username,this.lastname, this.password, this.userrole, this.addedon, this.updatedon,

  });

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserModel(
      firstname: data?['firstname'],
      lastname: data?['lastname'],
      username: data?['username'],
      password: data?['password'],
      userrole: data?['userrole'],
      addedon: data?['addedon'],
      updatedon: data?['updatedon'],

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (username != null) "user_id": username,
      if (firstname != null) "first_name": firstname,
      if (lastname != null) "last_name": lastname,
      if (password != null) "password": password,
      if (addedon!= null) "added_on": addedon,
      if (updatedon != null) "updated_on": updatedon,
      if(userrole !=null) "user_role": userrole
    };
  }
}