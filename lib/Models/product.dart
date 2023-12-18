class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  int quantity;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
    this.quantity = 1,
    required this.category,
  });

  void ChangeFavoriteStatus() {
    isFavorite = !isFavorite;
  }
}
