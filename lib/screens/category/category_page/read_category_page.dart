import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/category/category_page/read_category_bloc.dart';
import '../category_operation/create_operation/create_category_dialog.dart';
import '../category_operation/delete_operation/delete_category_dialog.dart';
import '../category_operation/update_operation/category_update_dialog.dart';



class CategoryRead extends StatefulWidget {
  const CategoryRead({super.key});

  @override
  State<CategoryRead> createState() => _CategoryReadState();
}

class _CategoryReadState extends State<CategoryRead> {
  final List<Map<String, String>> listOfColumns = [
    {"ID": "1", "Category": "Starter", "Operation": ""},
  ];

  @override
  void initState() {
    BlocProvider.of<ReadCategoryBloc>(context).add(InitialEvent());
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
                            builder: (context) => const CreateCategoryForm())
                        .then((value) =>
                            BlocProvider.of<ReadCategoryBloc>(context)
                                .add(InitialEvent()));
                  },
                  child: const Text("Create")),
            ),
          ),
        ]),
        BlocBuilder<ReadCategoryBloc, ReadCategoryState>(
          builder: (context, state) {
            if (state is DataLoadedState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Category Name')),
                    DataColumn(label: Text('Operation')),
                  ],
                  rows: state
                      .all // Loops through dataColumnText, each iteration assigning the value to element
                      .map(
                        ((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(element[
                                    "Id"]!)), //Extracting from Map element the value
                                DataCell(Text(element["Category"]!)),
                                DataCell(Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  UpdateCategoryForm(
                                                      id: element['Id'],
                                                      oldName:
                                                          element['Category']),
                                            ).then((value) => BlocProvider.of<
                                                    ReadCategoryBloc>(context)
                                                .add(InitialEvent()));
                                          },
                                          child: const Text("Update")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  DeleteCategoryPopup(
                                                categoryID: element["Id"]!,
                                              ),
                                            ).then((value) => BlocProvider.of<
                                                    ReadCategoryBloc>(context)
                                                .add(InitialEvent()));
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
