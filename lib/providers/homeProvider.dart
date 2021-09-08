import 'package:flutter/cupertino.dart';
import 'package:maan_api_project/data/api_helper.dart';
import 'package:maan_api_project/models/allProductResponse.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    getAllProducts();
    getallCategories();
  }

  List<AllProductsResponse> allProducts;
  List<AllProductsResponse> categoriesProducts;
  List<dynamic> allCategories;
  String selectedCategory;
  getAllProducts() async {
    allProducts = await ApiHelper.apiHelper.getAllProducts();
    notifyListeners();
  }

  getallCategories() async {
    allCategories = await ApiHelper.apiHelper.getAllCategories();
    this.selectedCategory = allCategories.first.toString();
    getallProductInCategory();
    notifyListeners();
  }

  selectedCategories(String categoryName) {
    this.categoriesProducts = null;
    this.selectedCategory = categoryName;
    notifyListeners();
    getallProductInCategory();
  }

  getallProductInCategory() async {
    categoriesProducts =
        await ApiHelper.apiHelper.findByCategory(selectedCategory);
    notifyListeners();
  }
}
