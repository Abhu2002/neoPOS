import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neopos/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'create_user_bloc.dart';


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
  String dropdownvalue="";

  final formKey = GlobalKey<FormState>();
  static const List<String> list = <String>['Admin','Waiter'];
  String dropdownValue = list.first;

  @override
  void initState() {
    BlocProvider.of<CreateUserBloc>(context).add(const InputEvent("","","","",""));
    userName.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<CreateUserBloc>().showMessage = createSnackBar;
    return AlertDialog(
      // contentPadding: EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: Text(
        AppLocalizations.of(context)!.create_category,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor),
      ),
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
                          hintText: "first name",
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                          )),
                      onChanged: (val) {
                        BlocProvider.of<CreateUserBloc>(context)
                            .add(InputEvent(firstName.text,"","","",""));
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
                          hintText: "Last Name",
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                          )),
                      onChanged: (val) {
                        BlocProvider.of<CreateUserBloc>(context)
                            .add(InputEvent(lastName.text,"","","",""));
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
                          hintText: "User Name",
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                          )),
                      onChanged: (val) {
                        BlocProvider.of<CreateUserBloc>(context)
                            .add(InputEvent(userName.text,"","","",""));
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
                          hintText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.primaryColor,
                          )),
                      onChanged: (val) {
                        BlocProvider.of<CreateUserBloc>(context)
                            .add(InputEvent(password.text,"","","",""));
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<CreateUserBloc, CreateUserState>(
                  builder: (context, state) {
                    return DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                          dropdownvalue=value!;
                        });
                        BlocProvider.of<CreateUserBloc>(context)
                            .add(InputEvent(value!,"","","",""));
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                          child: Text("Create User"),
                          onPressed: (state is UserErrorState)
                              ? null
                              : () {
                            BlocProvider.of<CreateUserBloc>(context).add(
                                CreateUserFBEvent(
                                    userName.text,firstName.text,lastName.text,password.text,dropdownvalue));
                          },
                        ));
                  },
                ),
              ],
            ),
          ),
        ),

        // ActionButton(text: "Create Table", onPress: () {})
      ],
    );
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
