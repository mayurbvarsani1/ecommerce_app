import 'package:ecommerce_app/api/product_api.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/screen/my_cart/my_cart_screen.dart';
import 'package:ecommerce_app/screen/product/block/product_bloc.dart';
import 'package:ecommerce_app/screen/product/block/product_event.dart';
import 'package:ecommerce_app/screen/product/block/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> showProductItems = [];
    ProductBloc productBloc = ProductBloc(productRepository: ProductRepository());
  @override
  void initState() {
    addProduct();
    super.initState();
  }
  addProduct(){
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(FetchProductEvent(page:1,perPage:5));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0XFF6493FF),
        title: const Text('Shopping Mall'),
        elevation: 0,
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: (){
                productBloc.add(HomeCartButtonNavigateEvent());
              },
                child: const Icon(Icons.shopping_cart_outlined)),
          )
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        // bloc: productBloc,
        listener: (context,state){
          if (state is HomeNavigateToCartPageActionState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCartScreen()));
            productBloc.add(DisplayProductEvent());
          } else if (state is AddToCartProductState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item added to cart!')));
          }
        },
        builder: (BuildContext context, ProductState state) {
          if (state is ProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DisplayProductLoadedState) {
            return NotificationListener(
              onNotification: (s) {
                if (s is OverscrollNotification) {
                  if (s.overscroll > 0) {
                    if(state.isScrollable) {
                      productBloc.add(DisplayProductEvent());
                    }
                  }
                }
                return true;
              },
              child: OrientationBuilder(
                builder: (context, orientation) {
                  return GridView.builder(
                    itemCount: state.displayProducts.length,
                    padding:const EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 30),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      childAspectRatio:0.7,
                    ),
                    itemBuilder: (context, index) {
                      Product product = state.displayProducts[index];
                      return Container(
                        padding: const EdgeInsets.all(10),
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
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(product.featuredImage,
                                  fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product.title, // replace with the title from your product model
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: (){
                                    productBloc.add(AddProductItemEvent(clickedProduct: product));
                                  },
                                  child: const Icon(Icons.shopping_cart),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else if (state is ProductErrorState) {
            return const Center(
              child: Text('Failed to fetch products'),
            );
          }
          return Container(); // Empty container as a fallback
        },
      ),
    );
  }
}