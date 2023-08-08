import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import '../../../../utils/popup_cancel_button.dart';
import 'create_user_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateUserForm extends StatefulWidget {
  const CreateUserForm({super.key});

  @override
  State<CreateUserForm> createState() => _CreateUserFormState();
}

class _CreateUserFormState extends State<CreateUserForm> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    BlocProvider.of<CreateUserBloc>(context)
        .add(const InputEvent("", "", "", "", ""));
    userName.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<CreateUserBloc>().showMessage = createSnackBar;
    List<String> list = <String>[
      AppLocalizations.of(context)!.admin,
      AppLocalizations.of(context)!.waiter
    ];
    String dropdownValue = list.first;
    return AlertDialog(
      // contentPadding: EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: PopUpRow(title: AppLocalizations.of(context)!.create_user_title),
      actions: [
        Form(
          key: formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              children: [
                BlocBuilder<CreateUserBloc, CreateUserState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: firstName,
                      decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.first_name_hinttext,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                          )),
                      onChanged: (val) {
                        BlocProvider.of<CreateUserBloc>(context)
                            .add(InputEvent(firstName.text, "", "", "", ""));
                      },
                      validator: (value) {
                        String? val = value?.trim();
                        if (val == null || val.isEmpty) {
                          return AppLocalizations.of(context)!
                              .create_user_validation_msg;
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<CreateUserBloc, CreateUserState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: lastName,
                      decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.last_name_hinttext,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                          )),
                      onChanged: (val) {
                        BlocProvider.of<CreateUserBloc>(context)
                            .add(InputEvent(lastName.text, "", "", "", ""));
                      },
                      validator: (value) {
                        String? val = value?.trim();
                        if (val == null || val.isEmpty) {
                          return AppLocalizations.of(context)!
                              .create_user_validation_msg;
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<CreateUserBloc, CreateUserState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: userName,
                      decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.user_name_hinttext,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                          )),
                      onChanged: (val) {
                        BlocProvider.of<CreateUserBloc>(context)
                            .add(InputEvent(userName.text, "", "", "", ""));
                      },
                      validator: (value) {
                        String? val = value?.trim();
                        if (val == null || val.isEmpty) {
                          return AppLocalizations.of(context)!
                              .create_user_validation_msg;
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<CreateUserBloc, CreateUserState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.password_hinttext,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.primaryColor,
                          )),
                      onChanged: (val) {
                        BlocProvider.of<CreateUserBloc>(context)
                            .add(InputEvent(password.text, "", "", "", ""));
                      },
                      validator: (value) {
                        String? val = value?.trim();
                        if (val == null || val.isEmpty) {
                          return AppLocalizations.of(context)!
                              .create_user_validation_msg;
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<CreateUserBloc, CreateUserState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.user_role_text),
                        const SizedBox(
                          width: 30,
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                          ),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                            BlocProvider.of<CreateUserBloc>(context)
                                .add(InputEvent(value!, "", "", "", ""));
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<CreateUserBloc, CreateUserState>(
                  builder: (context, state) {
                    if (state is UserErrorState) {
                      if (state.errorMessage == "Please Pop") {
                        Navigator.pop(context);
                      }
                    }
                    if (state is UserCreatedState) {
                      Navigator.pop(context);
                    }
                    return SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (state is UserErrorState)
                                  ? AppColors.unavilableButtonColor
                                  : AppColors.primaryColor),
                          onPressed: (state is UserErrorState)
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<CreateUserBloc>(context)
                                        .add(CreateUserFBEvent(
                                            userName.text,
                                            firstName.text,
                                            lastName.text,
                                            password.text,
                                            dropdownValue));
                                  }
                                },
                          child: Text(
                              AppLocalizations.of(context)!.create_user_title),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
