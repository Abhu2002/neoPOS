import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_availability_check.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_description.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_name.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_price.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/build_image.dart';
import '../create_operation/create_product_bloc.dart';
import 'category_dropdown.dart';

var categoryValue = "Select Category";
enum ProductType { veg, nonVeg }

class ProductCreateForm extends StatefulWidget {
  const ProductCreateForm({super.key});

  @override
  State<ProductCreateForm> createState() => _ProductCreateFormState();
}

class _ProductCreateFormState extends State<ProductCreateForm> {
  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productImage = TextEditingController();
  TextEditingController productPrice = TextEditingController();

  XFile? imageFile;
  final formKey = GlobalKey<FormState>();
  late var categories = [];
  bool isChecked = true;

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
    ProductType? type = ProductType.veg;

    return Center(
      child: Form(
        key: formKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              // product name
              BlocBuilder<CreateProductBloc, CreateProductState>(
                builder: (context, state) {
                  return ProductName(productName: productName, onProductNameChanged: (val) {
                    productName.value = TextEditingValue(
                      text: val.toUpperCase(),
                      selection: productName.selection,
                    );
                  },);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // product type
              BlocBuilder<CreateProductBloc, CreateProductState>(
                buildWhen: (previous, current) {
                  if (current is ProductTypeState) {
                    type = current.type;
                  }
                  return current is ProductTypeState;
                },
                builder: (BuildContext context, state) {
                  return ProductTypeSelect(
                    defaultType: type!,
                    stateType: state.type,
                    onProductTypeChanged: (ProductType? value) {
                      BlocProvider.of<CreateProductBloc>(context)
                          .add(ProductTypeEvent(value!));
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // product description
              ProductDescription(controller: productDescription,),
              const SizedBox(
                height: 20,
              ),
              // product price
              ProductPrice(controller: productPrice),
              const SizedBox(
                height: 20,
              ),
              // select category
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
                      return CategoryDropDown(
                          categories: categories,
                          dropdownvalue: categoryValue,
                          onCategoryChanged: (newcategory) {
                            categoryValue = newcategory.toString();
                          });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // checkbox for product availability
              ProductAvailabilityCheck(
                isChecked: isChecked,
                onAvailabilityChanged: (bool? val) {
                  setState(() {
                    isChecked = val!;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // select product image
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
                              BlocProvider.of<CreateProductBloc>(context).add(
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
                  }),
              const SizedBox(
                height: 20,
              ),
              // create product button
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
    );
  }
  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
