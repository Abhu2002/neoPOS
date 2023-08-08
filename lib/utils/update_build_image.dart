import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/products/products_operation/update_operation/product_update_bloc.dart';
import '../screens/products/products_operation/update_operation/product_update_state.dart';

class BuildUpdateImage extends StatefulWidget {
  const BuildUpdateImage({super.key});

  @override
  State<BuildUpdateImage> createState() => _BuildImageState();
}

class _BuildImageState extends State<BuildUpdateImage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProductBloc, UpdateProductState>(
        builder: (context, state) {
      if (state.imageFile != null) {
        // Display image from the device gallery
        if (kIsWeb) {
          // For Flutter web, use Image.network
          return Image.network(state.imageFile!.path, height: 100, width: 100);
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
