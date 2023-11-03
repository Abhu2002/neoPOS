import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'top5_event.dart';
part 'top5_state.dart';

extension SplayTreeMultiMapExtension<K, V> on SplayTreeMap<K, List<V>> {
  void add(K key, V value) {
    (this[key] ??= []).add(value);
  }
}

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
        var data = SplayTreeMap<num, List<dynamic>>();
        all[0].forEach((value, key) {
          data.add(key, value);
        });
        List<String> finalData = [];
        var prunedLog = Map.fromEntries(data.entries.toList().reversed.take(5));
        prunedLog.forEach((level, players) {
          for (var player in players) {
            finalData.add(player);
          }
        });
        emit(LoadedState(finalData.take(5).toList(), event.key));
      } else if (event.key == "Weekly") {
        var data = SplayTreeMap<num, List<dynamic>>();
        all[1].forEach((value, key) {
          data.add(key, value);
        });
        List<String> finalData = [];
        var prunedLog = Map.fromEntries(data.entries.toList().reversed.take(5));
        prunedLog.forEach((level, players) {
          for (var player in players) {
            finalData.add(player);
          }
        });
        emit(LoadedState(finalData.take(5).toList(), event.key));
      } else {
        var data = SplayTreeMap<num, List<dynamic>>();
        all[2].forEach((value, key) {
          data.add(key, value);
        });
        List<String> finalData = [];
        var prunedLog = Map.fromEntries(data.entries.toList().reversed.take(5));
        prunedLog.forEach((level, players) {
          for (var player in players) {
            finalData.add(player);
          }
        });
        emit(LoadedState(finalData.take(5).toList(), event.key));
      }
    });
  }
  Map sliceMap(Map map, offset, limit) {
    return Map.fromIterable(map.keys.skip(offset).take(limit),
        value: (k) => map[k]);
  }
}
