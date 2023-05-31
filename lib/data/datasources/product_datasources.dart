// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:fic4_tugas_akhir_ekatalog/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

import '../models/request/product_model.dart';

class ProductDatasources {
  Future<ProductResponseModel> createProduct(ProductModel model) async {
    final newMap = model.toMap();
    var headers = {'Content-Type': 'application/json'};
    print(model.toJson());
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/products/'),
      headers: headers,
      body: model.toJson(),
    );
    print(response.body);
    return ProductResponseModel.fromJson(response.body);
  }

  Future<ProductResponseModel> getProduct(int id) async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
    );
    return ProductResponseModel.fromJson(response.body);
  }

  Future<ProductResponseModel> updateProduct(ProductModel model, int id) async {
    final response = await http.put(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id}'),
      headers: {'Content-Type': 'application/json'},
      body: model.toMap(),
    );
    return ProductResponseModel.fromJson(response.body);
  }

  Future<List<ProductResponseModel>> getAllProduct() async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/'),
    );

    final result = List<ProductResponseModel>.from(jsonDecode(response.body)
        .map((x) => ProductResponseModel.fromJson(x))).toList();
    return result;
  }
}
