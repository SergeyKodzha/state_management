typedef ProductID = int;

class Product {
  final ProductID id;
  final String name;
  final String image;
  final String description;
  final num price;
  final int available;

  const Product(
      {required this.id,
      required this.name,
      required this.image,
      required this.description,
      required this.price,
      required this.available});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      available: json['available']);

}
