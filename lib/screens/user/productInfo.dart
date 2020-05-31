import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:buy_it/provider/cartItem.dart';
import 'package:buy_it/screens/user/CartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(product.pLocation),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: <Widget>[
                Opacity(
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .3,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.pName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            product.pDescription,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '\$${product.pPrice}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    onTap: add,
                                    child: SizedBox(
                                      child: Icon(Icons.add),
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                _quantity.toString(),
                                style: TextStyle(fontSize: 60),
                              ),
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    onTap: subtract,
                                    child: SizedBox(
                                      child: Icon(Icons.remove),
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  opacity: .5,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .08,
                  child: Builder(
                    builder: (context) => RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      color: kMainColor,
                      onPressed: () {
                        addToCart(context, product);
                      },
                      child: Text(
                        'Add to Cart'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.products;
    for (var productInCart in productsInCart) {
      if (productInCart.pName == product.pName) {
        exist = true;
      }
    }
    if (exist) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('you\'ve added this item before'),
      ));
    } else {
      cartItem.addProduct(product);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Added to Cart'),
      ));
    }
  }
}
