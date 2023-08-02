import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/app_colors.dart';
import 'delete_user_bloc.dart';
import 'delete_user_event.dart';
import 'delete_user_state.dart';

class DeleteUserPopup extends StatefulWidget {
  final String docID;

  const DeleteUserPopup({super.key, required this.docID});

  @override
  State<DeleteUserPopup> createState() => _DeleteUserPopupState();
}

class _DeleteUserPopupState extends State<DeleteUserPopup> {
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
    return BlocConsumer<UserDeletionBloc, UserDeletionState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showErrorDialog(context, state.error);
        } else if (state is ConfirmationState) {
          showConfirmationDialog(context);
        } else if (state is UserDeleteState) {
          showUserSnackBar(context, 'User deleted successfully.');
        }
      },
      builder: (context, state) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
          title: const Text(
            'Enter Credentials',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.mainTextColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    hintText: "Username",
                    prefixIcon: const Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    )),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColors.primaryColor,
                    )),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop();
                BlocProvider.of<UserDeletionBloc>(context).add(
                  UserCredentialsEnteredEvent(
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
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
          title: const Text(
            'Error',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.mainTextColor),
          ),
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
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
          title: const Text('Delete User',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainTextColor)),
          content: const Text(
            'Are you sure you want to delete this User?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                BlocProvider.of<UserDeletionBloc>(context).deleteUser(
                    widget.docID); //passing doc id to bloc for user deletion
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

  void showUserSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
