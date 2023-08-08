import 'package:flutter/material.dart';

class OrderMenuPage extends StatefulWidget {
  const OrderMenuPage({Key? key}) : super(key: key);

  @override
  State<OrderMenuPage> createState() => _OrderMenuPageState();
}

class _OrderMenuPageState extends State<OrderMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Container()),
      Expanded(child: Container())
    ],);
  }
}
