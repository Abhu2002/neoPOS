import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../category_operation/create_operation/create_category_dialog.dart';
import '../category_operation/delete_operation/delete_category_dialog.dart';
import '../category_operation/update_operation/category_update_dialog.dart';
import '../category_page/read_category_bloc.dart';

class CategoryMobileRead extends StatefulWidget {
  const CategoryMobileRead({super.key});

  @override
  State<CategoryMobileRead> createState() => _CategoryMobileReadState();
}

class _CategoryMobileReadState extends State<CategoryMobileRead> {
  @override
  void initState() {
    BlocProvider.of<ReadCategoryBloc>(context).add(InitialEvent(true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ReadCategoryBloc>().showMessage = createSnackBar;
    return BlocBuilder<ReadCategoryBloc, ReadCategoryState>(
      builder: (context, state) {
        if (state is DataLoadedState) {
          return Container(
            color: Colors.grey.shade100,
            height: MediaQuery.sizeOf(context).height * 0.9,
            child: Stack(alignment: Alignment.bottomRight, children: [
              ListView.builder(
                itemCount: state.all.length,
                itemBuilder: (context, index) {
                  final category = state.all[index];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      leading: Text('${category.sr}'),
                      title: Text(category.categoryName ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => UpdateCategoryForm(
                                    id: category.id,
                                    oldName: category.categoryName),
                              ).then((value) =>
                                  BlocProvider.of<ReadCategoryBloc>(context)
                                      .add(InitialEvent(false)));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => DeleteCategoryPopup(
                                  categoryID: category.id!,
                                ),
                              ).then((value) =>
                                  BlocProvider.of<ReadCategoryBloc>(context)
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
                            builder: (context) => const CreateCategoryForm())
                        .then((value) =>
                            BlocProvider.of<ReadCategoryBloc>(context)
                                .add(InitialEvent(false)));
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ]),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
