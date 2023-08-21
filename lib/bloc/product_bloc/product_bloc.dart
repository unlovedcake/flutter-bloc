import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterbloccrud/model/product_model.dart';
import 'package:flutterbloccrud/repository/auth_repository.dart';
import 'package:flutterbloccrud/repository/product_repository.dart';
import 'package:meta/meta.dart';

part './product_event.dart';
part './product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  //final ProductRepository productRepository;
  ProductBloc() : super(ProductsInitial()) {
    on<GetProducts>((event, emit) async {
      emit(ProductsLoading());
      try {
        final products = await ProductRepository.getAllProducts();
        emit(ProductsLoaded(products: products));
      } catch (e) {
        emit(ProductsError(e.toString()));
      }
    });
  }
}
