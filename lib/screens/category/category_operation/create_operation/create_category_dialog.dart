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

  // CreateCategoryBloc? categoryReadBloc;

  @override
  void initState() {
    BlocProvider.of<CreateCategoryBloc>(context).add(const InputEvent(""));
    categoryName.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // categoryReadBloc = BlocProvider.of<CreateCategoryBloc>(context);
    context.read<CreateCategoryBloc>().showMessage = createSnackBar;

    return AlertDialog(
      // contentPadding: EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: PopUpRow(title: AppLocalizations.of(context)!.create_category),
      actions: [
        Form(
          key: formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              children: [
                BlocBuilder<CreateCategoryBloc, CreateCategoryState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: categoryName,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (!val.isNotEmptyValidator)
                          return 'Enter valid Category Name';
                      },
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.category_name,
                          prefixIcon: const Icon(
                            Icons.category,
                            color: AppColors.primaryColor,
                          )),
                      onChanged: (val) {
                        categoryName.value = TextEditingValue(
                          text: val.toUpperCase(),
                          selection: categoryName.selection,
                        );
                        BlocProvider.of<CreateCategoryBloc>(context)
                            .add(InputEvent(categoryName.text));
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<CreateCategoryBloc, CreateCategoryState>(
                  builder: (context, state) {
                    if (state is CategoryErrorState) {
                      if (state.errorMessage == "Please Pop") {
                        Navigator.pop(context);
                      }
                    }
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
                              backgroundColor: (state is CategoryErrorState)
                                  ? AppColors.unavilableButtonColor
                                  : AppColors.primaryColor),
                          onPressed: (state is CategoryErrorState)
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<CreateCategoryBloc>(context)
                                        .add(CreateCategoryFBEvent(
                                            categoryName.text));
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

        // ActionButton(text: "Create Table", onPress: () {})
      ],
    );
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
