import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'package:neopos/utils/utils.dart';
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
    tableName.text = "";
    tableCap.text = "";
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    context.read<CreateTableBloc>().showMessage = createSnackBar;
    return AlertDialog(
      // contentPadding: EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: PopUpRow(
        title: AppLocalizations.of(context)!.create_table,
      ),
      actions: [
        BlocListener<CreateTableBloc, CreateTableState>(
          listener: (context, state) {
            if (state is TableNameNotAvailableState) {
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
                            AppLocalizations.of(context)!.tb_name_exist,
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<CreateTableBloc>(context)
                                    .add(TableNameNotAvailableEvent());
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
          child: const Text(""),
        ),
        SizedBox(
          width: (MediaQuery.of(context).size.width > 850)
              ? MediaQuery.of(context).size.width / 2
              : MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: tableName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.table_name,
                        prefixIcon: const Icon(
                          Icons.table_bar,
                          color: AppColors.primaryColor,
                        )),
                    onChanged: (value) {
                      tableName.value = TextEditingValue(
                          text: value.toUpperCase(),
                          selection: tableName.selection);
                    },
                    validator: (val) {
                      if (!val.isValidName) {
                        return AppLocalizations.of(context)!.valid_table_name;
                      } else {
                        return null;
                      }
                    }),
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
                        if (!val.isValidTableCap) {
                          return AppLocalizations.of(context)!.valid_table_cap;
                        } else {
                          return null;
                        }
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
                              backgroundColor: AppColors.primaryColor),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<CreateTableBloc>(context).add(
                                  CreateTableFBEvent(
                                      tableName.text, tableCap.text));
                            }
                          },
                          child:
                              Text(AppLocalizations.of(context)!.create_table),
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
