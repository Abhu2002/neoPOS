import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'read_products_event.dart';
part 'read_products_state.dart';

class ReadProductsBloc extends Bloc<ReadProductsEvent, ReadProductsState> {
  ReadProductsBloc() : super(ReadProductsInitial()) {
    on<ReadProductsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
