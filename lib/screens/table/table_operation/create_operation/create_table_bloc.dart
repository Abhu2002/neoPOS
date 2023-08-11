import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:neopos/screens/table/table_model/table.dart';

part 'create_table_event.dart';
part 'create_table_state.dart';

class CreateTableBloc extends Bloc<CreateTableEvent, CreateTableState> {
  void Function(String)? showMessage;
  CreateTableBloc() : super(CreateTableInitial()) {
    on<TableNameNotAvailableEvent>((event, emit) {
      emit(CreateTableInitial());
    });
    on<CreateTableFBEvent>((event, emit) async {
      try {
        List allName = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("table").get().then((value) => {
              value.docs.forEach((element) {
                allName.add(element['table_name']);
              })
            });
        if (allName.contains((event.tableName).trim())) {
          emit(TableNameNotAvailableState());
          //showMessage!("Table Name Exist Please use Different Name");
        } else {
          List<Map<String, dynamic>> myData = [];
          final data = TableModel(
              tableName: event.tableName, tableCap: int.parse(event.tableCap));
          final livedata =
              LiveTableModel(tableName: event.tableName, products: myData);
          await db.collection("table").add(data.toFirestore()).then(
              (documentSnapshot) => {
                    emit(TableCreatedState(true)),
                    showMessage!("Table Created")
                  });
          await db
              .collection("live_table")
              .add(livedata.toFirestore())
              .then((documentSnapshot) => {showMessage!("Live Table Created")});
          await GetIt.I.get<FirebaseFirestore>().clearPersistence();
          await GetIt.I.get<FirebaseFirestore>().terminate();
        }
      } catch (err) {
        showMessage!("$err");
      }
    });
  }
}
