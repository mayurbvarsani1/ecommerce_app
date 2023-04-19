import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/screen/my_cart/cart_items.dart';
import 'package:ecommerce_app/services/database_services.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

    cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) async{

      List<Map<String, dynamic>>? result  = await DatabaseHelper.instance.queryDatabase();
      print("result=>${result}");
      for(var row in result!){
        Product product = Product(
          id: row["id"],
          slug: row["slug"],
          title: row["title"],
          description: row["description"],
          price: row["price"],
          featuredImage: row["featured_image"],
          status: row["status"],
          createdAt: row["created_at"],
        );
        addedCartItems.add(product);
      }

    emit(CartSuccessState(cartItems: addedCartItems));
    }
  }

    cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) async{
    await DatabaseHelper.instance.deleteDatabase(event.productDataModel.id);
     addedCartItems.remove(event.productDataModel);
    emit(CartSuccessState(cartItems: addedCartItems));
  }

