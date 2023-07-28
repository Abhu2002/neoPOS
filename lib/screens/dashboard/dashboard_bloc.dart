import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() :  super(const DashboardState()) {
  on<NavigateTo>(_mapEventToState);
}
  Stream<void> _mapEventToState(DashboardEvent event, Emitter<DashboardState> emit) async*{
    if (event is NavigateTo) {
      // only route to a new location if the new location is different
      if (event.destination != state.selectedItem) {
        yield DashboardState(selectedItem:event.destination);
      }
    }
  }
}