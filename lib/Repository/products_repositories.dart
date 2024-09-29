import 'dart:async';
import 'dart:io';

import 'package:ecommerce_shopping_website/Utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../DataModel/Products.dart';
import '../DataModel/productInfoModel.dart';
import '../Utils/app_exceptions.dart';
import '../Utils/jsonResponse.dart';

class ProductsRepositories {

  Future<List<Products>> getProducts() async {
    List<Products> data = [];
    try {
      final response = await http.get(Uri.parse(ApiUrls.getProducts));
      final result = jsonResponse(response);
      if (result != null) {
        for (var prd in result) {
          data.add(Products.fromJson(prd));
        }
        return data;
      } else{
        return data;
      }
    } on SocketException {
      throw AppException(
          message: 'No Internet connection', type: ExceptionType.internet);
    } on HttpException {
      throw AppException(
          message: "Couldn't find the data", type: ExceptionType.http);
    } on FormatException {
      throw AppException(
          message: "Bad response format", type: ExceptionType.format);
    } on TimeoutException {
      throw AppException(
        message: 'Connection timed out',
        type: ExceptionType.timeout,
      );
    } catch (e) {
      throw AppException(message: e.toString(), type: ExceptionType.api);
    }
  }

  Future<ProductInfoModel> getProductInfo(int prodId) async {
    try {
      final response = await http.get(Uri.parse("${ApiUrls.getProducts}/$prodId"));
      final result = jsonResponse(response);
      return ProductInfoModel.fromJson(result);
    } on SocketException {
      throw AppException(
          message: 'No Internet connection', type: ExceptionType.internet);
    } on HttpException {
      throw AppException(
          message: "Couldn't find the data", type: ExceptionType.http);
    } on FormatException {
      throw AppException(
          message: "Bad response format", type: ExceptionType.format);
    } on TimeoutException {
      throw AppException(
        message: 'Connection timed out',
        type: ExceptionType.timeout,
      );
    } catch (e) {
      throw AppException(message: e.toString(), type: ExceptionType.api);
    }
  }
}
