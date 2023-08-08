import 'package:flutter/material.dart';

class OrderContentPage extends StatefulWidget {
  const OrderContentPage({super.key});

  @override
  State<OrderContentPage> createState() => _OrderContentPageState();
}

class _OrderContentPageState extends State<OrderContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orderpagfe")),
      body: Center(child: Text("Order Page ")),
    );
  }
}
