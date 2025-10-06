class Grocery {
  final int productId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isAddedToCart;
  bool isAddedToWishlist;

  Grocery({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isAddedToCart,
    required this.isAddedToWishlist,
  });
}
