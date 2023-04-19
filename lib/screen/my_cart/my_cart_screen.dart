import 'package:ecommerce_app/api/product_api.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/screen/my_cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/screen/product/block/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final CartBloc cartBloc = CartBloc();
  ProductBloc productBloc = ProductBloc(productRepository: ProductRepository());
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listener: (context, state) {

      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartSuccessState:
            final successState = state as CartSuccessState;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: const Color(0XFF6493FF),
                title: const Text('My Cart'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        itemCount: successState.cartItems.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Product product = state.cartItems[index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(left: 15,right:15,top: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(4, 0), // right shadow
                                  ),
                                ]
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Image.network(product.featuredImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        product.title, // replace with the title from your product model
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Colors.black.withOpacity(0.8)
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Price", // replace with the title from your product model
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Colors.black.withOpacity(0.8)
                                            ),
                                          ),
                                          Text(
                                            "Rs ${product.price.toString()}", // replace with the title from your product model
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Colors.black.withOpacity(0.8)
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Quantity", // replace with the title from your product model
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Colors.black.withOpacity(0.8)
                                            ),
                                          ),
                                          Text(
                                            "1", // replace with the title from your product model
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Colors.black.withOpacity(0.8)
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              cartBloc.add(CartRemoveFromCartEvent(productDataModel: product));
                                            },
                                              child: const Icon(Icons.delete))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
              bottomSheet: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                color: const Color(0XFF94cdff),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Items : ${state.cartItems.length}"),
                    Text("Grand Total : ${getGrandTotal(state.cartItems)}"),
                  ],
                ),
              ),
            );

          default:
        }
        return Container();
      },
    );
  }
  getGrandTotal(List<Product> cartItems){
    double grandTotal = 0.0;
    for (Product product in cartItems) {
      grandTotal += product.price;
    }
    return grandTotal;
  }
}
