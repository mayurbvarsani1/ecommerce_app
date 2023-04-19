import 'package:ecommerce_app/api/product_api.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/screen/my_cart/cart_items.dart';
import 'package:ecommerce_app/screen/product/block/product_event.dart';
import 'package:ecommerce_app/screen/product/block/product_state.dart';
import 'package:ecommerce_app/services/database_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
    List<Product> displayProducts = [];
    List<Product> products = [];
  ProductBloc({required this.productRepository}) : super(ProductInitialState()){
    on<FetchProductEvent>((event, emit) async{
      emit(ProductLoadingState());
      try {
        products = await productRepository.fetchProducts(event.page, event.perPage);
          displayProducts.addAll(products.getRange(displayProducts.length,(products.length > (displayProducts.length + 5)) ? displayProducts.length + 5 : products.length).toList());
          emit(DisplayProductLoadedState(displayProducts: displayProducts));
      } catch (e) {
        emit(ProductErrorState(message: 'Failed to fetch products'));
      }
    });
    on<DisplayProductEvent>((event, emit) async{
      emit(ProductLoadingState());
      displayProducts.addAll(products.getRange(displayProducts.length,(products.length > (displayProducts.length + 5)) ? displayProducts.length + 5 : products.length).toList());
      emit(DisplayProductLoadedState(displayProducts: displayProducts,isScrollable : products.length == displayProducts.length ? false:true));
    });
    on<AddProductItemEvent>(homeProductWishlistButtonClickedEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }
     homeProductWishlistButtonClickedEvent(AddProductItemEvent event, Emitter<ProductState> emit) async{
        await DatabaseHelper.insert(event.clickedProduct);
       // addedCartItems.add(event.clickedProduct);
      emit(AddToCartProductState());
      emit(DisplayProductLoadedState(displayProducts:displayProducts));
     }
   homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<ProductState> emit) {
    emit(HomeNavigateToCartPageActionState());
  }
}