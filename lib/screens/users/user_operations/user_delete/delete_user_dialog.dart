import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import '../../../../utils/app_colors.dart';
import 'delete_user_bloc.dart';
import 'package:neopos/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteUserPopup extends StatefulWidget {
  final String docID;

  const DeleteUserPopup({super.key, required this.docID});

  @override
  State<DeleteUserPopup> createState() => _DeleteUserPopupState();
}

class _DeleteUserPopupState extends State<DeleteUserPopup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _usernameController.text = "";
    _passwordController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDeletionBloc, UserDeletionState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showErrorDialog(context);
        } else if (state is ConfirmationState) {
          showConfirmationDialog(context, state.id);
        } else if (state is UserDeleteState) {
          showUserSnackBar(
              context, AppLocalizations.of(context)!.user_deleted_msg);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
          title:
              PopUpRow(title: AppLocalizations.of(context)!.user_deleted_title),
          content: Text(AppLocalizations.of(context)!.delete_confirm_msg_user),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.no_title),
            ),
            ElevatedButton(
              onPressed: () async {
                BlocProvider.of<UserDeletionBloc>(context).add(
                    ConfirmUserDeletionEvent(widget
                        .docID)); //passing doc id to bloc for user deletion
              },
              child: Text(AppLocalizations.of(context)!.yes_title),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
          title: PopUpRow(title: AppLocalizations.of(context)!.error_text),
          content: Text(AppLocalizations.of(context)!.invalid_credentials),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.ok_button),
            ),
          ],
        );
      },
    );
  }

  void showConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
          title:
              PopUpRow(title: AppLocalizations.of(context)!.enter_credentials),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (val) {
                    if (!val.isValidUsername) {
                      return AppLocalizations.of(context)!.valid_username;
                    } else {
                      return null;
                    }
                  },
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)!.user_name_hinttext,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                      )),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (val) {
                    if (!val!.isValidPassword) {
                      return AppLocalizations.of(context)!.valid_password;
                    } else {
                      return null;
                    }
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.password_hinttext,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: AppColors.primaryColor,
                      )),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel_button),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // Navigator.of(context).pop();
                  BlocProvider.of<UserDeletionBloc>(context).add(
                    UserCredentialsEnteredEvent(
                        _usernameController.text, _passwordController.text, id),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text(AppLocalizations.of(context)!.submit_button),
            ),
          ],
        );
      },
    );
  }

  void showUserSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
    Navigator.of(context).pop();
  }
}
