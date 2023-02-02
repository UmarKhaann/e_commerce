import 'package:e_commerce/Pages/WelcomePages/welcome_page1.dart';
import 'package:e_commerce/Pages/add_item.dart';
import 'package:e_commerce/Pages/categories.dart';
import 'package:e_commerce/Pages/favorites_page.dart';
import 'package:e_commerce/Pages/filtered_category.dart';
import 'package:e_commerce/Pages/home_page.dart';
import 'package:e_commerce/Pages/item_screen.dart';
import 'package:e_commerce/Pages/profile_screen.dart';
import 'package:e_commerce/utils/route_name.dart';
import 'package:flutter/material.dart';

import '../Pages/WelcomePages/welcome_page2.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){

      case RoutesName.welcomePage1:
        return MaterialPageRoute(builder: (context)=> const WelcomePage1());
      case RoutesName.welcomePage2:
        return MaterialPageRoute(builder: (context)=> const WelcomePage2());
      case RoutesName.addItem:
        return MaterialPageRoute(builder: (context)=> const AddItem());
      case RoutesName.category:
        return MaterialPageRoute(builder: (context)=> const CategoriesScreen());
      case RoutesName.favoritesPage:
        return MaterialPageRoute(builder: (context)=> Favorites());
      case RoutesName.filteredCategory:
        return MaterialPageRoute(builder: (context)=> FilteredCategory(data: settings.arguments as Map));
      case RoutesName.home:
        return MaterialPageRoute(builder: (context)=> HomePage());
      case RoutesName.itemScreen:
        return MaterialPageRoute(builder: (context)=> ItemScreen(data: settings.arguments as Map));
      case RoutesName.profileScreen:
        return MaterialPageRoute(builder: (context)=> const ProfileScreen());

      default:
        return MaterialPageRoute(builder: (context){
          return const Scaffold(body: Center(child: Text("Invalid Route Name"),),);
        });

    }
  }
}