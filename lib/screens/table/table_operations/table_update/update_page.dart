import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/table/table_operations/table_update/update_bloc.dart';
import 'package:neopos/utils/utils.dart';

import '../../../../utils/action_button.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/common_text.dart';
import '../../../dashboard/dashboard_page.dart';

class TableUpdateAlert extends StatefulWidget {
  const TableUpdateAlert({super.key});

  @override
  State<TableUpdateAlert> createState() => _TableUpdateAlertState();
}

class _TableUpdateAlertState extends State<TableUpdateAlert> {
  @override
  Widget build(BuildContext context) {

    context.read<UpdateTableBloc>().onUpdateSuccess = onSuccess;
    context.read<UpdateTableBloc>().showMessage = createSnackBar;

    return AlertDialog(
      // contentPadding: EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: const Text(
        "Update Table",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor),
      ),
      actions: [
        BlocBuilder<UpdateTableBloc, UpdateTableState>(
          builder: (context, state) {
            return AuthCustomTextfield(
              hint: "Table Name",
              prefixIcon: Icons.table_bar,
              errorText: (!state.tableName.isNotEmptyValidator && state.verifyData)
                  ? "Enter table name" : null,
              onChange: (v) {
                context.read<UpdateTableBloc>().add(TableNameChanged(v));
              },
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<UpdateTableBloc, UpdateTableState>(
          builder: (context, state) {
            return AuthCustomTextfield(
              hint: "Table Capacity",
              prefixIcon: Icons.group,
              errorText: (!state.tableCapacity.toString().isNotEmptyValidator && state.verifyData)
                  ? "Enter table capacity" : null,
              onChange: (v) {
                context.read<UpdateTableBloc>().add(TableCapacityChanged(int.parse(v)));
              },
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<UpdateTableBloc, UpdateTableState>(
          builder: (context, state) {
            return ActionButton(
                text: "Update Table", onPress: () {
              context.read<UpdateTableBloc>().add(OnUpdate());
            });
          },
        ),
      ],
    );
  }

  void onSuccess() => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => const DashboardPage()));

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
