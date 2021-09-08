import 'package:flutter/material.dart';
import 'package:maan_api_project/cart/provider/database_provider.dart';
import 'package:maan_api_project/cart/ui/cartWidget.dart';
import 'package:maan_api_project/cart/ui/empty_cart.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 2.0,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<DatabaseProvider>(builder: (context, provider, x) {
        if (provider.cartProdcts == null) {
          return Container(child: CartEmpty());
        } else {
          return ListView.builder(
              itemCount: provider.cartProdcts.length,
              itemBuilder: (context, index) {
                return Container(
                  child: CartWidget(provider.cartProdcts[index]),
                );
              });
        }
      }),
    );
  }
}
