import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'package:neopos/utils/user_credentials_form.dart';
import 'package:neopos/utils/utils.dart';
import 'delete_bloc.dart';
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
  final formKey = GlobalKey<FormState>();

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
          showErrorDialog(context, "Invalid Credentials");
        } else if (state is ConfirmationState) {
          showConfirmationDialog(context, state.id);
        } else if (state is TableDeleteState) {
          showSnackBar(context, AppLocalizations.of(context)!.table_delete_msg);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
          title:
              PopUpRow(title: AppLocalizations.of(context)!.delete_table_title),
          content: Text(AppLocalizations.of(context)!.delete_confirm_msg_table),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.no_title),
            ),
            ElevatedButton(
              onPressed: () async {
                BlocProvider.of<TableDeletionBloc>(context)
                    .add(ConfirmTableDeletionEvent(widget.docID));
              },
              child: Text(AppLocalizations.of(context)!.yes_title),
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
          title:
              PopUpRow(title: AppLocalizations.of(context)!.enter_credentials),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsPadding: const EdgeInsets.all(20),
          content: UserCredentialsForm(
              formKey: formKey,
              usernameController: _usernameController,
              passwordController: _passwordController),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel_button),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop();
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<TableDeletionBloc>(context).add(
                    CredentialsEnteredEvent(
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

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
    Navigator.of(context).pop();
  }
}
