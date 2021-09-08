import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maan_api_project/cart/provider/database_provider.dart';
import 'package:maan_api_project/models/allProductResponse.dart';
import 'package:maan_api_project/providers/productDetailProvider.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  AllProductsResponse product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          elevation: 1.0,
          title: Text(
            'Product Details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Consumer<ProductDetailsProvider>(
          builder: (context, provider, x) {
            return provider.product == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Image.network(provider.product.image),
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            provider.product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Price',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(width: 30),
                            Text('US \$'),
                            Text(provider.product.price.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Description',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Text(
                                provider.product.description,
                                style: TextStyle(wordSpacing: 3.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Provider.of<DatabaseProvider>(context, listen: false)
                .insertProductInFavourite(product);
            
          },
          child:
          
           Icon(
            Provider.of<DatabaseProvider>(context).favouriteProdcts ==product?Icons.favorite : Icons.favorite_border,
           
           // Icons.favorite_border_outlined,
            color: Colors.red,
          ),
        ),
        bottomNavigationBar: Row(
          children: [
            // Expanded(
            //   child: Container(
            //     child: Container(
            //       width: MediaQuery.of(context).size.width / 3,
            //       height: 60,
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(primary: Colors.red),
            //         onPressed: () {
            //           Provider.of<DatabaseProvider>(context, listen: false)
            //               .insertProductInCart(product);
            //           print('added to cart successfully');
            //         },
            //         child: Text('Add To Cart'),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
