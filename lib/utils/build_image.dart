import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/products/products_operation/create_operation/create_product_bloc.dart';

// import '../screens/products/products_operation/create_operation/create_product_bloc.dart';
//
class BuildImage extends StatefulWidget {
  const BuildImage({super.key});

  @override
  State<BuildImage> createState() => _BuildImageState();
}

class _BuildImageState extends State<BuildImage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductBloc, CreateProductState>(
        builder: (context, state) {
      if (state.imageFile != null) {
        // Display image from the device gallery
        if (kIsWeb) {
          // For Flutter web, use Image.network
          return Image.network(state.imageFile!.path, height: 50, width: 150);
        } else {
          // For mobile platforms, use Image.file

          return const Text('No image selected');
        }
      } else {
        return const Text('No image selected');
      }
    });
  }
}
