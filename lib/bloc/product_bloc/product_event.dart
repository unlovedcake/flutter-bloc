part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddProduct extends ProductEvent {
  final Product? products;

  AddProduct(this.products);
}

class GetProducts extends ProductEvent {}

class GetProductsFavorites extends ProductEvent {}

class GetProductByID extends ProductEvent {
  final String id;
  GetProductByID(this.id);
}
