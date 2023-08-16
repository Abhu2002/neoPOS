import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:neopos/screens/sales_dashboard/sales_dashboard_page.dart';

part 'sales_dashboard_event.dart';

part 'sales_dashboard_state.dart';

class SalesDashboardBloc
    extends Bloc<SalesDashboardEvent, SalesDashboardState> {
  SalesDashboardBloc() : super(SalesDashboardInitial()) {
    on<DashboardPageinitevent>((event, emit) async {
      try {
        emit(SalesDashBoardLoadingState());
        var start = DateTime.parse("2023-08-01");
        var end = DateTime.parse("2023-08-30");
        var AllOrderHistory = [];
        var graphData = [];
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
              graphData.add(SalesData(
                   DateTime.parse(element['order_date']),
                  element['amount'])
              );
            });
          },
        );
        List<SalesData>?filteredList=[];
        int targetMonth = event.monthIndex ?? DateTime.now().month; // March

         filteredList = graphData.where((sales) {
           return sales.x.month == targetMonth;
         }).cast<SalesData>().toList();

        for (var sale in filteredList) {
          print('${sale.x}: ${sale.y}');
        }
        List<SalesData> processedData = [];

        for (var dailySales in filteredList) {
          num sales = 0;

          final dailyFormat = DateFormat("dd-MM-yyyy").format(dailySales.x);

          for (int i = 0; i < graphData.length; i++) {

            final dateFromData = DateFormat("dd-MM-yyyy").format(graphData[i].x);

            if (dateFromData == dailyFormat) {
              sales += graphData[i].y;
            }
          }

          processedData
              .add(SalesData(DateFormat("dd-MM-yyyy").parse(dailyFormat), sales as double));

        }

        final Map<DateTime, SalesData> map = {
          for (var dailySales in processedData) dailySales.x : dailySales,
        };

        processedData = map.values.toList();
        for (var a in processedData){
          print(a.x);
          print(a.y);
        }

        emit(SalesDashBoardLoadedState(AllOrderHistory, alldata,processedData));
        //gives all document of tables to State
      } catch (err) {
        emit(SalesDashboardErrorState(
            "Some Error Occur $err")); //calls state and stores message through parameter
      }
    });
  }
}

class SalesData {
  SalesData(this.x, this.y);

  final DateTime x;
  final double y;
}