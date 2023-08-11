part of 'category_update_bloc.dart';

abstract class CategoryEvent extends Equatable {}

class CategoryUpdateRequested extends CategoryEvent {
  final String categoryId;
  final String newName;

  CategoryUpdateRequested(this.categoryId, this.newName);

  @override
  List<Object?> get props => [categoryId, newName];
}
