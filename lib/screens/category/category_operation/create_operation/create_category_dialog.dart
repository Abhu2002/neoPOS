import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'create_category_bloc.dart';
import 'dart:core';
import 'package:neopos/utils/utils.dart';

class CreateCategoryForm extends StatefulWidget {
  const CreateCategoryForm({super.key});

  @override
  State<CreateCategoryForm> createState() => _CreateCategoryFormState();
}

class _CreateCategoryFormState extends State<CreateCategoryForm> {
  TextEditingController categoryName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    categoryName.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<CreateCategoryBloc>().showMessage = createSnackBar;

    return AlertDialog(
      // contentPadding: EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: PopUpRow(title: AppLocalizations.of(context)!.create_category),
      actions: [
        BlocListener<CreateCategoryBloc, CreateCategoryState>(
          listener: (context, state) {
            if (state is NameNotAvailableState) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    actionsPadding: const EdgeInsets.all(20),
                    actions: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.cat_name_exist,
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
                                BlocProvider.of<CreateCategoryBloc>(context)
                                    .add(NotNameAvaiableEvent());
                                Navigator.pop(context);
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.ok_button)),
                        ],
                      )
                    ],
                  );
                },
              );
            }

          },
          child:const Text(""),
        ),
        Form(
          key: formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              children: [
                TextFormField(
                  controller: categoryName,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.category_name,
                      prefixIcon: const Icon(
                        Icons.category,
                        color: AppColors.primaryColor,
                      )),
                  onChanged: (value) {
                    categoryName.value = TextEditingValue(
                        text: value.toUpperCase(),
                        selection: categoryName.selection);
                  },
                  validator: (value) {
                    if (!value.isValidName) {
                      return AppLocalizations.of(context)!.valid_category;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<CreateCategoryBloc, CreateCategoryState>(
                  builder: (context, state) {
                    if (state is CategoryCreatedState) {
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
                              BlocProvider.of<CreateCategoryBloc>(context).add(
                                  CreateCategoryFBEvent(categoryName.text));
                            }
                          },
                          child: Text(AppLocalizations.of(context)!
                              .create_category_button),
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
