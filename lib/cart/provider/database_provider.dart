import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maan_api_project/cart/data/sqlite_helper.dart';
import 'package:maan_api_project/models/allProductResponse.dart';
import 'package:maan_api_project/ui/widgets/customDialog.dart';

class DatabaseProvider extends ChangeNotifier {
  List<AllProductsResponse> favouriteProdcts;
  List<AllProductsResponse> cartProdcts;
  getAllProductsInCart() async {
    List<Map<String, Object>> carts = await DBHelper.cartHelper.getCart();
    cartProdcts = carts.map((e) {
      dynamic productMap = json.decode(e[DBHelper.productDetailsColumn]);
      return AllProductsResponse.fromJson(productMap);
    }).toList();
    notifyListeners();
  }

  getAllProductsInFavourite() async {
    List<Map<String, Object>> carts = await DBHelper.cartHelper.getFavourite();
    favouriteProdcts = carts.map((e) {
      return AllProductsResponse.fromJson(e);
    }).toList();
    notifyListeners();
  }

  insertProductInCart(AllProductsResponse allProductsResponse) async {
    String product = json.encode(allProductsResponse.toJson());
    await DBHelper.cartHelper.addToCart(product, allProductsResponse.id);
    getAllProductsInCart();
  }

  insertProductInFavourite(AllProductsResponse allProductsResponse) async {
    await DBHelper.cartHelper.addToFavourite(allProductsResponse);
   
    getAllProductsInFavourite();
    
  }

  deleteProductInCart(int id) async {
    CustomDialoug.customDialoug.showCustomDialoug(
        'You will delete this product from cart, are you sure?',
        'Alert',
        excuteDelete,
        id);
  }

  excuteDelete(int id) async {
    await DBHelper.cartHelper.removeFromCart(id);
    getAllProductsInCart();
  }

  deleteProductInFavourite(int id) async {
    CustomDialoug.customDialoug.showCustomDialoug(
        'You will delete this product from favourite, are you sure',
        'Alert',
        excuteFavDelete,
        id);
  }

  excuteFavDelete(int id) async {
    await DBHelper.cartHelper.removeFromFavourite(id);
    getAllProductsInFavourite();
  }
}
