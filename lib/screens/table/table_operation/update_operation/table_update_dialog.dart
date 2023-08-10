import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'update_bloc.dart';
import 'update_event.dart';
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
    return AlertDialog(
      title: PopUpRow(title: AppLocalizations.of(context)!.update_table_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              newName = value;
              tableName.value = TextEditingValue(
                text: value.toUpperCase(),
                selection: tableName.selection,
              );
            },
            controller: tableName,
            decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)!.new_category_name_hinttext),
          ),
          TextField(
            onChanged: (value) => newCapacity = value,
            controller: TextEditingController(text: widget.tableCapacity),
            decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)!.new_table_capacity_hinttext),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(context)!.cancel_button),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.update_button),
          onPressed: () {
            if (tableName.trim().isNotEmpty) {
              BlocProvider.of<TableUpdateBloc>(context).add(
                TableUpdateRequested(widget.docID, tableName.text, newCapacity),
              );
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
