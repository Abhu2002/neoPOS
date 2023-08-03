import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'delete_bloc.dart';
import 'delete_event.dart';
import 'delete_state.dart';

class DeleteTablePopup extends StatefulWidget {
  final String docID;

  const DeleteTablePopup({super.key, required this.docID});

  @override
  State<DeleteTablePopup> createState() => _DeleteTablePopupState();
}

class _DeleteTablePopupState extends State<DeleteTablePopup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          title: const PopUpRow(title: 'Enter Credentials'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                BlocProvider.of<TableDeletionBloc>(context).add(
                  CredentialsEnteredEvent(
                    _usernameController.text,
                    _passwordController.text,
                  ),
                );
              },
              child: const Text('Submit'),
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
          title: const PopUpRow(title: "Error"),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
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
          title: const PopUpRow(title: "Delete Table"),
          content: const Text('Are you sure you want to delete this Table?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                BlocProvider.of<TableDeletionBloc>(context)
                    .deleteTable(widget.docID);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
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
