import 'dart:convert';

import 'package:assignment13/model/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServices {
  ///Get Product

  static Future<List<Product>> getProductFromApi() async {
    String url = 'https://crud.teamrabbil.com/api/v1/ReadProduct';
    Response response = await http.get(Uri.parse(url));
    final decodedData = jsonDecode(response.body);
    final jsonData = decodedData['data'] as List;

    if (response.statusCode == 200) {
      return jsonData.map((index) => Product.fromJson(index)).toList();
    } else {
      return [];
    }
  }

  ///Post Product
  static Future addProduct(postProductData) async {
    const String addProductUrl =
        'https://crud.teamrabbil.com/api/v1/CreateProduct';
    Uri uri = Uri.parse(addProductUrl);
    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postProductData));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'Product Added Successfully',
          backgroundColor: Colors.green,
          gravity: ToastGravity.SNACKBAR);

      print('added product');
    } else {
      Fluttertoast.showToast(
          msg: 'Failed to add product ${response.statusCode}',
          backgroundColor: Colors.red,
          gravity: ToastGravity.SNACKBAR);
    }
  }

  ///Update product
  static Future<void> updateProduct({
    required Map<String, dynamic> inputData,
    required String productId,
  }) async {
    final updateProductUrl =
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/$productId';

    try {
      Uri uri = Uri.parse(updateProductUrl);
      final Response response = await http.post(
        uri,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(inputData),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        Fluttertoast.showToast(
          msg: 'Product updated successfully',
          backgroundColor: Colors.green,
          gravity: ToastGravity.SNACKBAR,
        );
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final errorMessage =
            responseData['message'] ?? 'Failed to update product';
        Fluttertoast.showToast(
          msg: errorMessage,
          backgroundColor: Colors.red,
          gravity: ToastGravity.SNACKBAR,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'An error occurred while updating the product: $e',
        backgroundColor: Colors.red,
        gravity: ToastGravity.SNACKBAR,
      );
    }
  }

  ///Delete Product
  static Future<void> deleteProduct(String productId) async {
    String deleteProductUrl =
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId';
    Uri uri = Uri.parse(deleteProductUrl);

    Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'Product deleted Successfully',
          backgroundColor: Colors.green,
          gravity: ToastGravity.SNACKBAR);

      print('Product deleted Succesfully');
      Fluttertoast.showToast(
          msg: 'Product deleted Successfully',
          backgroundColor: Colors.green,
          gravity: ToastGravity.SNACKBAR);
    } else {
      print('Failed to delete product');
      Fluttertoast.showToast(
          msg: 'Product deleted Successfully',
          backgroundColor: Colors.red,
          gravity: ToastGravity.SNACKBAR);
    }
  }
}
