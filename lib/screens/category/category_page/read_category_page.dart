import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/category/category_page/read_category_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import '../category_operation/create_operation/create_category_dialog.dart';
import '../category_operation/delete_operation/delete_category_dialog.dart';
import '../category_operation/update_operation/category_update_dialog.dart';

class CategoryRead extends StatefulWidget {
  const CategoryRead({super.key});

  @override
  State<CategoryRead> createState() => _CategoryReadState();
}

class _CategoryReadState extends State<CategoryRead> {
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
                  showBottomBorder: true,

                  headingTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainTextColor),
                  // Use the default value.

                  columns: const [
                    DataColumn(label: Text("SR")),
                    DataColumn(label: Flexible(child: Text('Category Name'))),
                    DataColumn(label: Text('Operation')),
                  ],
                  rows: state
                      .all // Loops through dataColumnText, each iteration assigning the value to element
                      .map(
                        ((element) => DataRow(
                              cells: <DataCell>[
                                //Extracting from Map element the value
                                DataCell(Text(element["sr"])),
                                DataCell(Text(element["Category"]!)),
                                DataCell(Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 0),
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
                                          child:const Icon(Icons.edit,color: AppColors.mainTextColor,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 0),
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
                                          child: const Icon(Icons.delete,color: AppColors.mainTextColor)),
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
