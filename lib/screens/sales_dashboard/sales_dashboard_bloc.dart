import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'sales_dashboard_event.dart';
part 'sales_dashboard_state.dart';

class SalesDashboardBloc
    extends Bloc<SalesDashboardEvent, SalesDashboardState> {
  SalesDashboardBloc() : super(SalesDashboardInitial()) {
    on<DashboardPageinitevent>((event, emit) async {
      try {
        emit(SalesDashBoardLoadingState());

        var AllOrderHistory = [];
        List<dynamic> alldata = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("order_history").get().then(
          (value) {
            value.docs.forEach((element) {
              AllOrderHistory.add({
                "Id": element.id,
                "amount": element['amount'],
                "order_date": element['order_date'],
                "customer_moblie_no": element['customer_mobile_no'],
                "customer_name": element['customer_name'],
                "payment_mode": element['payment_mode'],
                "products": element["products"]
              });
            });
          },
        );

        emit(SalesDashBoardLoadedState(AllOrderHistory, alldata));
        //gives all document of tables to State
      } catch (err) {
        emit(SalesDashboardErrorState(
            "Some Error Occur $err")); //calls state and stores message through parameter
      }
    });
  }
}
