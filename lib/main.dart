import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/Screens/Main_Page.dart';
import 'package:provider/provider.dart';
import 'providers/Products_List.dart';
import 'providers/cart.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider to provide multiple data models to the widget tree.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductState(AvailableProducts)),
        ChangeNotifierProvider(create: (context) => Cart_List()),
      ],
      child: MaterialApp(
        title: 'Ecommerce App',
        home: Main_Page(),
      ),
    );
  }
}
