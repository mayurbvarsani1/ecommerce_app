import 'package:ecommerce_app/api/product_api.dart';
import 'package:ecommerce_app/screen/my_cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/screen/product/block/product_bloc.dart';
import 'package:ecommerce_app/screen/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiBlocProvider(
          providers:[
            BlocProvider(
                create: (_) => ProductBloc(productRepository: ProductRepository())
            ),
            BlocProvider(
                create: (_) => CartBloc()
            ),
          ],
          child: MyApp()
      ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}


