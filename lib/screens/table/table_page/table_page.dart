import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/models/table_model.dart';
import 'package:neopos/screens/table/table_page/table_bloc.dart';

enum TableItem { tabledelete, tableedit }

class TableRead extends StatefulWidget {
  const TableRead({super.key});

  @override
  State<TableRead> createState() => _TableReadState();
}

class _TableReadState extends State<TableRead> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TablesBloc>(context).add(const LoadReadSuccessTable());
  }

  TableItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Table", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 193, 101, 14),
      ),
      body: BlocBuilder<TablesBloc, TableState>(builder: (context, state) {
        if (state is TableReadLoaded) {
          List<TableModel> data = state.mytables;

          return GridView.builder(
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
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
                                    icon: const Icon(Icons.more_vert_outlined,
                                        color: Colors.black),
                                    color: Colors.white,
                                    itemBuilder: (context) =>
                                        <PopupMenuEntry<TableItem>>[
                                          const PopupMenuItem<TableItem>(
                                              value: TableItem.tableedit,
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                          const PopupMenuItem<TableItem>(
                                              value: TableItem.tabledelete,
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ))
                                        ],
                                    onSelected: (TableItem item) {}),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text((data[i].tablename)),
                            ),
                            Text(
                                "Capacity: ${(data[i].tablecapacity).toString()}"),
                          ],
                        ),
                      ),
                    ),
                  ));
        } else if (state is TableReadLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      }),
    );
  }
}
