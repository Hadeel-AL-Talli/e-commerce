import 'package:flutter/material.dart';
import 'package:maan_api_project/models/allProductResponse.dart';
import 'package:maan_api_project/providers/productDetailProvider.dart';
import 'package:maan_api_project/providers/homeProvider.dart';
import 'package:maan_api_project/ui/productDetails.dart';
import 'package:maan_api_project/ui/widgets/productWidget.dart';
import 'package:provider/provider.dart';

class AllProductsPage extends StatelessWidget {
  AllProductsResponse product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
        title: Text(
          'AllProducts',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, x) {
          List<AllProductsResponse> products = provider.categoriesProducts;
          return GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Provider.of<ProductDetailsProvider>(context,
                              listen: false)
                          .getProductResponse(products[index].id);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProductDetails();
                      }));
                    },
                    child: ProductWidget(products[index]));
              });
        },
      ),
    );
  }
}
