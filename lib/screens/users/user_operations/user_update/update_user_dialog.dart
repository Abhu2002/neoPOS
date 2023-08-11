import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import '../../../../utils/app_colors.dart';
import 'update_user_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neopos/utils/utils.dart';
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

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    context.read<UpdateUserBloc>().showMessage = createSnackBar;
    String newFirstName = widget.oldFirstName;
    String newLastName = widget.oldLastName;
    String newUserId = widget.oldUserId;
    String newPassword = widget.oldPassword;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: PopUpRow(title: AppLocalizations.of(context)!.user_update_title),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (val) {
                  if (!val.isValidName) {
                    return AppLocalizations.of(context)!.valid_username;
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (value) => newFirstName = value,
                controller: TextEditingController(text: widget.oldFirstName),
                decoration:  InputDecoration(
                    hintText:AppLocalizations.of(context)!.first_name_hinttext,
                    prefixIcon: const Icon(
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
                    return AppLocalizations.of(context)!.valid_last_name;
                  }else{
                    return null;
                  }
                },
                onChanged: (value) => newLastName = value,
                controller: TextEditingController(text: widget.oldLastName),
                decoration:  InputDecoration(
                    hintText: AppLocalizations.of(context)!.user_id_hinttext,
                    prefixIcon: const Icon(
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
                    return AppLocalizations.of(context)!.valid_username;
                  }else{
                    return null;
                  }
                },
                onChanged: (value) => newUserId = value,
                controller: TextEditingController(text: widget.oldUserId),
                decoration:  InputDecoration(
                    hintText: AppLocalizations.of(context)!.username_hinttext,
                    prefixIcon: const Icon(
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
                    return AppLocalizations.of(context)!.valid_password;
                  }
                  else{
                    return null;
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
          child: Text(AppLocalizations.of(context)!.cancel_button),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.update_button),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              BlocProvider.of<UpdateUserBloc>(context).add(
                UpdateUserBlocRequested(widget.docId, newFirstName, newLastName,
                    newPassword, newUserId),
              );
              Navigator.of(context).pop();
              final snackBar = SnackBar(
                  content: Text(AppLocalizations.of(context)!.user_update_msg));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {

              final snackBar = SnackBar(
                  content: Text(
                      AppLocalizations.of(context)!.user_update_error_msg));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
      ],
    );
  }
  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
