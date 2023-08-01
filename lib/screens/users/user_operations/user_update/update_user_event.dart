abstract class UpdateUserEvent {}

class UpdateUserBlocRequested extends UpdateUserEvent {
  final String docId;
  final String newFirstName;
  final String newLastName;
  final String newPassword;
  final String newUserId;

  UpdateUserBlocRequested(this.docId, this.newFirstName, this.newLastName, this.newPassword, this.newUserId);
}
