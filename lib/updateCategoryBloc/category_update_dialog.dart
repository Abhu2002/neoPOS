import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_update_bloc.dart';
import 'category_update_event.dart';

//pass category name and category id to update the category..

void showUpdateCategoryDialog(BuildContext context, String categoryId, String oldName) {
  String newName = oldName;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Category'),
        content: TextField(
          onChanged: (value) => newName = value,
          controller: TextEditingController(text: oldName),
          decoration: InputDecoration(hintText: 'New category name'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Update'),
            onPressed: () {
              if (newName.trim().isNotEmpty) {
                BlocProvider.of<CategoryBloc>(context).add(
                  CategoryUpdateRequested(categoryId, newName),
                );
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}