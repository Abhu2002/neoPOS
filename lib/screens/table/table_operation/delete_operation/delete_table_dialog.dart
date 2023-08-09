import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'package:neopos/utils/utils.dart';
import 'delete_bloc.dart';
import 'delete_event.dart';
import 'delete_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteTablePopup extends StatefulWidget {
  final String docID;

  const DeleteTablePopup({super.key, required this.docID});

  @override
  State<DeleteTablePopup> createState() => _DeleteTablePopupState();
}

class _DeleteTablePopupState extends State<DeleteTablePopup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _usernameController.text = "";
    _passwordController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TableDeletionBloc, TableDeletionState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showErrorDialog(context, state.error);
        } else if (state is ConfirmationState) {
          showConfirmationDialog(context);
        } else if (state is TableDeleteState) {
          showSnackBar(context, 'Table deleted successfully.');
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title:
              PopUpRow(title: AppLocalizations.of(context)!.enter_credentials),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (val) {
                    if (!val.isValidUsername) {
                      return "Enter a Valid User Name";
                    }
                  },
                  controller: _usernameController,
                  decoration:  InputDecoration(hintText: AppLocalizations.of(context)!.username_hinttext)),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (val) {
                    if (!val.isValidPassword) {
                      return "Enter a Valid Password";
                    }
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration:  InputDecoration(hintText: AppLocalizations.of(context)!.password_hinttext)),
              ],
            ),
        ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel_button),
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                if (formkey.currentState!.validate()) {
                  BlocProvider.of<TableDeletionBloc>(context).add(
                    CredentialsEnteredEvent(
                      _usernameController.text,
                      _passwordController.text,
                    ),
                  );
                }
              },
              child: Text(AppLocalizations.of(context)!.submit_button),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: PopUpRow(title: AppLocalizations.of(context)!.error_text),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:  Text(AppLocalizations.of(context)!.submit_button),
            ),
          ],
        );
      },
    );
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              PopUpRow(title: AppLocalizations.of(context)!.update_table_title),
          content: Text(AppLocalizations.of(context)!.delete_confirm_msg_table),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.no_title),
            ),
            TextButton(
              onPressed: () async {
                BlocProvider.of<TableDeletionBloc>(context)
                    .deleteTable(widget.docID);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.yes_title),
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
