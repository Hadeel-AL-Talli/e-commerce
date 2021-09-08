import 'package:flutter/material.dart';
import 'package:maan_api_project/addnewproduct/addnewProductapiHelper.dart';
import 'package:maan_api_project/addnewproduct/model/addnewProductmodel.dart';

class AddNewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
           AddNewProductsResponse request = AddNewProductsResponse(
                category: 'category',
                description: 'description',
                image: 'image',
                price: 123,
                title: 'title');
            NewProductApiHelper.newProductApiHelper.addNewProduct(request);
          },
          child: Text('Add'),
        ),
      ),
    );
  }
}
