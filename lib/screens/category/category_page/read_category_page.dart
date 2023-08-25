import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/category/category_page/read_category_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import '../category_operation/create_operation/create_category_dialog.dart';
import '../category_operation/delete_operation/delete_category_dialog.dart';
import '../category_operation/update_operation/category_update_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryRead extends StatefulWidget {
  const CategoryRead({super.key});

  @override
  State<CategoryRead> createState() => _CategoryReadState();
}

class _CategoryReadState extends State<CategoryRead> {
  @override
  void initState() {
    BlocProvider.of<ReadCategoryBloc>(context).add(InitialEvent(true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ReadCategoryBloc>().showMessage = createSnackBar;
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(AppLocalizations.of(context)!.category_title,
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
                            builder: (context) => const CreateCategoryForm())
                        .then((value) =>
                            BlocProvider.of<ReadCategoryBloc>(context)
                                .add(InitialEvent(false)));
                  },
                  child: Text(AppLocalizations.of(context)!.create_button)),
            ),
          ),
        ]),
        BlocBuilder<ReadCategoryBloc, ReadCategoryState>(
          builder: (context, state) {
            if (state is DataLoadedState) {
              return Column(
                children: [
                  Container(
                    height: 50,
                    color: Colors.orange.shade600,
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              AppLocalizations.of(context)!.sr,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              AppLocalizations.of(context)!.category_name_title,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        // const SizedBox(width: 30),
                        Expanded(flex: 2, child: Text("")),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.sizeOf(context).height - 174,
                      child: ListView.separated(
                        itemCount: state.all.length,
                        separatorBuilder: (context, index) => Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                        itemBuilder: (context, index) {
                          var data = state.all[index];
                          return Container(
                            width: MediaQuery.sizeOf(context).width,
                            child: Row(children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(flex: 2, child: Text("${data.sr}")),
                              Expanded(flex: 3, child: Text(data.categoryName)),
                              Expanded(
                                flex: 2,
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
                                                  UpdateCategoryForm(
                                                      id: data.id,
                                                      oldName:
                                                          data.categoryName),
                                            ).then((value) => BlocProvider.of<
                                                    ReadCategoryBloc>(context)
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
                                                  DeleteCategoryPopup(
                                                categoryID: data.id!,
                                                    categoryName: data.categoryName,
                                              ),
                                            ).then((value) => BlocProvider.of<
                                                    ReadCategoryBloc>(context)
                                                .add(InitialEvent(false)));
                                          },
                                          child: const Icon(Icons.delete,
                                              color: AppColors.mainTextColor)),
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

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
