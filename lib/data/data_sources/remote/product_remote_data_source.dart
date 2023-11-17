import 'dart:convert';

import 'package:http/http.dart' as http;


import '../../../core/constant/api.dart';
import '../../../core/error/exceptions.dart';
import '../../models/product/filter_params_model.dart';
import '../../models/product/product_response_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductResponseModel> getProducts(FilterProductParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductResponseModel> getProducts(params) => _getProductFromUrl(
      '$baseUrl/products?keyword=${params.keyword}&pageSize=${params.pageSize}&page=${params.limit}&categories=${jsonEncode(params.categories.map((e) => e.id).toList())}');

  Future<ProductResponseModel> _getProductFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return productResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
