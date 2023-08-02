import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/app_colors.dart';
import 'update_user_bloc.dart';
import 'update_user_event.dart';

//pass category name and category id to update the category..
class UpdateUserForm extends StatefulWidget {
  final String docId;
  final String oldFirstName;
  final String oldLastName;
  final String oldUserId;
  final String oldPassword;
  const UpdateUserForm({super.key, required this.docId, required this.oldFirstName, required this.oldLastName, required this.oldUserId, required this.oldPassword});

  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {

  @override
  Widget build(BuildContext context) {
    String newFirstName = widget.oldFirstName;
    String newLastName = widget.oldLastName;
    String newUserId = widget.oldUserId;
    String newPassword = widget.oldPassword;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: Text(
        'Update User',
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => newFirstName = value,
              controller: TextEditingController(text: widget.oldFirstName),
              decoration: InputDecoration(
                  hintText: "first name",
                  prefixIcon: const Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) => newLastName = value,
              controller: TextEditingController(text: widget.oldLastName),
              decoration: InputDecoration(
                  hintText: "first name",
                  prefixIcon: const Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) => newUserId = value,
              controller: TextEditingController(text: widget.oldUserId),
              decoration: InputDecoration(
                  hintText: "first name",
                  prefixIcon: const Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) => newPassword = value,
              controller: TextEditingController(text: widget.oldPassword),
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
            if (newFirstName.trim().isNotEmpty &&
                newLastName.trim().isNotEmpty &&
                newUserId.trim().isNotEmpty &&
                newPassword.trim().isNotEmpty) {
              BlocProvider.of<UpdateUserBloc>(context).add(
                UpdateUserBlocRequested(
                    widget.docId, newFirstName, newLastName, newPassword, newUserId),
              );
              Navigator.of(context).pop();
              final snackBar =
              SnackBar(content: Text("User Updated"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

            }
            else{Navigator.of(context).pop();
            final snackBar =
            SnackBar(content: Text("User Not Updated, Data Missing"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);}
          },
        ),
      ],
    );
  }
}
