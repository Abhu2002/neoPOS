import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'package:neopos/utils/utils.dart';
import '../../../../utils/app_colors.dart';
import 'delete_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteCategoryPopup extends StatefulWidget {
  final String categoryID;
  final String categoryName;
  const DeleteCategoryPopup({super.key, required this.categoryID, required this.categoryName});

  @override
  State<DeleteCategoryPopup> createState() => _DeleteCategoryPopupState();
}

class _DeleteCategoryPopupState extends State<DeleteCategoryPopup> {
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
    return BlocConsumer<CategoryDeletionBloc, CategoryDeletionState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showErrorDialog(context, state.errorMessage);
        } else if (state is ConfirmationState) {
          showConfirmationDialog(context, state.id, state.categoyName);
        } else if (state is CategoryDeleteState) {
          showSnackBar(
              context, AppLocalizations.of(context)!.category_delete_msg);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
          title: PopUpRow(
              title: AppLocalizations.of(context)!.delete_category_title),
          content:
              Text(AppLocalizations.of(context)!.delete_confirm_msg_category),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.no_title),
            ),
            ElevatedButton(
              onPressed: () async {
                BlocProvider.of<CategoryDeletionBloc>(context)
                    .add(ConfirmTableDeletionEvent(widget.categoryID, widget.categoryName));
              },
              child: Text(AppLocalizations.of(context)!.yes_title),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actionsPadding: const EdgeInsets.all(20),
          title: PopUpRow(title: AppLocalizations.of(context)!.error_text),
          content: Text(message),
          actions: [
            TextButton(
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

  void showConfirmationDialog(BuildContext context, String id, String categoryName) {
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
                  controller: _usernameController,
                  validator: (val) {
                    if (!val!.isValidUsername) {
                      return AppLocalizations.of(context)!.valid_username;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.username_hinttext,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                      )),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  validator: (val) {
                    if (!val!.isValidPassword) {
                      return AppLocalizations.of(context)!.valid_password;
                    } else {
                      return null;
                    }
                  },
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
                  BlocProvider.of<CategoryDeletionBloc>(context).add(
                    CredentialsEnteredEvent(
                        _usernameController.text, _passwordController.text, id, categoryName),
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
