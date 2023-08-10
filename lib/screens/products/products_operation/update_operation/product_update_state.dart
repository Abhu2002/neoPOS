part of 'product_update_bloc.dart';

abstract class ProductState extends Equatable {
  get category => null;

  get type => null;

  XFile? get imageFile => null;
}

class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductUpdated extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
  @override
  List<Object?> get props => [message];
}

class LoadedCategoryState extends ProductState {
  final List<dynamic> categories;

  LoadedCategoryState(this.categories);
  @override
  List<Object?> get props => [categories];
}

class ErrorProductState extends ProductState {
  final String errorMessage;

  ErrorProductState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class CategoryChangedState extends ProductState {
  final String category;

  CategoryChangedState(this.category);
  @override
  List<Object?> get props => [category];
}

class ProductTypeUpdateState extends ProductState {
  final ProductType type;

  ProductTypeUpdateState(this.type);
  @override
  List<Object?> get props => [type];
}

class ImageChangedUpdateState extends ProductState {
  final XFile imageFile;

  ImageChangedUpdateState(this.imageFile);
  @override
  List<Object?> get props => [imageFile];
}

class ProductImageUpdating extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductImageUpdated extends ProductState {
  bool created;

  ProductImageUpdated(this.created);

  @override
  List<Object?> get props => [created];
}

class CheckboxState extends ProductState {
  final bool isChecked;

  CheckboxState(this.isChecked);

  @override
  List<Object> get props => [isChecked];
}
