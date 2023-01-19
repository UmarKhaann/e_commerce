import 'package:e_commerce/Pages/HomePage.dart';
import 'package:e_commerce/Pages/WelcomePages/WelcomePage1.dart';
import 'package:e_commerce/Pages/item_screen.dart';
import 'package:e_commerce/provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ItemsProvider())],
    child: const Ecommerce(),
  ));
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
