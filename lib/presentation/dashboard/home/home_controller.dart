part of 'home.dart';

extension on _HomeState {
  void _getAllProducts() {
    BlocProvider.of<ProductBloc>(context).add(
      GetProducts(),
    );
  }

  void _getDocumentIdFavorites() {
    BlocProvider.of<ProductBloc>(context).add(
      GetProductsFavorites(),
    );
  }
}
