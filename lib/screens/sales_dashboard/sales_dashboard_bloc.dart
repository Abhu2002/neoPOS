import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
part 'sales_dashboard_event.dart';

part 'sales_dashboard_state.dart';

class SalesDashboardBloc
    extends Bloc<SalesDashboardEvent, SalesDashboardState> {
  SalesDashboardBloc() : super(SalesDashboardInitial()) {
    on<DashboardPageinitevent>((event, emit) async {
      try {
        emit(SalesDashBoardLoadingState());
        var allOrderHistory = [];
        var graphData = [];
        List<dynamic> allData = [];
        String currentDateD;
        String currentDateM;
        int currentDateW;
        num dailyValue = 0;
        num weeklyValue = 0;
        num monthlyValue = 0;
        Map<String, double> pie = {};
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("order_history").get().then(
          (value) {
            value.docs.forEach((element) {
              allOrderHistory.add({
                "Id": element.id,
                "amount": element['amount'],
                "order_date": element['order_date'],
                "customer_moblie_no": element['customer_mobile_no'],
                "customer_name": element['customer_name'],
                "payment_mode": element['payment_mode'],
                "products": element["products"]
              });
              graphData.add(SalesData(
                  DateTime.parse(element['order_date']), element['amount']));
              for (var element in element['products']) {
                if (pie.keys.contains(element['productCategory'])) {
                  pie[element['productCategory']] =
                      pie[element['productCategory']]! + 1;
                } else {
                  pie[element['productCategory']] = 1;
                }
              }
            });
          },
        );
        List<SalesData>? filteredList = [];
        int targetMonth = event.monthIndex ?? DateTime.now().month; // March

        filteredList = graphData
            .where((sales) {
              return sales.x.month == targetMonth;
            })
            .cast<SalesData>()
            .toList();

        List<SalesData> processedGraphData = [];
        List<SalesData> processedData = [];
        for (var dailySales in filteredList) {
          num sales = 0;

          final dailyFormat = DateFormat("dd-MM-yyyy").format(dailySales.x);

          for (int i = 0; i < graphData.length; i++) {
            final dateFromData =
                DateFormat("dd-MM-yyyy").format(graphData[i].x);

            if (dateFromData == dailyFormat) {
              sales += graphData[i].y;
            }
          }
          processedGraphData.add(SalesData(
              DateFormat("dd-MM-yyyy").parse(dailyFormat), sales as double));
        }

        final Map<DateTime, SalesData> map = {
          for (var dailySales in processedGraphData) dailySales.x: dailySales,
        };

        processedGraphData = map.values.toList();
        for (var dailySales in graphData) {
          num sales = 0;
          final dailyFormat = DateFormat("dd-MM-yyyy").format(dailySales.x);
          for (int i = 0; i < graphData.length; i++) {
            final dateFromData =
                DateFormat("dd-MM-yyyy").format(graphData[i].x);
            if (dateFromData == dailyFormat) {
              sales += graphData[i].y;
            }
          }
          processedData.add(SalesData(
              DateFormat("dd-MM-yyyy").parse(dailyFormat), sales as double));
        }
        final Map<DateTime, SalesData> map2 = {
          for (var dailySales in processedData) dailySales.x: dailySales,
        };
        currentDateD = DateFormat("dd-MM-yyyy").format(DateTime.now());
        currentDateM = DateFormat("MM-yyyy").format(DateTime.now());
        currentDateW = weekNumber(DateTime.now());
        processedData = map2.values.toList();
        for (var a in processedData) {
          dailyValue += ((currentDateD == DateFormat("dd-MM-yyyy").format(a.x))
              ? a.y
              : 0);
          weeklyValue += ((currentDateW == weekNumber(a.x)) ? a.y : 0);
          monthlyValue +=
              ((currentDateM == DateFormat("MM-yyyy").format(a.x)) ? a.y : 0);
        }

        emit(SalesDashBoardLoadedState(allOrderHistory, allData,
            processedGraphData, dailyValue, weeklyValue, monthlyValue, pie));
      } catch (err) {
        emit(SalesDashboardErrorState(
            "Some Error Occur $err")); //calls state and stores message through parameter
      }
    });
  }
  int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }
}

class SalesData {
  SalesData(this.x, this.y);

  final DateTime x;
  final double y;
}
