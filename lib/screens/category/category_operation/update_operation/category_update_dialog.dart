import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import '../../../../utils/app_colors.dart';
import 'category_update_bloc.dart';
import 'category_update_event.dart';

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
  @override
  Widget build(BuildContext context) {
    String newName = widget.oldName;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: const PopUpRow(title: 'Update Category'),
      content: TextField(
        onChanged: (value) => newName = value,
        controller: TextEditingController(text: widget.oldName),
        decoration: const InputDecoration(
            hintText: "New Category name",
            prefixIcon: Icon(
              Icons.category,
              color: AppColors.primaryColor,
            )),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Update'),
          onPressed: () {
            if (newName.trim().isNotEmpty) {
              BlocProvider.of<CategoryUpdateBloc>(context).add(
                CategoryUpdateRequested(widget.id, newName),
              );
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
