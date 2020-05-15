class Product {
  String pName;
  String pPrice;
  String pLocation;
  String pDescription;
  String pCategory;
  String pId;
  int pQuantity;
  Product(
      {this.pQuantity = 1,
      this.pId,
      this.pName,
      this.pCategory,
      this.pDescription,
      this.pLocation,
      this.pPrice});
}
