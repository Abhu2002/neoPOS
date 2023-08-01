import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/app_colors.dart';
import 'update_user_bloc.dart';
import 'update_user_event.dart';

//pass category name and category id to update the category..

void showUpdateUserDialog(BuildContext context, String docId, String oldFirstName,String oldLastName,String oldUserId,String oldPassword) {
  String newFirstName = oldFirstName;
  String newLastName = oldLastName;
  String newUserId = oldUserId;
  String newPassword = oldPassword;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        actionsPadding: const EdgeInsets.all(20),
        title: Text('Update User',style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor),),
        content: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => newFirstName = value,
                controller: TextEditingController(text: oldFirstName),
                  decoration: InputDecoration(
                      hintText: "first name",
                      prefixIcon: const Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                      )),
              ),
              SizedBox(height: 10,),
              TextField(
                onChanged: (value) => newLastName = value,
                controller: TextEditingController(text: oldLastName),
                decoration: InputDecoration(
                    hintText: "first name",
                    prefixIcon: const Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    )),
              ),
              SizedBox(height: 10,),
              TextField(
                onChanged: (value) => newUserId = value,
                controller: TextEditingController(text: oldUserId),
                decoration: InputDecoration(
                    hintText: "first name",
                    prefixIcon: const Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    )),
              ),
              SizedBox(height: 10,),
              TextField(
                onChanged: (value) => newPassword = value,
                controller: TextEditingController(text: oldPassword),
                decoration: InputDecoration(
                    hintText: "first name",
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColors.primaryColor,
                    )),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Update'),
            onPressed: () {
              if (newFirstName.trim().isNotEmpty && newLastName.trim().isNotEmpty && newUserId.trim().isNotEmpty && newPassword.trim().isNotEmpty) {
                BlocProvider.of<UpdateUserBloc>(context).add(
                  UpdateUserBlocRequested(docId, newFirstName,newLastName,newPassword,newUserId),
                );
              }
              Navigator.of(context).pop();
              final snackBar = SnackBar(content: Text("User Not Updated, Data Missing"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      );
    },
  );
}