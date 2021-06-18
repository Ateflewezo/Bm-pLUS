class Offer {
  String name;
  String date;
  String id;
  String imageURL;
  double price;
  int persent;
  Offer({
    this.name,
    this.persent,
    this.imageURL,
    this.price,
    this.date,
  });
  Offer.fromMap(Map snapshot, String id)
      : id = id ?? '',
        price = snapshot['price'] ?? 00.0,
        date = snapshot['date'] ?? '',
        persent = snapshot['persent'] ?? 0,
        name = snapshot['name'] ?? '',
        imageURL = snapshot['imageURL'] ?? '';

  toJson() {
    return {
      "price": price,
      "date": date,
      "persent": persent,
      "name": name,
      "imageURL": imageURL,
    };
  }
}
