import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_bloc.dart';
import 'delete_event.dart';
import 'delete_state.dart';

class DeleteCategoryPopup extends StatefulWidget {
  final categoryID;
  const DeleteCategoryPopup({super.key, this.categoryID});

  @override
  State<DeleteCategoryPopup> createState() => _DeleteCategoryPopupState();
}

class _DeleteCategoryPopupState extends State<DeleteCategoryPopup> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.categoryID);
    return BlocConsumer<CategoryDeletionBloc, CategoryDeletionState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showErrorDialog(context, state.error);
        } else if (state is ConfirmationState) {
          showConfirmationDialog(context);
        } else if (state is CategoryDeleteState) {
          showSnackBar(context, 'Category deleted successfully.');
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text('Enter Credentials'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(hintText: 'Username'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                BlocProvider.of<CategoryDeletionBloc>(context).add(
                  CredentialsEnteredEvent(
                    _usernameController.text,
                    _passwordController.text,
                  ),
                );
              },
              child: Text('Submit'),
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
          title: Text('Error'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
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
          title: Text('Delete Category'),
          content: Text('Are you sure you want to delete this table?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                BlocProvider.of<CategoryDeletionBloc>(context)
                    .deleteCategory(widget.categoryID);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
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
