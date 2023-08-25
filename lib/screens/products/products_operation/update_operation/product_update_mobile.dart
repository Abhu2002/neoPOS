import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_bloc.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_availability_check.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_description.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_name.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_price.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_type.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../utils/update_build_image.dart';

import '../widgets/category_dropdown.dart';
import '../widgets/product_create_form.dart';

var categoryVal = "Select Category";

class UpdateProductMobile extends StatefulWidget {
  final String image;
  final String id;
  final String productName;
  final String productDescription;
  final String productCategory;
  final String productType;
  final bool productAvailability;
  final num productPrice;

  const UpdateProductMobile(
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
  State<UpdateProductMobile> createState() => _UpdateProductMobileState();
}

class _UpdateProductMobileState extends State<UpdateProductMobile> {
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
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 20, right: 8, left: 8),
              child: Column(
                children: [
                  PopUpRow(
                      title:
                          AppLocalizations.of(context)!.update_product_title),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width > 850)
                        ? MediaQuery.of(context).size.width * 0.5
                        : MediaQuery.of(context).size.width,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ProductName(
                            productName: _productNameController,
                            onProductNameChanged: (value) {
                              _productNameController.value = TextEditingValue(
                                text: value.toUpperCase(),
                                selection: _productNameController.selection,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // product price
                          ProductPrice(controller: _productPriceController),
                          const SizedBox(
                            height: 20,
                          ),
                          ProductDescription(
                            controller: _productDescriptionController,
                          ),
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
                              return ProductTypeSelect(
                                defaultType: type,
                                stateType: state.type,
                                onProductTypeChanged: (ProductType? value) {
                                  BlocProvider.of<UpdateProductBloc>(context)
                                      .add(ProductTypeUpdateEvent(value!));
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .product_category_title,
                                softWrap: true,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              BlocBuilder<UpdateProductBloc, ProductState>(
                                builder: (context, state) {
                                  if (state is LoadedCategoryState) {
                                    _productCategories = state.categories;
                                    categoryVal = widget.productCategory;
                                  }
                                  return CategoryDropDown(
                                    categories: _productCategories,
                                    dropdownvalue: categoryVal,
                                    onCategoryChanged: (newCategory) {
                                      categoryVal = newCategory.toString();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Product availability
                          ProductAvailabilityCheck(
                            isChecked: isCheck,
                            onAvailabilityChanged: (bool? val) {
                              setState(() {
                                isCheck = val!;
                              });
                            },
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
                                        BlocProvider.of<UpdateProductBloc>(
                                                context)
                                            .add(
                                          ImageChangedUpdateEvent(pickedFile),
                                        );
                                        imageFile = state.imageFile;
                                      }
                                    },
                                    child: Text(AppLocalizations.of(context)!
                                        .select_image),
                                  ),
                                  BlocBuilder<UpdateProductBloc, ProductState>(
                                    builder: (BuildContext context, state) {
                                      if (state is ProductImageUpdating) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (state is ProductImageUpdated) {
                                        if (state.created == true) {
                                          state.created = false;
                                          Navigator.pop(context);
                                          BlocProvider.of<UpdateProductBloc>(
                                                  context)
                                              .add(InitialCategoryEvent());
                                        }
                                      }
                                      return SizedBox(
                                        height: 40,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            String productName =
                                                _productNameController.text
                                                    .trim();
                                            double productPrice =
                                                double.tryParse(
                                                        _productPriceController
                                                            .text) ??
                                                    0.0;

                                            BlocProvider.of<UpdateProductBloc>(
                                                    context)
                                                .add(UpdatingImageEvent());

                                            if (productName.isNotEmpty &&
                                                productPrice > 0.0) {
                                              BlocProvider.of<
                                                          UpdateProductBloc>(
                                                      context)
                                                  .add(UpdateProductEvent(
                                                      productId: widget.id,
                                                      productName: productName,
                                                      productDescription:
                                                          _productDescriptionController
                                                              .text
                                                              .trim(),
                                                      productPrice:
                                                          productPrice,
                                                      productType: type!.name,
                                                      productUpdatedTime:
                                                          DateFormat(
                                                                  "yyyy-MM-dd hh:mm:ss")
                                                              .format(DateTime
                                                                  .now()),
                                                      imageFile:
                                                          state.imageFile,
                                                      oldImage: widget.image,
                                                      productCategory:
                                                          categoryVal,
                                                      productAvailability:
                                                          isCheck));
                                            }
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .update_button),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
