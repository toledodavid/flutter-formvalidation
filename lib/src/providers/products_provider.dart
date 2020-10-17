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

  Future<List<ProductModel>> getProducts() async {
    final String urlProducts = '$_urlFirebase/products.json';
    final response = await http.get(urlProducts);

    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<ProductModel> products = new List();

    if (decodedData == null) return [];
    
    decodedData.forEach((idProduct, infoProduct) {
      final productTemp = ProductModel.fromJson(infoProduct);
      productTemp.id = idProduct;
      products.add(productTemp);
    });

    return products;
  }

}