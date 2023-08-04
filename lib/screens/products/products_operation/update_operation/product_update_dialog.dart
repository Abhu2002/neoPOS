import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_bloc.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_event.dart';

class UpdateProductDialog extends StatefulWidget {
  final String productId;

  UpdateProductDialog({required this.productId});

  @override
  _UpdateProductDialogState createState() => _UpdateProductDialogState();
}

class _UpdateProductDialogState extends State<UpdateProductDialog> {
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productTypeController = TextEditingController();
  XFile? imageFile;

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
      title: Text('Update Product'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _productPriceController,
              decoration: InputDecoration(labelText: 'Product Price'),
            ),
            TextField(
              controller: _productDescriptionController,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 2,
              decoration: InputDecoration(labelText: 'Product Description'),
            ),
            TextField(
              controller: _productTypeController,
              decoration: InputDecoration(labelText: 'Product Type'),
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
            child: Text('Cancel'),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _updateProduct(context);
          },
          child: Text('OK'),
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

    if (productName.isNotEmpty && productPrice > 0.0 && imageFile != null) {
      productBloc.add(UpdateProductEvent(
          productId: widget.productId,
          productName: productName,
          productDescription: _productDescriptionController.text.trim(),
          productPrice: productPrice,
          productType: _productTypeController.text.trim(),
          productUpdatedTime: DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
          imageFile: imageFile!,
          ));

      Navigator.of(context).pop();
    }
  }
}
