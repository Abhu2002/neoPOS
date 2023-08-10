import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:neopos/utils/popup_cancel_button.dart';

import 'order_content_bloc.dart';
import 'order_content_event.dart';

class AddOrder extends StatefulWidget {
  const AddOrder(
      {required this.productName,
      super.key,
      required this.productCategory,
      required this.productType,
      required this.productPrice, required this.docId});

  final String productName;
  final String productCategory;
  final String productType;
  final String productPrice;
  final String docId;

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      actionsPadding: const EdgeInsets.all(20),
      title: PopUpRow(
        title: 'Add Order',
      ),
      actions: [
        SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.productName,
                softWrap: true,
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.mainTextColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text("QTY : ",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.mainTextColor,
                          ))),
                  Expanded(
                    flex: 5,
                    child: InputQty(
                      maxVal: 10,
                      initVal: 1,
                      minVal: 1,
                      isIntrinsicWidth: false,
                      borderShape: BorderShapeBtn.circle,
                      boxDecoration: const BoxDecoration(),
                      steps: 1,
                      showMessageLimit: false,
                      onQtyChanged: (val) {
                        print(val);
                        quantity = val!.toInt();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor),
                onPressed: () {
                  BlocProvider.of<OrderContentBloc>(context).add(
                      AddOrderFBEvent(
                          widget.productName,
                          widget.productType,
                          widget.productCategory,
                          widget.productPrice,
                          quantity.toString(),
                      widget.docId));
                  Navigator.pop(context);
                },
                child: Text("ADD"),
              )
            ],
          ),
        )
      ],
    );
  }
}
