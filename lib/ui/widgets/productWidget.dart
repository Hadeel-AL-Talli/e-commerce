import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maan_api_project/cart/provider/database_provider.dart';
import 'package:maan_api_project/models/allProductResponse.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  AllProductsResponse product;
  ProductWidget(this.product);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      product.title,
                      style: TextStyle(color: Colors.black),
                    )),
                    Spacer(),
                    Text(
                      product.price.toString()+'\$',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],

          ),
        ),
        Positioned.fill(child: Container(
          margin: EdgeInsets.all(10.0),
          child: Align(alignment: Alignment.topLeft,
          child: Column(children: [
             IconButton(
                    onPressed: () {
                      Provider.of<DatabaseProvider>(context, listen: false)
                          .insertProductInCart(product);
                          
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.purple,
                      size: 30,
                    ),
                  ),
                  //  IconButton(
                  //   onPressed: () {
                  //     Provider.of<DatabaseProvider>(context, listen: false)
                  //         .insertProductInFavourite(product);
                  //   },
                  //   icon: Icon(
                  //     Icons.favorite,
                  //     size: 30,
                  //    color:Colors.red
                  //   ),
                  // ),
          ],)
          ),
        ))
      ],
    );
  }
}
