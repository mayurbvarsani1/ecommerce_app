import 'dart:convert';

import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/services/http_service.dart';
import 'package:ecommerce_app/utils/endpoints.dart';

class ProductRepository {

  Future<List<Product>> fetchProducts(int page, int perPage) async {
    final response = await HttpService.postApi(url:EndPoints.productListUrl,
      body: {'page': '$page', 'perPage': '$perPage'},
    );
    if (response != null && response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print("jsonData=>${jsonData}");
      final List<dynamic> data = jsonData['data'];
      final List<Product> products = data.map((product) => Product.fromJson(product)).toList();
      return products;
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}