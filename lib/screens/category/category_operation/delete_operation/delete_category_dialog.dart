import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import '../../../../utils/app_colors.dart';
import 'delete_bloc.dart';
import 'delete_event.dart';
import 'delete_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteCategoryPopup extends StatefulWidget {
  final String categoryID;

  const DeleteCategoryPopup({super.key, required this.categoryID});

  @override
  State<DeleteCategoryPopup> createState() => _DeleteCategoryPopupState();
}

class _DeleteCategoryPopupState extends State<DeleteCategoryPopup> {
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
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
          title:
              PopUpRow(title: AppLocalizations.of(context)!.enter_credentials),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.username_hinttext,
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
                    hintText: AppLocalizations.of(context)!.password_hinttext,
                    prefixIcon: const Icon(
                      Icons.person,
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
              child: Text(AppLocalizations.of(context)!.cancel_button),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop();
                BlocProvider.of<CategoryDeletionBloc>(context).add(
                  CredentialsEnteredEvent(
                    _usernameController.text,
                    _passwordController.text,
                  ),
                );
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
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
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
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
          title: PopUpRow(
              title: AppLocalizations.of(context)!.delete_category_title),
          content:
              Text(AppLocalizations.of(context)!.delete_confirm_msg_category),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.no_title),
            ),
            TextButton(
              onPressed: () async {
                BlocProvider.of<CategoryDeletionBloc>(context)
                    .deleteCategory(widget.categoryID);
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
