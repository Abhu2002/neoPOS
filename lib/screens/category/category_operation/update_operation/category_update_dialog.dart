import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'package:neopos/utils/utils.dart';
import '../../../../utils/app_colors.dart';
import 'category_update_bloc.dart';
import 'category_update_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//pass category name and category id to update the category..

class UpdateCategoryForm extends StatefulWidget {
  final String id;
  final String oldName;

  const UpdateCategoryForm(
      {super.key, required this.id, required this.oldName});

  @override
  State<UpdateCategoryForm> createState() => _UpdateCategoryFormState();
}

class _UpdateCategoryFormState extends State<UpdateCategoryForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String newName = widget.oldName;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title:
          PopUpRow(title: AppLocalizations.of(context)!.update_category_title),
      content: Form(
        key: formKey,
        child: TextFormField(
          onChanged: (value) => newName = value,
          validator: (val) {
            if (!val.isNotEmptyValidator) return "Enter a Valid Catgeory Name";
          },
          controller: TextEditingController(text: widget.oldName),
          decoration: InputDecoration(
              hintText:
                  AppLocalizations.of(context)!.new_category_name_hinttext,
              prefixIcon: const Icon(
                Icons.category,
                color: AppColors.primaryColor,
              )),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Update'),
          onPressed: () {
            print(formKey.currentState!.validate());
            if (formKey.currentState!.validate()) {
              BlocProvider.of<CategoryUpdateBloc>(context).add(
                CategoryUpdateRequested(widget.id, newName),
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
