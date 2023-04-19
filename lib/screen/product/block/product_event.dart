import 'package:ecommerce_app/model/product_model.dart';

abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {
  final int page;
  final int perPage;

  FetchProductEvent({required this.page, required this.perPage});
}
class DisplayProductEvent extends ProductEvent {
  DisplayProductEvent();
}
class AddProductItemEvent extends ProductEvent {
  final Product clickedProduct;
  AddProductItemEvent({required this.clickedProduct});
}
class HomeCartButtonNavigateEvent extends ProductEvent {}
