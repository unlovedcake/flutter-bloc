part of 'product_bloc.dart';

@immutable
abstract class ProductState extends Equatable {}

// When the user presses the signin or signup button the state is changed to loading first and then to FetchedProduct.
class ProductsInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

// When the user is FetchedProduct the state is changed to FetchedProduct.
class ProductsLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductsLoaded extends ProductState {
  List<Product>? products;

  ProductsLoaded({this.products}) : assert(products != null);

  @override
  List<Object> get props => [products!];
}

// If any error occurs the state is changed to AuthError.
class ProductsError extends ProductState {
  final String error;

  ProductsError(this.error);
  @override
  List<Object?> get props => [error];
}
