import 'package:buy_it/models/product.dart';
import 'package:buy_it/provider/adminMode.dart';
import 'package:buy_it/provider/cartItem.dart';
import 'package:buy_it/provider/modelHud.dart';
import 'package:buy_it/screens/admin/OrdersScreen.dart';
import 'package:buy_it/screens/admin/addProduct.dart';
import 'package:buy_it/screens/admin/adminHome.dart';
import 'package:buy_it/screens/admin/editProduct.dart';
import 'package:buy_it/screens/admin/manageProduct.dart';
import 'package:buy_it/screens/login_screen.dart';
import 'package:buy_it/screens/signup_screen.dart';
import 'package:buy_it/screens/user/CartScreen.dart';
import 'package:buy_it/screens/user/homePage.dart';
import 'package:buy_it/screens/user/productInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          OrdersScreen.id: (context) => OrdersScreen(),
          CartScreen.id: (context) => CartScreen(),
          ProductInfo.id: (context) => ProductInfo(),
          EditProduct.id: (context) => EditProduct(),
          ManageProducts.id: (context) => ManageProducts(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePage.id: (context) => HomePage(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
        },
      ),
    );
  }
}
