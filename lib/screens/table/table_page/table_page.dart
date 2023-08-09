import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/table/table_page/table_bloc.dart';
import 'package:neopos/utils/app_colors.dart';

import '../table_operation/create_operation/create_table_dialog.dart';
import '../table_operation/delete_operation/delete_table_dialog.dart';
import '../table_operation/update_operation/table_update_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
enum TableItem { tableDelete, tableEdit } //enum for popup

class TableRead extends StatefulWidget {
  const TableRead({super.key});

  @override
  State<TableRead> createState() => _TableReadState();
}

class _TableReadState extends State<TableRead> {
  TableItem? selectedMenu;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TableBloc>(context).add(
        InitialEvent()); //creates connection and fetch all the map from firebase and add in the list
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableBloc, TableState>(builder: (context, state) {
      if (state is TableReadLoadedState) {
        List data = state.all;
        return LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(AppLocalizations.of(context)!.choose_table_title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          minimumSize: const Size(88, 36),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: () {
                        showDialog(
                                context: context,
                                builder: (context) => const CreateTableForm())
                            .then((value) => BlocProvider.of<TableBloc>(context)
                                .add(InitialEvent()));
                      },
                      child: Text(AppLocalizations.of(context)!.create_button)),
                ),
              ]),
              SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 210,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemBuilder: (context, i) => InkWell(
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: AppColors.tableAvailableColor,
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          PopupMenuButton<TableItem>(
                                              initialValue: selectedMenu,
                                              icon: const Icon(
                                                  Icons.more_vert_outlined,
                                                  color: Colors.black),
                                              color: Colors.white,
                                              itemBuilder: (context) =>
                                                  <PopupMenuEntry<TableItem>>[
                                                    const PopupMenuItem<
                                                            TableItem>(
                                                        value:
                                                            TableItem.tableEdit,
                                                        child: Text(
                                                          "Edit",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                    const PopupMenuItem<
                                                            TableItem>(
                                                        value: TableItem
                                                            .tableDelete,
                                                        child: Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ))
                                                  ],
                                              onSelected: (TableItem item) {
                                                switch (item.name) {
                                                  case "tableDelete":
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          DeleteTablePopup(
                                                        docID: data[i]["docID"],
                                                      ),
                                                    ).then((value) =>
                                                        BlocProvider.of<
                                                                    TableBloc>(
                                                                context)
                                                            .add(
                                                                InitialEvent()));
                                                  case "tableEdit":
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            UpdateTableForm(
                                                              docID: data[i]
                                                                  ["docID"],
                                                              tableName: data[i]
                                                                  ["tablename"],
                                                              tableCapacity: data[
                                                                      i][
                                                                  "tablecapacity"],
                                                            )).then((value) =>
                                                        BlocProvider.of<
                                                                    TableBloc>(
                                                                context)
                                                            .add(
                                                                InitialEvent()));
                                                }
                                              }),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          (data[i]["tablename"]),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                          "Capacity: ${(data[i]["tablecapacity"]).toString()}"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              )),
            ],
          );
        });
      } else {
        return const SizedBox(
            height: 200,
            width: 200,
            child: Center(child: CircularProgressIndicator()));
      }
    });
  }
}
