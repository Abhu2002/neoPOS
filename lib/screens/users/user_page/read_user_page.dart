import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neopos/screens/users/user_page/read_user_bloc.dart';

import '../user_operations/user_create/create_user_page.dart';
import '../user_operations/user_update/update_user_page.dart';


class UserRead extends StatefulWidget {
  const UserRead({super.key});

  @override
  State<UserRead> createState() => _UserReadState();
}

class _UserReadState extends State<UserRead> {
  @override
  void initState() {
    BlocProvider.of<ReadUserBloc>(context).add(InitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                            context: context,
                            builder: (context) => const CreateUserForm())
                        .then((value) =>
                            BlocProvider.of<ReadUserBloc>(context)
                                .add(InitialEvent()));
                  },
                  child: const Text("Create")),
            ),
          ),
        ]),
        BlocBuilder<ReadUserBloc, ReadUserState>(
          builder: (context, state) {
            if (state is DataLoadedState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Flexible(child: Text('User Name'))),
                    DataColumn(label: Text('Operations')),
                  ],
                  rows: state
                      .all // Loops through dataColumnText, each iteration assigning the value to element
                      .map(
                        ((element) => DataRow(
                              cells: <DataCell>[ //Extracting from Map element the value
                                DataCell(Text(element["user_id"]!)),
                                DataCell(Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  UpdateUserForm(
                                                      docId: element['Id'],
                                                      oldFirstName:element['first_name'],
                                                    oldLastName:element['last_name'],
                                                    oldPassword:element['password'],
                                                    oldUserId:element['user_id'],
                                                          ),
                                            ).then((value) => BlocProvider.of<
                                                    ReadUserBloc>(context)
                                                .add(InitialEvent()));
                                          },
                                          child: const Text("Update")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            // showDialog(
                                            //   context: context,
                                            //   builder: (context) =>
                                            //       DeleteUserPopup(
                                            //     categoryID: element["Id"]!,
                                            //   ),
                                            // ).then((value) => BlocProvider.of<
                                            //         ReadCategoryBloc>(context)
                                            //     .add(InitialEvent()));
                                          },
                                          child: const Text("Delete")),
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
              return const Text("Loading");
            }
          },
        ),
      ],
    );
  }
}
