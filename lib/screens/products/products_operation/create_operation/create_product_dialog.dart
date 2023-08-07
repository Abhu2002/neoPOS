import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopos/utils/app_colors.dart';
import 'create_product_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var categoryValue = "Select Category";
bool initial = false;

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
  XFile? imageFile;
  final formKey = GlobalKey<FormState>();
  late var categories = [];

  bool isChecked = true;
  bool isVeg = false;
  bool isNonVeg = false;

  Widget? buildImage() {
    if (imageFile != null) {
      // Display image from the device gallery
      if (kIsWeb) {
        // For Flutter web, use Image.network
        return Image.network(imageFile!.path, height: 50, width: 150);
      } else {
        // For mobile platforms, use Image.file

        return null;
      }
    } else {
      return Text('No image selected');
    }
  }

  // CreateCategoryBloc? categoryReadBloc;

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

    return SingleChildScrollView(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        actionsPadding: const EdgeInsets.all(20),
        title: Text(
          AppLocalizations.of(context)!.create_product,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor),
        ),
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
                    Row(children: [
                      Text(
                        AppLocalizations.of(context)!.product_type,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Checkbox(
                          value: isVeg,
                          onChanged: (bool? val) {
                            setState(() {
                              if (isNonVeg) return;
                              isVeg = val!;
                            });
                          }),
                      Text(
                        AppLocalizations.of(context)!.veg,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Checkbox(
                          value: isNonVeg,
                          onChanged: (bool? value) {
                            setState(() {
                              if (isVeg) return;
                              isNonVeg = value!;
                            });
                          }),
                      Text(
                        AppLocalizations.of(context)!.non_veg,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ]),
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
                    Row(
                      children: [
                        buildImage()!,
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child:
                              Text(AppLocalizations.of(context)!.select_image),
                        ),
                      ],
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
                                      if (formKey.currentState!.validate() &&
                                          imageFile != null &&
                                          (!isVeg || !isNonVeg)) {
                                        String productType =
                                            isVeg ? 'Veg' : 'Non-Veg';
                                        BlocProvider.of<CreateProductBloc>(
                                                context)
                                            .add(CreateProductFBEvent(
                                          productName.text,
                                          productType,
                                          productDescription.text,
                                          categoryValue,
                                          imageFile!,
                                          int.parse(productPrice.text).toInt(),
                                          isChecked,
                                        ));
                                      } else if (imageFile == null) {
                                        return createSnackBar(
                                            "Select an image");
                                      } else {
                                        return createSnackBar(
                                            "Select product type");
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

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
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
    return DropdownButton(
      alignment: Alignment.centerLeft,
      value: widget.dropdownvalue,
      items: widget.categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          widget.dropdownvalue = newValue.toString();
          categoryValue = newValue.toString();
        });
      },
    );
  }
}
