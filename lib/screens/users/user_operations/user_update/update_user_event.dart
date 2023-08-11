part of 'update_user_bloc.dart';
abstract class UpdateUserEvent extends Equatable{}

class UpdateUserBlocRequested extends UpdateUserEvent {
  final String docId;
  final String newFirstName;
  final String newLastName;
  final String newPassword;
  final String newUserId;

  UpdateUserBlocRequested(this.docId, this.newFirstName, this.newLastName,
      this.newPassword, this.newUserId);

  @override
  List<Object?> get props => [docId,newFirstName,newLastName,newPassword,newUserId];
}
