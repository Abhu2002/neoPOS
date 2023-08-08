import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_bloc.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_event.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_state.dart';
import 'package:neopos/utils/popup_cancel_button.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/update_build_image.dart';
import '../create_operation/create_product_dialog.dart';

var categoryVal = "Select Category";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateProductDialog extends StatefulWidget {
  final String image;
  final String id;
  final String productName;
  final String productDescription;
  final String productCategory;
  final String productType;
  final bool productAvailibility;
  final int productPrice;

  UpdateProductDialog(
      {super.key,
      required this.image,
      required this.id,
      required this.productName,
      required this.productDescription,
      required this.productType,
      required this.productAvailibility,
      required this.productPrice,
      required this.productCategory});

  @override
  _UpdateProductDialogState createState() => _UpdateProductDialogState();
}

class _UpdateProductDialogState extends State<UpdateProductDialog> {
  List<dynamic> _productCategories = [];
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productTypeController = TextEditingController();
  XFile? imageFile;
  String _selectedProductType = "";
  late ProductType? type;

  @override
  void initState() {
    BlocProvider.of<UpdateProductBloc>(context).add(InitialCategoryEvent());
    _productNameController.text = widget.productName;
    _productPriceController.text = "${widget.productPrice}";
    _productDescriptionController.text = widget.productDescription;
    _productTypeController.text = widget.productType;
    if (widget.productType == "veg") {
      type = ProductType.veg;
    } else {
      type = ProductType.nonVeg;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      actionsPadding: const EdgeInsets.all(20),
      title: const PopUpRow(title: "Update"),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _productNameController,
                decoration: const InputDecoration(
                    labelText: 'Product Name',
                    prefixIcon: Icon(
                      Icons.restaurant_menu,
                      color: AppColors.primaryColor,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _productPriceController,
                decoration: const InputDecoration(
                    labelText: 'Product Price',
                    prefixIcon: Icon(
                      Icons.price_change,
                      color: AppColors.primaryColor,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _productDescriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 2,
                decoration: const InputDecoration(
                    labelText: 'Product Description',
                    prefixIcon: Icon(
                      Icons.description,
                      color: AppColors.primaryColor,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<UpdateProductBloc, ProductState>(
                buildWhen: (previous, current) {
                  if(current is ProductTypeUpdateState) {
                    type = current.type;
                  }
                  return current is ProductTypeUpdateState;
                },
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Product type",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Radio<ProductType>(
                        value: ProductType.veg,
                        groupValue: state.type ?? type,
                        onChanged: (ProductType? value) {
                          BlocProvider.of<UpdateProductBloc>(context)
                              .add(ProductTypeUpdateEvent(value!));
                        },
                      ),
                      const Text('Veg'),
                      const SizedBox(
                        width: 5,
                      ),
                      Radio<ProductType>(
                        value: ProductType.nonVeg,
                        groupValue: state.type ?? type,
                        onChanged: (ProductType? value) {
                          BlocProvider.of<UpdateProductBloc>(context)
                              .add(ProductTypeUpdateEvent(value!));
                        },
                      ),
                      const Text('Non Veg'),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    "Product category",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  BlocBuilder<UpdateProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is LoadedCategoryState) {
                        _productCategories = state.categories;
                        categoryVal = widget.productCategory;
                      }
                      return CustomDropDown(
                        categories: _productCategories,
                        dropdownvalue: categoryVal,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<UpdateProductBloc, ProductState>(
                builder: (BuildContext context, state) {
                  return Column(
                    children: [
                      const BuildUpdateImage(),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          final picker = ImagePicker();
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedFile != null) {
                            if (!context.mounted) return;
                            BlocProvider.of<UpdateProductBloc>(context)
                                .add(
                              ImageChangedUpdateEvent(pickedFile),
                            );
                            imageFile = state.imageFile;
                          }
                      },
                        child: const Text('Select Image'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _updateProduct(context);
            },
            child: const Text('UPDATE'),
          ),
        ),
      ],
    );
  }

  void _updateProduct(BuildContext context) {
    final productBloc = BlocProvider.of<UpdateProductBloc>(context);
    String productName = _productNameController.text.trim();
    double productPrice = double.tryParse(_productPriceController.text) ?? 0.0;

    if (productName.isNotEmpty && productPrice > 0.0) {
      productBloc.add(UpdateProductEvent(
          productId: widget.id,
          productName: productName,
          productDescription: _productDescriptionController.text.trim(),
          productPrice: productPrice,
          productType: type!.name,
          productUpdatedTime:
              DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
          imageFile: imageFile,
          oldImage: widget.image));

      Navigator.of(context).pop();
    }
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
    return BlocBuilder<UpdateProductBloc, ProductState>(
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
            BlocProvider.of<UpdateProductBloc>(context)
                .add(CategoryChangedEvent(newValue.toString()));
            categoryVal = newValue.toString();
          },
        );
      },
    );
  }
}
