part of 'create_product_bloc.dart';

class CreateProductState extends Equatable {
  const CreateProductState();

  @override
  List<Object> get props => [];

  get category => null;

  XFile? get imageFile => null;

  get type => null;
}

class CreateProductInitial extends CreateProductState {}

class CategoryLoadingState extends CreateProductState {}

class CategoryLoadedState extends CreateProductState {
  final List<dynamic> categories;

  const CategoryLoadedState(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryChangedState extends CreateProductState {
  final String category;

  const CategoryChangedState(this.category);

  @override
  List<Object> get props => [category];
}

class ImageChangedState extends CreateProductState {
  final XFile imageFile;

  const ImageChangedState(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}


class ProductNameAvailableState extends CreateProductState {}

class ProductTypeState extends CreateProductState{
  final ProductType type;
  const ProductTypeState(this.type);

  @override
  List<Object> get props => [type];
}

class ProductErrorState extends CreateProductState {
  final String errorMessage;

  const ProductErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ProductPriceValidated extends CreateProductState {}
class ProductCreatingState extends CreateProductState {}

class ProductCreatedState extends CreateProductState {
  bool created;

  ProductCreatedState(this.created);

  @override
  List<Object> get props => [created];
}
