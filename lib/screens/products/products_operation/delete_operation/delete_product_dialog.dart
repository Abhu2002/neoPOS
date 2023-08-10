import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'delete_bloc.dart';
import 'delete_event.dart';
import 'delete_state.dart';
import 'package:neopos/utils/utils.dart';

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

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDeletionBloc, ProductDeletionState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showErrorDialog(context, state.error);
        } else if (state is ConfirmationState) {
          showConfirmationDialog(context, state.id);
        } else if (state is ProductDeleteState) {
          showSnackBar(context, 'Product deleted successfully.');
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete this Product?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                BlocProvider.of<ProductDeletionBloc>(context)
                    .add(ConfirmTableDeletionEvent(widget.productID));
              },
              child: const Text('Yes'),
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
          title: const Text('Error'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
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
          title: const Text('Enter Credentials'),
          content: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (val) {
                    if (!val.isValidUsername) {
                      return "Enter a Valid Username";
                    }
                  },
                  controller: _usernameController,
                  decoration: const InputDecoration(hintText: 'Username'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (val) {
                    if (!val.isValidPassword) {
                      return "Enter a Valid Password";
                    }
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
              ],
            ),
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
                if (formkey.currentState!.validate()) {
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
