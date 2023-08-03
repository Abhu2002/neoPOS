import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'create_product_bloc.dart';

class CreateProductForm extends StatefulWidget {
  const CreateProductForm({super.key});

  @override
  State<CreateProductForm> createState() => _CreateProductFormState();
}

class _CreateProductFormState extends State<CreateProductForm> {
  TextEditingController productName = TextEditingController();
  TextEditingController productType = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productCategory = TextEditingController();

  TextEditingController productImage = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productAvailability = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // CreateCategoryBloc? categoryReadBloc;

  @override
  void initState() {
    BlocProvider.of<CreateProductBloc>(context).add(const InputEvent(""));
    productName.text = "";
    productImage.text = "";
    super.initState();
  }

  // @override
  // void dispose() {
  //   categoryReadBloc!.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // categoryReadBloc = BlocProvider.of<CreateCategoryBloc>(context);
    context.read<CreateProductBloc>().showMessage = createSnackBar;

    return AlertDialog(
      // contentPadding: EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsPadding: const EdgeInsets.all(20),
      title: const Text(
        "Create Product",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor),
      ),
      actions: [
        Form(
          key: formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              children: [
                BlocBuilder<CreateProductBloc, CreateProductState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: productName,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.category_name,
                          prefixIcon: const Icon(
                            Icons.category,
                            color: AppColors.primaryColor,
                          )),
                      onChanged: (val) {
                        BlocProvider.of<CreateProductBloc>(context)
                            .add(InputEvent(productName.text));
                      },
                    );
                  },
                ),
                TextFormField(
                  controller: productType,
                  decoration: const InputDecoration(
                      hintText: "Product Type",
                      prefixIcon: Icon(
                        Icons.category,
                        color: AppColors.primaryColor,
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Product Type";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: productDescription,
                  decoration: const InputDecoration(
                      hintText: "Product Description",
                      prefixIcon: Icon(
                        Icons.category,
                        color: AppColors.primaryColor,
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Product Description";
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<CreateProductBloc, CreateProductState>(
                  builder: (context, state) {
                    if (state is ProductErrorState) {
                      if (state.errorMessage == "Error creating product") {
                        Navigator.pop(context);
                      }
                    }
                    if (state is ProductCreatedState) {
                      if (state.created == true) {
                        Navigator.pop(context);
                        state.created = false;
                      }
                    }
                    return SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (state is ProductErrorState)
                                  ? AppColors.unavilableButtonColor
                                  : AppColors.primaryColor),
                          onPressed: (state is ProductErrorState)
                              ? null
                              : () {
                                  BlocProvider.of<CreateProductBloc>(context)
                                      .add(CreateProductFBEvent(
                                    productName.text,
                                    productType.text,
                                    productDescription.text,
                                    productCategory.text,
                                    productImage.text,
                                    productPrice.text as int,
                                    productAvailability.text as bool,
                                  ));
                                },
                          child: const Text("Create Product"),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),

        // ActionButton(text: "Create Table", onPress: () {})
      ],
    );
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
