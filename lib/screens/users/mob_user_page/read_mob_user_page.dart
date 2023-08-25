import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../user_operations/user_create/create_user_dialog.dart';
import '../user_operations/user_delete/delete_user_dialog.dart';
import '../user_operations/user_update/update_user_dialog.dart';
import '../user_page/read_user_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserMobileRead extends StatefulWidget {
  const UserMobileRead({super.key});

  @override
  State<UserMobileRead> createState() => _UserMobileReadState();
}

class _UserMobileReadState extends State<UserMobileRead> {
  @override
  void initState() {
    BlocProvider.of<ReadUserBloc>(context).add(InitialEvent(true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadUserBloc, ReadUserState>(
      builder: (context, state) {
        if (state is DataLoadedState) {
          return Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                color: Colors.orange.shade600,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                        child: Text(
                      AppLocalizations.of(context)!.sr,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                    Expanded(
                        child: Text(
                      AppLocalizations.of(context)!.user_name_text,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                    const Expanded(child: SizedBox())
                  ],
                ),
              ),
              Container(
                color: Colors.grey.shade100,
                height: MediaQuery.sizeOf(context).height * 0.8,
                child: Stack(alignment: Alignment.bottomRight, children: [
                  ListView.builder(
                    itemCount: state.all.length,
                    itemBuilder: (context, index) {
                      final data = state.all[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          leading: Text('${data.sr}'),
                          title: Center(child: Text('     ${data.userid}')),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => UpdateUserForm(
                                      docId: data.id,
                                      oldFirstName: data.firstname,
                                      oldLastName: data.lastname,
                                      oldPassword: data.password,
                                      oldUserId: data.userid,
                                    ),
                                  ).then((value) =>
                                      BlocProvider.of<ReadUserBloc>(context)
                                          .add(InitialEvent(false)));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => DeleteUserPopup(
                                      docID: data.id!,
                                    ),
                                  ).then((value) =>
                                      BlocProvider.of<ReadUserBloc>(context)
                                          .add(InitialEvent(false)));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        showDialog(
                                context: context,
                                builder: (context) => const CreateUserForm())
                            .then((value) =>
                                BlocProvider.of<ReadUserBloc>(context)
                                    .add(InitialEvent(false)));
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ]),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
