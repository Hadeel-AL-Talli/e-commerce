import 'package:flutter/cupertino.dart';
import 'package:maan_api_project/bottomNavigationBar/Favorite.dart';
import 'package:maan_api_project/bottomNavigationBar/cart.dart';
import 'package:maan_api_project/ui/Home.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int currentIndex = 0;
  List<Widget> screens = [
    Home(),
    Favorite(),
    //Cart(),
  ];

 
}
