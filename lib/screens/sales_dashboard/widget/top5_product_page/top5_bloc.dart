import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'top5_event.dart';
part 'top5_state.dart';

class Top5Bloc extends Bloc<Top5Event, Top5State> {
  dynamic all;
  Top5Bloc() : super(Top5Initial()) {
    on<LoadallData>((event, emit) {
      all = event.all;
      emit(LoadingState());
    });
    on<SelectKeyEvent>((event, emit) {
      emit(LoadingState());
      if (event.key == "Daily") {
        var data = SplayTreeMap.from(
            all[0], (key1, key2) => all[0][key2].compareTo(all[0][key1]));

        emit(LoadedState(sliceMap(data, 0, 5), event.key));
      } else if (event.key == "Weekly") {
        var data = SplayTreeMap.from(
            all[1], (key1, key2) => all[1][key2].compareTo(all[1][key1]));

        emit(LoadedState(sliceMap(data, 0, 5), event.key));
      } else {
        var data = SplayTreeMap.from(
            all[2], (key1, key2) => all[2][key2].compareTo(all[2][key1]));
        emit(LoadedState(sliceMap(data, 0, 5), event.key));
      }
    });
  }
  Map sliceMap(Map map, offset, limit) {
    return Map.fromIterable(map.keys.skip(offset).take(limit),
        value: (k) => map[k]);
  }
}
