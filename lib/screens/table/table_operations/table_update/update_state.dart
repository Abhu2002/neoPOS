part of 'update_bloc.dart';

enum UpdateButtonState { disable, enable, progress }

class UpdateTableState extends Equatable {
  const UpdateTableState({
    this.tableId = '1',
    this.tableName = '',
    this.tableCapacity = 0,
    this.state = UpdateButtonState.enable,
    this.canUpdate = false,
    this.verifyData = false,
  });

  final String tableId;
  final String tableName;
  final int tableCapacity;
  final UpdateButtonState state;
  final bool canUpdate;
  final bool verifyData;

  UpdateTableState copyWith({
    String? tableId,
    String? tableName,
    int? tableCapacity,
    UpdateButtonState? state,
    bool? canUpdate,
    bool? verifyData,
  }) {
    return UpdateTableState(
      tableId: tableId ?? this.tableId,
      tableName: tableName ?? this.tableName,
      tableCapacity: tableCapacity ?? this.tableCapacity,
      state: state ?? this.state,
      canUpdate: canUpdate ?? this.canUpdate,
      verifyData: verifyData ?? this.verifyData,
    );
  }

  @override
  List<Object?> get props =>
      [tableId, tableName, tableCapacity, state, canUpdate, verifyData];
}
