import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maan_api_project/bottomNavigationBar/Favorite.dart';
import 'package:maan_api_project/bottomNavigationBar/cart.dart';
import 'package:maan_api_project/bottomNavigationBar/provider.dart';
import 'package:maan_api_project/cart/ui/cartPage.dart';
import 'package:maan_api_project/cart/ui/fav.dart';
import 'package:maan_api_project/data/api_helper.dart';
import 'package:maan_api_project/models/allProductResponse.dart';
import 'package:maan_api_project/providers/productDetailProvider.dart';
import 'package:maan_api_project/providers/homeProvider.dart';
import 'package:maan_api_project/themeHelper/themeProvider.dart';
import 'package:maan_api_project/ui/allProductsPage.dart';
import 'package:maan_api_project/ui/productDetails.dart';
import 'package:maan_api_project/ui/widgets/categoryWidget.dart';
import 'package:maan_api_project/ui/widgets/productWidget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class Home extends StatefulWidget {
  //AllProductsResponse product;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Position> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    markers.add(Marker(
        markerId: MarkerId('$LatLng'),
        position: LatLng(position.latitude, position.longitude)));
    setState(() {});
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 10,
        bearing: 20)));
    return position;
  }

  GoogleMapController mapController;
  CameraPosition cameraPosition =
      CameraPosition(target: LatLng(31.5, 34.46667), zoom: 2, bearing: 20);
  setMapCreated(GoogleMapController googleMapController) {
    mapController = googleMapController;
    _determinePosition();
  }

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            title: Text(
              'Home'.tr(),
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Locale currentLocale = context.locale;
                    if (currentLocale == Locale('en')) {
                      context.setLocale(Locale('ar'));
                    } else {
                      context.setLocale(Locale('en'));
                    }
                  },
                  icon: Icon(
                    Icons.language,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Cart();
                    }));
                  },
                  icon: Icon(Icons.shopping_cart, color: Colors.purple)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FavouritePage();
                    }));
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )),
              PopupMenuButton<String>(
                  onSelected: Provider.of<ThemeProvider>(context, listen: false)
                      .handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Light', 'Dark', 'Kids'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(
                          choice,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList();
                  }),
            ],
            //backgroundColor: Colors.white,
            elevation: 1.0),
        body: Column(
          children: [
            SizedBox(
                height: 200.0,
                width: 400.0,
                child: Carousel(
                  boxFit: BoxFit.fill,
                  autoplay: true,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 5.0,
                  dotIncreasedColor: Colors.purple,
                  dotBgColor: Colors.black.withOpacity(0.2),
                  dotPosition: DotPosition.bottomCenter,
                  showIndicator: true,
                  indicatorBgPadding: 5.0,
                  images: [
                    //  CachedNetworkImage(imageUrl: allProductsResponse.image),

                    // allProductsResponse.image,
                    NetworkImage(
                        'https://image.freepik.com/free-vector/happy-people-shopping-online_74855-5865.jpg'),
                    NetworkImage(
                        'https://image.freepik.com/free-psd/online-delivery-with-smartphone-mockup-template-with-delivery-package_1150-38852.jpg'),
                    NetworkImage(
                        'https://image.freepik.com/free-vector/isometric-smartphone-shopping-cart-with-bag_1262-16548.jpg'),
                  ],
                )),
            Expanded(
              child: Consumer<HomeProvider>(
                builder: (context, provider, x) {
                  List<AllProductsResponse> allProducts = provider.allProducts;

                  List<AllProductsResponse> products =
                      provider.categoriesProducts;
                  List<dynamic> categories = provider.allCategories;

                  if (products == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // allProducts == null
                          //     ? Center(
                          //         child: CircularProgressIndicator(),
                          //       )
                          //     : CarouselSlider(

                          //       // height: 200.0,
                          //         items: allProducts.take(4).map((element) {
                          //           return Builder(
                          //             builder: (BuildContext context) {
                          //               return Container(
                          //                   width:
                          //                       MediaQuery.of(context).size.width,
                          //                   margin: EdgeInsets.symmetric(
                          //                       horizontal: 1.0),
                          //                   decoration: BoxDecoration(
                          //                       color: Colors.white),
                          //                   child: CachedNetworkImage(
                          //                       imageUrl: element.image));
                          //             },
                          //           );
                          //         }).toList(),
                          //       ),
                          Text(
                            'Categories'.tr(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          provider.allCategories == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: provider.allCategories.map((e) {
                                      return CategoryWidget(e);
                                    }).toList(),
                                  ),
                                ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                ' All Products',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 200,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AllProductsPage()));
                                },
                                child: Text(
                                  'View all..',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              )
                            ],
                          ),
                          products == null
                              ? Center(child: CircularProgressIndicator())
                              : Expanded(
                                  child: ListView.builder(
                                      itemCount: products.length,
                                      itemBuilder: (context, index) {
                                        //provider.getAllProducts();
                                        return GestureDetector(
                                            onTap: () {
                                              Provider.of<ProductDetailsProvider>(
                                                      context,
                                                      listen: false)
                                                  .getProductResponse(
                                                      products[index].id);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return ProductDetails();
                                              }));
                                            },
                                            child:
                                                ProductWidget(products[index]));
                                      }),
                                ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 60,
          child: TextButton(
            child: Text(
              'Find Our Location',
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            onPressed: () {
              //deep link for google maps app
              launch(
                  'https://www.google.com/maps/search/?api=1&query=31.5,34.4');
            },
          ),
        ));
  }
}
