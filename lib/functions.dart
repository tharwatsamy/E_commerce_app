import 'models/product.dart';

List<Product> getProductByCategory(String kJackets, List<Product> allproducts) {
  List<Product> products = [];
  for (var product in allproducts) {
    if (product.pCategory == kJackets) {
      products.add(product);
    }
  }
  return products;
}
