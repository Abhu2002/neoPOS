import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/table/table_operation/table_read/table_bloc.dart';
import 'package:neopos/models/table_model.dart';

enum TableItem { tabledelete, tableedit }

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
    BlocProvider.of<TableBloc>(context).add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableBloc, TableState>(builder: (context, state) {
      if (state is TableLoadedState) {
        List data = state.all;
        print(data);
        return Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        print('clicked button');
                        /*showDialog(
                            context: context,
                            builder: (context) => const CreateCategoryForm())
                        .then((value) =>
                            BlocProvider.of<ReadCategoryBloc>(context)
                                .add(InitialEvent()));*/
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
      } else if (state is TableLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Container(
          color: Colors.red,
          width: 200,
          height: 200,
        );
      }
    });
  }
}
