import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'package:provider/provider.dart';
import '../../../../utils/build_image.dart';
import 'create_product_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';

var categoryValue = "Select Category";
bool initial = false;

enum ProductType { veg, nonVeg }

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

  final CreateProductBloc proTypeBloc = CreateProductBloc();
  final CreateProductBloc imageBloc = CreateProductBloc();

  XFile? imageFile;
  final formKey = GlobalKey<FormState>();
  late var categories = [];

  bool isChecked = true;
  bool priceValidated = true;

  @override
  void initState() {
    BlocProvider.of<CreateProductBloc>(context).add(InitialEvent());
    super.initState();
    productName.text = "";
    productImage.text = "";
  }

  @override
  Widget build(BuildContext context) {
    context.read<CreateProductBloc>().showMessage = createSnackBar;
    late ProductType? type;

    return SingleChildScrollView(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        actionsPadding: const EdgeInsets.all(20),
        title: PopUpRow(title: AppLocalizations.of(context)!.create_product),
        actions: [
          Center(
            child: Form(
              key: formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    BlocBuilder<CreateProductBloc, CreateProductState>(
                      builder: (context, state) {
                        return TextFormField(
                          controller: productName,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .enter_product_name;
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.product_name,
                              prefixIcon: const Icon(
                                Icons.restaurant_menu,
                                color: AppColors.primaryColor,
                              )),
                          onChanged: (val) {
                            BlocProvider.of<CreateProductBloc>(context)
                                .add(InputEvent(productName.text));
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CreateProductBloc, CreateProductState>(
                      buildWhen: (previous, current) {
                        if (current is ProductTypeState) {
                          type = current.type;
                        }
                        return current is ProductTypeState;
                      },
                      builder: (BuildContext context, state) {
                        return Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.product_type,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              // flex: 1,
                              child: Row(
                                children: [
                                  Radio<ProductType>(
                                    value: ProductType.veg,
                                    groupValue: state.type,
                                    onChanged: (ProductType? value) {
                                      BlocProvider.of<CreateProductBloc>(
                                              context)
                                          .add(ProductTypeEvent(value!));
                                      // type = state.type == ProductType.veg ? state.type : null;
                                      // print(state.type);
                                    },
                                  ),
                                  Flexible(
                                    child:
                                        Text(AppLocalizations.of(context)!.veg),
                                  ),
                                  Radio<ProductType>(
                                    value: ProductType.nonVeg,
                                    groupValue: state.type,
                                    onChanged: (ProductType? value) {
                                      BlocProvider.of<CreateProductBloc>(
                                              context)
                                          .add(ProductTypeEvent(value!));
                                      // type = state.type == ProductType.nonVeg ? state.type : null;
                                      // print(state.type);
                                    },
                                  ),
                                  Flexible(
                                    child: Text(
                                        AppLocalizations.of(context)!.non_veg),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: productDescription,
                      decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.product_description,
                          prefixIcon: const Icon(
                            Icons.description,
                            color: AppColors.primaryColor,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .enter_product_description;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: productPrice,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.product_price,
                          prefixIcon: const Icon(
                            Icons.price_check,
                            color: AppColors.primaryColor,
                          )),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .enter_product_price;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.select_category,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        BlocBuilder<CreateProductBloc, CreateProductState>(
                          builder: (context, state) {
                            if (state is CategoryLoadedState) {
                              categories = state.categories;
                              categoryValue = categories[0];
                            }
                            return CustomDropDown(
                              categories: categories,
                              dropdownvalue: categoryValue,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.product_available,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? val) {
                            setState(() {
                              isChecked = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CreateProductBloc, CreateProductState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            const BuildImage(),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  if (!context.mounted) return;
                                  BlocProvider.of<CreateProductBloc>(context)
                                      .add(
                                    ImageChangedEvent(pickedFile),
                                  );
                                  imageFile = state.imageFile;
                                }
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.select_image),
                            ),
                          ],
                        );
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
                        if (state is ProductCreatingState) {
                          return const CircularProgressIndicator();
                        }
                        if (state is ProductCreatedState) {
                          if (state.created == true) {
                            state.created = false;
                            Navigator.pop(context);
                            BlocProvider.of<CreateProductBloc>(context)
                                .add(InitialEvent());
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
                                      BlocProvider.of<CreateProductBloc>(
                                              context)
                                          .add(ProductCreatingEvent());
                                      if (formKey.currentState!.validate() &&
                                          state.imageFile != null &&
                                          type != null) {
                                        BlocProvider.of<CreateProductBloc>(
                                                context)
                                            .add(CreateProductFBEvent(
                                          productName.text,
                                          type!.name,
                                          productDescription.text,
                                          categoryValue,
                                          state.imageFile!,
                                          int.parse(productPrice.text).toInt(),
                                          isChecked,
                                        ));
                                      } else if (state.imageFile == null) {
                                        return createSnackBar(
                                            "Select an image");
                                      } else if (type == null) {
                                        return createSnackBar(
                                            "Type is not selected");
                                      }
                                    },
                              child: Text(
                                  AppLocalizations.of(context)!.create_product),
                            ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ActionButton(text: "Create Table", onPress: () {})
        ],
      ),
    );
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class CustomDropDown extends StatefulWidget {
  final List categories;
  String? dropdownvalue;

  CustomDropDown({required this.categories, super.key, this.dropdownvalue});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductBloc, CreateProductState>(
      builder: (BuildContext context, state) {
        return DropdownButton(
          alignment: Alignment.centerLeft,
          value: state.category ?? widget.dropdownvalue,
          items: widget.categories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (newValue) {
            BlocProvider.of<CreateProductBloc>(context)
                .add(CategoryChangedEvent(newValue.toString()));
            categoryValue = newValue.toString();
          },
        );
      },
    );
  }
}
