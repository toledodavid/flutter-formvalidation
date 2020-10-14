import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/product_model.dart';

class ProductsProvider {

  final String _urlFirebase = 'https://flutter-course-1b8ea.firebaseio.com';

  Future<bool> createProduct(ProductModel product) async {

    final String urlProducts = '$_urlFirebase/products.json';

    final response = await http.post(urlProducts, body: productModelToJson(product));

    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;

  }

}