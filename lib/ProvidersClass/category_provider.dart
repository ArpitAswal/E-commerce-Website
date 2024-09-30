import 'package:ecommerce_shopping_website/Repository/category_repo.dart';
import 'package:flutter/material.dart';

import '../DataModel/products_model.dart';
import '../Utils/app_exceptions.dart';

class CategoryProvider with ChangeNotifier {
  final _service = CategoryRepo();

  List<dynamic> _categoryList = [];
  List<ProductModel> _categoryItemsList = [];
  String? _selectedCategory;
  bool isLoading = false;
  int categoryLimit = 12;

  List<dynamic> get categoryList => _categoryList;
  List<ProductModel> get categoryItemsList => _categoryItemsList;
  String? get selectedCategory => _selectedCategory;

  Future<void> fetchCategories() async{
    // Fetch categories from API
    try {
      _categoryList = await _service.fetchCategories();
      notifyListeners();
    } on AppException catch (e) {
      throw AppException(message: e.message, type: e.type);
    }
  }

  Future<void> fetchCategoryItems(String value) async{
    try{
      _selectedCategory = value;
      _categoryItemsList = await _service.fetchCategoryItem(selectedCategory);
      if(_categoryItemsList.length < 12 ){
        categoryLimit = _categoryItemsList.length;
      } else{
        categoryLimit = 12;
      }
      notifyListeners();
    } on AppException catch (e) {
      throw AppException(message: e.message, type: e.type);
    }
  }

  Future<void> loadMore() async {
    isLoading = true;
    notifyListeners();

    if (categoryLimit < categoryItemsList.length) {
      categoryLimit = (categoryLimit + 8 >= categoryItemsList.length)
          ? categoryItemsList.length
          : categoryLimit + 8;
    } else{
      categoryLimit = categoryItemsList.length;
    }
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
  }

  void removeCategoryItems() {
    _selectedCategory = null;
    _categoryItemsList = [];
    notifyListeners();
  }

}
