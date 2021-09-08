import 'package:flutter/material.dart';
import 'package:maan_api_project/models/allProductResponse.dart';
import 'package:maan_api_project/productDetail/data/apidetailHelper.dart';

class ProductDetailsProvider extends ChangeNotifier {
  AllProductsResponse product;

  
  getProductResponse(int id) async {
    product = null;
    product = await ProductDetailsApiHelper.apiHelper.getProductDetails(id);
    notifyListeners();
  }
}
