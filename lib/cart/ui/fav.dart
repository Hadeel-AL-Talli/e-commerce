import 'package:flutter/material.dart';
import 'package:maan_api_project/cart/provider/database_provider.dart';
import 'package:maan_api_project/cart/ui/emptyFav.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
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
          'Favourites',
          style: TextStyle(color: Colors.black),
        ),
      ),
        body: Consumer<DatabaseProvider>(
          builder: (context, provider, x) {
            if (provider.favouriteProdcts == null) {
              return Center(
                child:FavEmpty(),
              );
            } else {
              return Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemCount: provider.favouriteProdcts.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(provider
                                          .favouriteProdcts[index].image)))),
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: IconButton(
                                  onPressed: () {
                                    provider.deleteProductInFavourite(
                                        provider.favouriteProdcts[index].id);
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.redAccent,
                                    size: 30,
                                  )),
                            ),
                          ))
                        ],
                      );
                    }),
              );
            }
          },
        ));
  }
}