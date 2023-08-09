import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'package:neopos/utils/utils.dart';
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
  const UpdateUserForm(
      {super.key,
      required this.docId,
      required this.oldFirstName,
      required this.oldLastName,
      required this.oldUserId,
      required this.oldPassword});

  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  final formkey = GlobalKey<FormState>();
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
      title: const PopUpRow(title: 'Update User'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (val) {
                  if (!val.isValidName) {
                    return "Enter a Valid First Name";
                  }
                },
                onChanged: (value) => newFirstName = value,
                controller: TextEditingController(text: widget.oldFirstName),
                decoration: const InputDecoration(
                    hintText: "First name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (val) {
                  if (!val.isValidName) {
                    return "Enter a Valid Last Name";
                  }
                },
                onChanged: (value) => newLastName = value,
                controller: TextEditingController(text: widget.oldLastName),
                decoration: const InputDecoration(
                    hintText: "Last name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (val) {
                  if (!val.isValidUsername) {
                    return "Enter a valid Username ";
                  }
                },
                onChanged: (value) => newUserId = value,
                controller: TextEditingController(text: widget.oldUserId),
                decoration: const InputDecoration(
                    hintText: "User name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (val) {
                  if (!val.isValidPassword) {
                    return "Enter a valid Username ";
                  }
                },
                onChanged: (value) => newPassword = value,
                controller: TextEditingController(text: widget.oldPassword),
                decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.primaryColor,
                    )),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Update'),
          onPressed: () {
            if (formkey.currentState!.validate()) {
              BlocProvider.of<UpdateUserBloc>(context).add(
                UpdateUserBlocRequested(widget.docId, newFirstName, newLastName,
                    newPassword, newUserId),
              );
              Navigator.of(context).pop();
              final snackBar = SnackBar(content: const Text("User Updated"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              //Navigator.of(context).pop();-->Not required
              final snackBar = SnackBar(
                  content: const Text("User Not Updated, Data Missing"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
      ],
    );
  }
}
