import 'package:ecommerce_shopping_website/Repository/products_repositories.dart';
import 'package:flutter/material.dart';

import '../DataModel/products_model.dart';
import '../Utils/app_exceptions.dart';

class ProductsProvider extends ChangeNotifier {
  final _service = ProductsRepositories();

  List<ProductModel> _productsList = [];
  List<ProductModel> _searchList = [];
  bool prodLoading = false;
  bool isLoading = false;
  int prodCurrentLimit = 12;

  late ProductModel? _singleProduct;

  List<ProductModel> get productsList => _productsList;
  List<ProductModel> get searchList => _productsList;
  ProductModel? get singleProduct => _singleProduct;

  List<Map<String, int>> mens = [
    {
      'https://assets.adidas.com/images/w_383,h_383,f_auto,q_auto,fl_lossy,c_fill,g_auto/03537f75e707453085d1af1e00f59c5c_9366/x-speedportal.1-firm-ground-boots.jpg':
          30
    },
    {
      'https://assets.adidas.com/images/w_383,h_383,f_auto,q_auto,fl_lossy,c_fill,g_auto/bc259017107249d1997fafa900dddb54_9366/copa-pure.3-firm-ground-boots.jpg':
          40
    },
    {
      'https://assets.adidas.com/images/w_383,h_383,f_auto,q_auto,fl_lossy,c_fill,g_auto/f04c6c2b2e224cb6aeacaf7900e09ce6_9366/predator-accuracy-paul-pogba.3-firm-ground-boots.jpg':
          35
    },
    {
      'https://assets.adidas.com/images/w_383,h_383,f_auto,q_auto,fl_lossy,c_fill,g_auto/e9be48c1d637479f85fcaf730067aca3_9366/x-speedportal.1-firm-ground-boots.jpg':
          30
    },
    {
      'https://assets.adidas.com/images/w_383,h_383,f_auto,q_auto,fl_lossy,c_fill,g_auto/fc6a2b7e64e545bba3a7aef300bb12c9_9366/x-speedportal.3-turf-boots.jpg':
          40
    }
  ];

  List<Map<String, int>> women = [
    {
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStyO7QkIrdwxbHSrTqBA9cQYlQwdmbfpdjFg&usqp=CAU':
          40
    },
    {
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKXn2EwvDyaiZPRI1ZRShwRB-UkmQxr5EBYg&usqp=CAU':
          30
    },
    {
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmBzM_1A9I1RBKaQ8Y5k1prs7RNWTNCAeNcg&usqp=CAU':
          50
    },
    {
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRl4LG3G5dXW2-EoXDoYLTw2jWxZGnDEchRUA&usqp=CAU':
          35
    },
    {
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGGaPLpqz2D1ErWJ6IEto2GaYeIy3sTz7p5g&usqp=CAU':
          40
    }
  ];

  Future<void> getAllProducts() async {
    prodLoading = true;
    notifyListeners();
    try {
      final response = await _service.getProducts();
      _productsList = response;
      prodLoading = false;
      notifyListeners();
    } on AppException catch (e) {
      throw AppException(message: e.message, type: e.type);
    }
  }

  Future<ProductModel> getSingleProduct(int prodId) async {
    try {
      return await _service.getProductInfo(prodId);
    } on AppException catch (e) {
      throw AppException(message: e.message, type: e.type);
    }
  }

  void setSearchList(List<ProductModel> data) {}

  Future<void> loadMore() async {
    isLoading = true;
    notifyListeners();

    if (prodCurrentLimit < productsList.length) {
      prodCurrentLimit = (prodCurrentLimit + 8 >= productsList.length)
          ? productsList.length
          : prodCurrentLimit + 8;
    }
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
  }
}
