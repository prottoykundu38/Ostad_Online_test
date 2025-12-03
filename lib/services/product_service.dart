import 'dart:convert';
import '../models/product.dart';
import 'package:http/http.dart' as http;
class ProductService {
  static const String url = 'http://35.73.30.144:2008/api/v1/ReadProduct';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        var products = data['data'] as List;
        return products.map((productJson) => Product.fromJson(productJson)).toList();
      } else {
        throw Exception('Failed to load');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}
