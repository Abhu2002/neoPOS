import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/users/user_page/read_user_bloc.dart';
import '../../../utils/app_colors.dart';
import '../user_operations/user_create/create_user_dialog.dart';
import '../user_operations/user_delete/delete_user_dialog.dart';
import '../user_operations/user_update/update_user_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserRead extends StatefulWidget {
  const UserRead({super.key});

  @override
  State<UserRead> createState() => _UserReadState();
}

class _UserReadState extends State<UserRead> {
  @override
  void initState() {
    BlocProvider.of<ReadUserBloc>(context).add(InitialEvent(true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(AppLocalizations.of(context)!.userpage_title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      minimumSize: const Size(88, 36),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: () {
                    showDialog(
                            context: context,
                            builder: (context) => const CreateUserForm())
                        .then((value) => BlocProvider.of<ReadUserBloc>(context)
                            .add(InitialEvent(false)));
                  },
                  child: Text(AppLocalizations.of(context)!.create_button)),
            ),
          ),
        ]),
        BlocBuilder<ReadUserBloc, ReadUserState>(
          builder: (context, state) {
            if (state is DataLoadedState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  headingTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainTextColor),
                  columns: [
                    DataColumn(
                        label: Flexible(
                            child: Text(
                                AppLocalizations.of(context)!.user_name_text))),
                    DataColumn(
                        label: Flexible(
                            child:
                                Text(AppLocalizations.of(context)!.added_on))),
                    DataColumn(
                        label: Flexible(
                            child: Text(AppLocalizations.of(context)!
                                .updated_on_text))),
                    DataColumn(
                        label: Text(
                            AppLocalizations.of(context)!.operations_text)),
                  ],
                  rows: state
                      .all // Loops through dataColumnText, each iteration assigning the value to element
                      .map(
                        ((element) => DataRow(
                              cells: <DataCell>[
                                //Extracting from Map element the value
                                DataCell(Text(element.userid!)),
                                DataCell(Text(element.addedon!)),
                                DataCell(Text(element.updatedon!)),
                                DataCell(Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  UpdateUserForm(
                                                docId: element.id,
                                                oldFirstName: element.firstname,
                                                oldLastName: element.lastname,
                                                oldPassword: element.password,
                                                oldUserId: element.userid,
                                              ),
                                            ).then((value) =>
                                                BlocProvider.of<ReadUserBloc>(
                                                        context)
                                                    .add(InitialEvent(false)));
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: AppColors.mainTextColor,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  DeleteUserPopup(
                                                docID: element.id!,
                                              ),
                                            ).then((value) =>
                                                BlocProvider.of<ReadUserBloc>(
                                                        context)
                                                    .add(InitialEvent(false)));
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: AppColors.mainTextColor,
                                          )),
                                    )
                                  ],
                                )),
                              ],
                            )),
                      )
                      .toList(),
                ),
              );
            } else {
              return const SizedBox(
                  height: 200,
                  width: 200,
                  child: Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ],
    );
  }
}
