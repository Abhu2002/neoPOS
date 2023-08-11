import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'update_bloc.dart';
import 'package:neopos/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//pass table name and table id to update the table..

class UpdateTableForm extends StatefulWidget {
  final String docID;
  final String tableName;
  final String tableCapacity;
  const UpdateTableForm(
      {super.key,
      required this.docID,
      required this.tableName,
      required this.tableCapacity});

  @override
  State<UpdateTableForm> createState() => _UpdateTableFormState();
}

class _UpdateTableFormState extends State<UpdateTableForm> {
  final formkey = GlobalKey<FormState>();
  TextEditingController tableName = TextEditingController();

  @override
  void initState() {
    tableName.text = widget.tableName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String newName = widget.tableName;
    String newCapacity = widget.tableCapacity;
    context.read<TableUpdateBloc>().showMessage = createSnackBar;
    return AlertDialog(
      title: PopUpRow(title: AppLocalizations.of(context)!.update_table_title),
      content:Form(
      key:formkey,
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
          validator: (val) {
      if (!val.isValidName) {
        return AppLocalizations.of(context)!.valid_table_name;
      }else{return null;}
      },
            onChanged: (value) => newName = value,
            controller: TextEditingController(text: widget.tableName),
            decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)!.new_category_name_hinttext),
          ),
          TextFormField(
              validator: (val) {
      if (!val.isValidTableCap) {
        return AppLocalizations.of(context)!.valid_table_cap;
      }else{return null;}},
            onChanged: (value) => newCapacity = value,
            controller: TextEditingController(text: widget.tableCapacity),
            decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)!.new_table_capacity_hinttext),

          )
        ],
      ),
    ),
      actions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(context)!.cancel_button),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.update_button),
          onPressed: () {
            if (formkey.currentState!.validate()) {
              BlocProvider.of<TableUpdateBloc>(context).add(
                TableUpdateRequested(widget.docID, newName, newCapacity),
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
