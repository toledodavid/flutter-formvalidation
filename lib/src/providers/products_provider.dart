import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:formvalidation/src/user_preferences/user_preferences.dart';

import 'package:formvalidation/src/models/product_model.dart';

class ProductsProvider {

  final String _urlFirebase = 'https://flutter-course-1b8ea.firebaseio.com';
  final _userPreferences = new UserPreferences();

  Future<bool> createProduct(ProductModel product) async {

    final String urlProducts = '$_urlFirebase/products.json?auth=${_userPreferences.token}';

    final response = await http.post(urlProducts, body: productModelToJson(product));

    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;

  }

  Future<List<ProductModel>> getProducts() async {
    final String urlProducts = '$_urlFirebase/products.json?auth=${_userPreferences.token}';
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

  Future<int> deleteProduct(String id) async {
    final String urlProduct = '$_urlFirebase/products/$id.json?auth=${_userPreferences.token}';
    final response = await http.delete(urlProduct);

    print(response.body);
    return 1;
  }

  Future<bool> editProduct(ProductModel product) async {

    final String urlProducts = '$_urlFirebase/products/${product.id}.json?auth=${_userPreferences.token}';
    final response = await http.put(urlProducts, body: productModelToJson(product));

    final decodedData = json.decode(response.body);

    print(decodedData);
    return true;

  }

  Future<String> uploadImage(File image) async {
    final uri = Uri.parse('https://api.cloudinary.com/v1_1/doilfq77p/image/upload?upload_preset=bgn8sl24');
    final mimeType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      uri
    );
    
    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('******************Error with upload image***************');
      print(response.body);
      return null;
    }

    final respData = json.decode(response.body);
    print(respData);
    return respData['secure_url'];
  }

}