import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../navigation/route_paths.dart';
import '../../widgets/menu_btns_widget.dart';
import '../../widgets/menu_cards_widget.dart';
import '../order_menu_bloc.dart';
import '../total_order_checkout.dart';
import 'menu_card_widget_mob.dart';

class OrderMenuMobPage extends StatefulWidget {
  dynamic data;

  OrderMenuMobPage({Key? key, this.data}) : super(key: key);

  @override
  State<OrderMenuMobPage> createState() => _OrderMenuMobPageState();
}

class _OrderMenuMobPageState extends State<OrderMenuMobPage> {

  @override
  void initState() {
    super.initState();
    if (widget.data != null && widget.data.containsKey('Id')) {
      BlocProvider.of<OrderContentBloc>(context)
          .add(ProductLoadingEvent(widget.data['Id'].toString(), false));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, RoutePaths.dashboard);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 100),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              MenuBtnsWidget(data: widget.data),
              Expanded(
                flex: 4,
                child: MenuCardMobWidget(
                  data: widget.data,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
