import 'package:flutter/material.dart';
import 'package:neopos/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserCredentialsForm extends StatefulWidget {
  final GlobalKey formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  const UserCredentialsForm({super.key, required this.formKey, required this.usernameController, required this.passwordController});

  @override
  State<UserCredentialsForm> createState() => _UserCredentialsFormState();
}

class _UserCredentialsFormState extends State<UserCredentialsForm> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = widget.usernameController;
    final TextEditingController _passwordController = widget.passwordController;

    return Form(
      key: widget.formKey,
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
                AppLocalizations.of(context)!.username_hinttext),
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: (val) {
              if (!val.isValidPassword) {
                return AppLocalizations.of(context)!.valid_password;
              } else {
                return null;
              }
            },
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
                hintText:
                AppLocalizations.of(context)!.password_hinttext),
          ),
        ],
      ),
    );
  }
}
