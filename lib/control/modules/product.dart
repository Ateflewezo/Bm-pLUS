class Product {
  String name;
  String id;
  String description;
  String imageURL;
  double price;
  String uid;
  int quantity = 1;
  Product({this.name, this.description, this.imageURL, this.price});
  Product.fromMap(Map snapshot, String id)
      : id = id ?? '',
        quantity = snapshot['quantity'] ?? 1,
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        imageURL = snapshot['imageURL'] ?? '';

  toJson() {
    return {
      "id": id,
      "quantity": quantity,
      "price": price,
      "name": name,
      "imageURL": imageURL,
    };
  }
}
