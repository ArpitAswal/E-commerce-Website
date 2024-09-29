
import 'package:ecommerce_shopping_website/Repository/products_repositories.dart';
import 'package:flutter/material.dart';

import '../DataModel/Products.dart';
import '../DataModel/productInfoModel.dart';
import '../Utils/app_exceptions.dart';


class ProductsProvider extends ChangeNotifier{

  final _service = ProductsRepositories();

  List<Products> _productsList = [];
  List<Products> _searchList = [];
  bool isLoading = false;
  bool _isClick = false;

  late ProductInfoModel? _singleProduct;

  List<Products> get productsList=> _productsList;
  List<Products> get searchList=> _productsList;
  ProductInfoModel? get singleProduct=> _singleProduct;
  bool get isClick => _isClick;

  Future<void> getAllProducts() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _service.getProducts();
      _productsList = response;
      isLoading = false;
      notifyListeners();
    }  on AppException catch (e) {
      throw AppException(message: e.message, type: e.type);
    }
  }

  Future<ProductInfoModel> getSingleProduct(int prodId) async{
    try {
      return await _service.getProductInfo(prodId);
    }  on AppException catch (e) {
      throw AppException(message: e.message, type: e.type);
    }
  }

  void setSearchList(List<Products> data){

  }

  void setClick(bool click){
    _isClick = !click;
    notifyListeners();
  }

}