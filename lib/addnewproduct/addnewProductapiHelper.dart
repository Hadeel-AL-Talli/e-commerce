import 'package:dio/dio.dart';
import 'package:maan_api_project/addnewproduct/model/addnewProductmodel.dart';

class NewProductApiHelper {
  NewProductApiHelper._();
  static NewProductApiHelper newProductApiHelper = NewProductApiHelper._();
  addNewProduct(AddNewProductsResponse request) async {
    String url = 'https://fakestoreapi.com/products';
    Response response = await Dio().post(url, data: request.toJson());
    print(response.data);
  }
}
