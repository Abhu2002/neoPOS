import 'package:flutter/material.dart';
import 'app_colors.dart';
class PopUpRow extends StatefulWidget {
  final String title;
  const PopUpRow({super.key, required this.title});

  @override
  State<PopUpRow> createState() => _PopUpRowState();
}

class _PopUpRowState extends State<PopUpRow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainTextColor),
            ),
            const Spacer(),
            IconButton(onPressed:() => Navigator.pop(context), icon: const Icon(Icons.cancel,color: AppColors.primaryColor,))
          ]),
    );
  }
}


