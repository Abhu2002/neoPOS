import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_bloc.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_event.dart';
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
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productTypeController = TextEditingController();
  XFile? imageFile;

  @override
  void initState() {
    _productNameController.text = widget.productName;
    _productPriceController.text = "${widget.productPrice}";
    _productDescriptionController.text = widget.productDescription;
    _productTypeController.text = widget.productType;

    // TODO: implement initState
    super.initState();
  }

  Widget _buildProductImage() {
    if (imageFile != null) {
      // Display image from the device gallery
      if (kIsWeb) {
        // For Flutter web, use Image.network
        return Image.network(imageFile!.path, height: 100, width: 100);
      } else {
        // For mobile platforms, use Image.file
        return Image.file(File('imageFile'));
      }
    } else {
      return const Text('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.update_product_title),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.product_name_title),
            ),
            TextField(
              controller: _productPriceController,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.product_price_text),
            ),
            TextField(
              controller: _productDescriptionController,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 2,
              decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context)!.product_description_title),
            ),
            TextField(
              controller: _productTypeController,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.product_type_title),
            ),
            SizedBox(height: 16),
            _buildProductImage(),
            SizedBox(height: 6),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context)!.cancel_button),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _updateProduct(context);
          },
          child: Text(AppLocalizations.of(context)!.ok_button),
        ),
      ],
    );
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
          productType: _productTypeController.text.trim(),
          productUpdatedTime:
              DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
          imageFile: imageFile,
          oldImage: widget.image));

      Navigator.of(context).pop();
    }
  }
}
