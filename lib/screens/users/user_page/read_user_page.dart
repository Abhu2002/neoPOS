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
                        Expanded(
                            child: Text(
                          AppLocalizations.of(context)!.added_on,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                        Expanded(
                            child: Text(
                          AppLocalizations.of(context)!.updated_on_text,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                        Expanded(
                          child: Text(
                            "",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.sizeOf(context).height - 174,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        itemCount: state.all.length,
                        separatorBuilder: (context, index) => Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                        itemBuilder: (context, index) {
                          var data = state.all[index];
                          return SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: Row(children: [
                              const SizedBox(width: 20),
                              Expanded(child: Text("${index + 1}")),
                              Expanded(child: Text(data.userid!)),
                              Expanded(child: Text(data.addedon!)),
                              Expanded(child: Text(data.updatedon!)),
                              Expanded(
                                child: Row(
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
                                                docId: data.id,
                                                oldFirstName: data.firstname,
                                                oldLastName: data.lastname,
                                                oldPassword: data.password,
                                                oldUserId: data.userid,
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
                                                docID: data.id!,
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
                                ),
                              )
                            ]),
                          );
                        },
                      )),
                ],
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
