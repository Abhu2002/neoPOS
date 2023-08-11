import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:neopos/utils/utils.dart';
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
                BlocListener<CreateUserBloc, CreateUserState>(
                  listener: (context, state) {
                    if (state is UserNameNotAvailableState) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            actionsPadding: const EdgeInsets.all(20),
                            actions: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .usr_name_exist,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<CreateUserBloc>(context)
                                            .add(UserInitialEvent());
                                        Navigator.pop(context);
                                      },
                                      child: Text(AppLocalizations.of(context)!
                                          .ok_button)),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text(""),
                ),
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
                      validator: (value) {
                        if (!value.isValidName) {
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
                      validator: (val) {
                        if (!val.isValidName) {
                          return  AppLocalizations.of(context)!.valid_last_name;
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
                      validator: (val) {
                        if (!val.isValidUsername) {
                          return  AppLocalizations.of(context)!.valid_username;
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
                              AppLocalizations.of(context)!.password_title,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.primaryColor,
                          )),
                      validator: (val) {
                        if (!val.isValidPassword) {
                          return  AppLocalizations.of(context)!.valid_password;
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
                    if (state is UserCreatedState) {
                      if (state.created == true) {
                        Navigator.pop(context);
                        state.created = false;
                      }
                    }
                    return SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<CreateUserBloc>(context).add(
                                  CreateUserFBEvent(
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
