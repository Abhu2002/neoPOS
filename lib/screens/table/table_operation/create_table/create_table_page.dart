import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:neopos/utils/action_button.dart';
import 'package:neopos/utils/app_colors.dart';
// import 'package:neopos/utils/common_text.dart';

import 'create_table_bloc.dart';

class CreateTableForm extends StatefulWidget {
  const CreateTableForm({super.key});

  @override
  State<CreateTableForm> createState() => _CreateTableFormState();
}

class _CreateTableFormState extends State<CreateTableForm> {
  TextEditingController tableName = TextEditingController();
  TextEditingController tableCap = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CreateTableBloc>(context).add(const InputEvent("", ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // contentPadding: EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: const Text(
        "Create Table",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor),
      ),
      actions: [
        BlocBuilder<CreateTableBloc, CreateTableState>(
          builder: (context, state) {
            return TextFormField(
              controller: tableName,
              decoration: const InputDecoration(
                  hintText: "Table Name",
                  prefixIcon: Icon(
                    Icons.table_bar,
                    color: AppColors.primaryColor,
                  )),
              onChanged: (val) {
                BlocProvider.of<CreateTableBloc>(context)
                    .add(InputEvent(tableName.text, tableCap.text));
              },
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<CreateTableBloc, CreateTableState>(
          builder: (context, state) {
            return TextFormField(
              keyboardType: TextInputType.number,
              controller: tableCap,
              decoration: const InputDecoration(
                  hintText: "Table Capacity",
                  prefixIcon: Icon(
                    Icons.group_add,
                    color: AppColors.primaryColor,
                  )),
              onChanged: (val) {
                BlocProvider.of<CreateTableBloc>(context)
                    .add(InputEvent(tableName.text, tableCap.text));
              },
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<CreateTableBloc, CreateTableState>(
          builder: (context, state) {
            if (state is TableCreatedState) {
              Navigator.pop(context);
            }
            return SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: (state is TableErrorState)
                          ? AppColors.unavilableButtonColor
                          : AppColors.primaryColor),
                  child: Text("Create Table"),
                  onPressed: (state is TableErrorState)
                      ? null
                      : () {
                          BlocProvider.of<CreateTableBloc>(context).add(
                              CreateTableFBEvent(
                                  tableName.text, tableCap.text));
                        },
                ));
          },
        ),
        // ActionButton(text: "Create Table", onPress: () {})
      ],
    );
  }
}
