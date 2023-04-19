import 'package:ecommerce_app/model/product_model.dart';

abstract class ProductState {}
class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  ProductLoadedState({required this.products});
}
class DisplayProductLoadedState extends ProductState {
  final List<Product> displayProducts;
  bool isScrollable;

  DisplayProductLoadedState({required this.displayProducts,this.isScrollable = true});
}


class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({required this.message});
}

class AddToCartProductState extends ProductState {}

class HomeNavigateToCartPageActionState extends ProductState {}