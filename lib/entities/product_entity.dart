

class ProductEntity {

  String id;
  String name;
  int price;
  String category;
  String? imageUrl;
  String? description;

  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.imageUrl,
    this.description,
  });

}