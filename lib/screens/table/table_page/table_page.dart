import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/table/table_page/table_bloc.dart';
import '../table_operation/create_operation/create_table_dialog.dart';

import '../table_operation/delete_operation/delete_table_dialog.dart';
import '../table_operation/update_operation/table_update_dialog.dart';

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
                                builder: (context) => const CreateTableForm())
                            .then((value) => BlocProvider.of<TableBloc>(context)
                                .add(InitialEvent()));
                      },
                      child: const Text("Create")),
                ),
              ),
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 210,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemBuilder: (context, i) => Card(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    PopupMenuButton<TableItem>(
                                        initialValue: selectedMenu,
                                        icon: const Icon(
                                            Icons.more_vert_outlined,
                                            color: Colors.black),
                                        color: Colors.white,
                                        itemBuilder: (context) =>
                                            <PopupMenuEntry<TableItem>>[
                                              const PopupMenuItem<TableItem>(
                                                  value: TableItem.tableEdit,
                                                  child: Icon(Icons.edit)),
                                              const PopupMenuItem<TableItem>(
                                                  value: TableItem.tableDelete,
                                                  child: Icon(Icons.delete))
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
                                                  BlocProvider.of<TableBloc>(
                                                          context)
                                                      .add(InitialEvent()));
                                            case "tableEdit":
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      UpdateTableForm(
                                                        docID: data[i]["docID"],
                                                        tableName: data[i]
                                                            ["tablename"],
                                                        tableCapacity: data[i]
                                                            ["tablecapacity"],
                                                      )).then((value) =>
                                                  BlocProvider.of<TableBloc>(
                                                          context)
                                                      .add(InitialEvent()));
                                          }
                                        }),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text((data[i]["tablename"])),
                                ),
                                Text(
                                    "Capacity: ${(data[i]["tablecapacity"]).toString()}"),
                              ],
                            ),
                          ),
                        ),
                      )),
            ),
          ],
        );
      } else {
        return const SizedBox(
          height: 200,
            width: 200,
            child: Center(child: CircularProgressIndicator()));
      }
    });
  }
}
