import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'create_table_bloc.dart';
import 'package:neopos/utils/utils.dart';

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
    tableName.text = "";
    tableCap.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<CreateTableBloc>().showMessage = createSnackBar;
    final formKey = GlobalKey<FormState>(); //
    return AlertDialog(
      // contentPadding: EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: PopUpRow(
        title: AppLocalizations.of(context)!.create_table,
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child:Form(
          key:formKey,
          child:Column(
            children: [
              BlocBuilder<CreateTableBloc, CreateTableState>(
                builder: (context, state) {
                  return TextFormField(
                    controller: tableName,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.table_name,
                        prefixIcon: const Icon(
                          Icons.table_bar,
                          color: AppColors.primaryColor,
                        )),
                      validator: (val) {
                        if (!val.isValidName) return "Enter a Valid Table Name";
                      },
                    onChanged: (val) {
                      tableName.value = TextEditingValue(
                        text: val.toUpperCase(),
                        selection: tableName.selection,
                      );
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
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.table_cap,
                        prefixIcon: const Icon(
                          Icons.group_add,
                          color: AppColors.primaryColor,
                        )),
                    validator: (val) {
                      if (!val.isValidTableCap)
                        return "Enter a Valid Table Name";
                    },
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
                  if (state is TableErrorState) {
                    if (state.errorMessage == "Please Pop") {
                      Navigator.pop(context);
                    }
                  }
                  if (state is TableCreatedState) {
                    if (state.isCreated == true) {
                      state.isCreated = false;
                      Navigator.pop(context);
                    }
                  }
                  return SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: (state is TableErrorState)
                                ? AppColors.unavilableButtonColor
                                : AppColors.primaryColor),
                        onPressed:
                        (state is TableErrorState)
                            ? null
                            : () {
    if (formKey.currentState!.validate()) {
                                BlocProvider.of<CreateTableBloc>(context).add(
                                    CreateTableFBEvent(
                                        tableName.text, tableCap.text));
                              }
                               },

                        child: Text(AppLocalizations.of(context)!.create_table),
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
