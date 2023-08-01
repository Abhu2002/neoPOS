abstract class CategoryEvent {}

class CategoryUpdateRequested extends CategoryEvent {
  final String categoryId;
  final String newName;

  CategoryUpdateRequested(this.categoryId, this.newName);
}
