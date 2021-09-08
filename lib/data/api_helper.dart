import 'package:dio/dio.dart';
import 'package:maan_api_project/models/allProductResponse.dart';

class ApiHelper {
  ApiHelper._() {
    dio = Dio();
  }

  static ApiHelper apiHelper = ApiHelper._();
  Dio dio;

  Future<List<dynamic>> getAllCategories() async {
    String url = 'https://fakestoreapi.com/products/categories';
    Response response = await dio.get(url);
    return response.data;
  }

  Future<List<AllProductsResponse>> getAllProducts(
      [int limit = 20, sort = 'desc']) async {
    String url = 'https://fakestoreapi.com/products?limit=$limit';
    Response response = await dio.get(url);

    List responses = response.data;
    List<AllProductsResponse> allProducts =
        responses.map((e) => AllProductsResponse.fromJson(e)).toList();
    print(allProducts);
    return allProducts;
  }

  Future<List<dynamic>> findByCategory(String categoryeName) async {
    try {
      String url = 'https://fakestoreapi.com/products/category/$categoryeName';
      Response response = await dio.get(url);
      
      
      List responses = response.data;
      List<AllProductsResponse> allProducts =
          responses.map((e) => AllProductsResponse.fromJson(e)).toList();
      print(allProducts);
      return allProducts;
    } on Exception catch (e) {
      // TODO
    }
  }

   

}
