import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_bloc.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/update_build_image.dart';
import '../create_operation/create_product_dialog.dart';
import 'package:neopos/utils/utils.dart';

var categoryVal = "Select Category";

class UpdateProductDialog extends StatefulWidget {
  final String image;
  final String id;
  final String productName;
  final String productDescription;
  final String productCategory;
  final String productType;
  final bool productAvailability;
  final int productPrice;

  const UpdateProductDialog(
      {super.key,
      required this.image,
      required this.id,
      required this.productName,
      required this.productDescription,
      required this.productType,
      required this.productAvailability,
      required this.productPrice,
      required this.productCategory});

  @override
  State<UpdateProductDialog> createState() => _UpdateProductDialogState();
}

class _UpdateProductDialogState extends State<UpdateProductDialog> {
  List<dynamic> _productCategories = [];
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productTypeController = TextEditingController();
  XFile? imageFile;
  late ProductType? type;
  late bool isCheck;
  @override
  void initState() {
    BlocProvider.of<UpdateProductBloc>(context).add(InitialCategoryEvent());
    _productNameController.text = widget.productName;
    _productPriceController.text = "${widget.productPrice}";
    _productDescriptionController.text = widget.productDescription;
    _productTypeController.text = widget.productType;

    widget.productAvailability ? isCheck = true : isCheck = false;
    widget.productType == "veg"
        ? type = ProductType.veg
        : type = ProductType.nonVeg;
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    context.read<UpdateProductBloc>().showMessage = createSnackBar;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      actionsPadding: const EdgeInsets.all(20),
      title:
          PopUpRow(title: AppLocalizations.of(context)!.update_product_title),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context)!.product_name_title,
                      prefixIcon: const Icon(
                        Icons.restaurant_menu,
                        color: AppColors.primaryColor,
                      )),
                  onChanged: (value) {
                    _productNameController.value = TextEditingValue(
                      text: value.toUpperCase(),
                      selection: _productNameController.selection,
                    );
                  },
                  validator: (val) {
                    if (!val.isValidProductName) {
                      return AppLocalizations.of(context)!.valid_product_name;
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _productPriceController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context)!.product_price_text,
                      prefixIcon: const Icon(
                        Icons.price_change,
                        color: AppColors.primaryColor,
                      )),
                  validator: (val) {
                    if (!val.isValidProductName) {
                      return AppLocalizations.of(context)!.valid_price;
                    }else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: _productDescriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                            .product_description_title,
                        prefixIcon: const Icon(
                          Icons.description,
                          color: AppColors.primaryColor,
                        )),
                    validator: (val) {
                      if (!val.isValidDesc) {
                        return AppLocalizations.of(context)!.valid_description;
                      }else{
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<UpdateProductBloc, ProductState>(
                  buildWhen: (previous, current) {
                    if (current is ProductTypeUpdateState) {
                      type = current.type;
                    }
                    return current is ProductTypeUpdateState;
                  },
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.product_type_title,
                          style: const TextStyle(
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
                        Text(AppLocalizations.of(context)!.veg_text),
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
                        Text(AppLocalizations.of(context)!.non_veg_text),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.product_category_title,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
                      value: isCheck,
                      onChanged: (bool? val) {
                        setState(() {
                          isCheck = val!;
                        });
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
                              BlocProvider.of<UpdateProductBloc>(context).add(
                                ImageChangedUpdateEvent(pickedFile),
                              );
                              imageFile = state.imageFile;
                            }
                          },
                          child:
                              Text(AppLocalizations.of(context)!.select_image),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        BlocBuilder<UpdateProductBloc, ProductState>(
          builder: (BuildContext context, state) {
            if (state is ProductImageUpdating) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductImageUpdated) {
              if (state.created == true) {
                state.created = false;
                Navigator.pop(context);
                BlocProvider.of<UpdateProductBloc>(context)
                    .add(InitialCategoryEvent());
              }
            }
            return SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String productName = _productNameController.text.trim();
                  double productPrice =
                      double.tryParse(_productPriceController.text) ?? 0.0;

                  BlocProvider.of<UpdateProductBloc>(context)
                      .add(UpdatingImageEvent());

                  if (productName.isNotEmpty && productPrice > 0.0) {
                    BlocProvider.of<UpdateProductBloc>(context).add(
                        UpdateProductEvent(
                            productId: widget.id,
                            productName: productName,
                            productDescription:
                                _productDescriptionController.text.trim(),
                            productPrice: productPrice,
                            productType: type!.name,
                            productUpdatedTime:
                                DateFormat("yyyy-MM-dd hh:mm:ss")
                                    .format(DateTime.now()),
                            imageFile: state.imageFile,
                            oldImage: widget.image,
                            productCategory: categoryVal,
                            productAvailability: isCheck));
                  }
                },
                child: Text(AppLocalizations.of(context)!.update_button),
              ),
            );
          },
        ),
        /*  SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _updateProduct(context);
            },
            child: Text(AppLocalizations.of(context)!.update_button),
          ),
        ),*/
      ],
    );
  }

  /* void _updateProduct(BuildContext context) {
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
  } */

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class CustomDropDown extends StatefulWidget {
  final List categories;
  final String? dropdownvalue;

  const CustomDropDown({required this.categories, super.key, this.dropdownvalue});

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
