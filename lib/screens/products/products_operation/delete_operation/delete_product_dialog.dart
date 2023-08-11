import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'delete_bloc.dart';
import 'package:neopos/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteProductPopup extends StatefulWidget {
  final String productID;

  const DeleteProductPopup({super.key, required this.productID});

  @override
  State<DeleteProductPopup> createState() => _DeleteProductPopupState();
}

class _DeleteProductPopupState extends State<DeleteProductPopup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _usernameController.text = "";
    _passwordController.text = "";
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDeletionBloc, ProductDeletionState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showErrorDialog(context, state.error);
        } else if (state is ConfirmationState) {
          showConfirmationDialog(context, state.id);
        } else if (state is ProductDeleteState) {
          showSnackBar(context, AppLocalizations.of(context)!.product_delete_msg);
        }
      },
      builder: (context, state) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          title:  Text(AppLocalizations.of(context)!.product_delete_title),
          content:  Text(AppLocalizations.of(context)!.product_delete_confirm_msg),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:  Text(AppLocalizations.of(context)!.no_title),
            ),
            ElevatedButton(
              onPressed: () async {
                BlocProvider.of<ProductDeletionBloc>(context)
                    .add(ConfirmTableDeletionEvent(widget.productID));
              },
              child:  Text(AppLocalizations.of(context)!.yes_title),
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
                borderRadius: BorderRadius.all(Radius.circular(15))),
          title:  Text(AppLocalizations.of(context)!.error_text),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child:  Text(AppLocalizations.of(context)!.ok_button),
            ),
          ],
        );
      },
    );
  }

  void showConfirmationDialog(BuildContext context,String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          title:  Text(AppLocalizations.of(context)!.enter_credentials),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (val) {
                    if (!val.isValidUsername) {
                      return AppLocalizations.of(context)!.valid_username;
                    }else{
                      return null;
                    }
                  },
                  controller: _usernameController,
                  decoration:  InputDecoration(hintText: AppLocalizations.of(context)!.username_hinttext),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (val) {
                    if (!val.isValidPassword) {
                      return AppLocalizations.of(context)!.valid_password;
                    }else{
                      return null;
                    }
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration:  InputDecoration(hintText: AppLocalizations.of(context)!.password_hinttext),
                ),
              ],
            ),
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
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<ProductDeletionBloc>(context).add(
                    CredentialsEnteredEvent(
                        _usernameController.text, _passwordController.text, id),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Submit'),
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
