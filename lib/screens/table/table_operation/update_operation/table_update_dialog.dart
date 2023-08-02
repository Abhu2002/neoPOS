import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'update_bloc.dart';
import 'update_event.dart';

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
  @override
  Widget build(BuildContext context) {
    String newName = widget.tableName;
    String newCapacity = widget.tableCapacity;
    return AlertDialog(
      title: const Text('Update Table'),
      content: Column(
        children: [
          TextField(
            onChanged: (value) => newName = value,
            controller: TextEditingController(text: widget.tableName),
            decoration: const InputDecoration(hintText: 'New table name'),
          ),
          TextField(
            onChanged: (value) => newCapacity = value,
            controller: TextEditingController(text: widget.tableCapacity),
            decoration: const InputDecoration(hintText: 'New Table Capacity '),
          )
        ],
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
              BlocProvider.of<TableUpdateBloc>(context).add(
                TableUpdateRequested(widget.docID, newName, newCapacity),
              );
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
