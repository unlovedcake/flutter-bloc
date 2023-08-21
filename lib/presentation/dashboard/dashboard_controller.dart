part of 'dashboard.dart';

extension on _DashBoardState {
  void _getAllProducts() {
    BlocProvider.of<ProductBloc>(context).add(
      GetProducts(),
    );
  }
}
