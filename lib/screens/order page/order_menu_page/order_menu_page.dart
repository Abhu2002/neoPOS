import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/menu_btns_widget.dart';
import '../widgets/menu_cards_widget.dart';
import 'order_menu_bloc.dart';

class OrderMenuPage extends StatefulWidget {
  dynamic data;

  OrderMenuPage({Key? key, this.data}) : super(key: key);

  @override
  State<OrderMenuPage> createState() => _OrderMenuPageState();
}

class _OrderMenuPageState extends State<OrderMenuPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderContentBloc>(context).add(ProductLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                children: [
                  const MenuBtnsWidget(),
                  Expanded(
                    flex: 8,
                    child: MenuCardWidget(
                      data: widget.data,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
