import 'package:buy_it/models/product.dart';
import 'package:buy_it/screens/admin/editProduct.dart';
import 'package:buy_it/widgets/custom_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/constants.dart';

class ManageProducts extends StatefulWidget {
  static String id = 'ManageProducts';
  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              products.add(Product(
                  pId: doc.documentID,
                  pPrice: data[kProductPrice],
                  pName: data[kProductName],
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pCategory: data[kProductCategory]));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTapUp: (details) async {
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx2 = MediaQuery.of(context).size.width - dx;
                    double dy2 = MediaQuery.of(context).size.width - dy;
                    await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                        items: [
                          MyPopupMenuItem(
                            onClick: () {
                              Navigator.pushNamed(context, EditProduct.id,
                                  arguments: products[index]);
                            },
                            child: Text('Edit'),
                          ),
                          MyPopupMenuItem(
                            onClick: () {
                              _store.deleteProduct(products[index].pId);
                              Navigator.pop(context);
                            },
                            child: Text('Delete'),
                          ),
                        ]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('\$ ${products[index].pPrice}')
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }
}
